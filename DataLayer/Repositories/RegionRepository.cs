using Dapper;
using DataLayer.Models;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace DataLayer.Repositories
{
    public class RegionRepository
    {
        private readonly IDbConnection dbConnection;
        private readonly ILogger<RegionRepository> logger;
        private readonly BankHolidayRepository bankHolidayRepository;

        public RegionRepository(IDbConnection dbConnection, ILogger<RegionRepository> logger, BankHolidayRepository bankHolidayRepository)
        {
            this.dbConnection = dbConnection;
            this.logger = logger;
            this.bankHolidayRepository = bankHolidayRepository;
        }

        public IEnumerable<Region> GetAllRegions()
        {
            const string sql = "SELECT * FROM Regions";
            return dbConnection.Query<Region>(sql);
        }

        public Region GetRegionById(int id)
        {
            const string sql = "SELECT * FROM Regions WHERE Id = @Id";
            return dbConnection.QuerySingleOrDefault<Region>(sql, new { Id = id });
        }

        public Region GetRegionByName(string name)
        {
            const string sql = "SELECT * FROM Regions WHERE Name = @Name";
            return dbConnection.QuerySingleOrDefault<Region>(sql, new { Name = name });
        }

        public void SaveRegion(Region region)
        {
            const string sql = @"INSERT INTO Regions (Name) VALUES (@Name);
                                 SELECT CAST(SCOPE_IDENTITY() as int)";
            int regionId = dbConnection.ExecuteScalar<int>(sql, region);
            region.Id = regionId;
        }

        public void UpdateRegion(Region region)
        {
            const string sql = "UPDATE Regions SET Name = @Name WHERE Id = @Id";
            dbConnection.Execute(sql, region);
        }

        public void SaveBankHolidaysForRegion(int regionId, IEnumerable<BankHoliday> bankHolidays)
        {
            using (var transaction = dbConnection.BeginTransaction())
            {
                try
                {
                    if (bankHolidays != null && bankHolidays.Any())
                    {
                        const string holidaysSql = @"INSERT INTO Holidays (Name, Date, Region)
                                                   VALUES (@Name, @Date, @Region)";
                        dbConnection.Execute(holidaysSql, bankHolidays);
                    }

                    var region = dbConnection
                        .QuerySingleOrDefault<Region>("SELECT * FROM Region WHERE RegionId = @RegionId", new { RegionId = regionId });

                    if (region == null)
                    {
                        var regionHolidays = bankHolidayRepository.LoadBankHolidaysFromAPI().Result;
                        var distinctRegions = regionHolidays.Select(bh => bh.Region).Distinct();

                        const string regionSql = @"INSERT INTO Region (RegionName, Description)
                                                   VALUES (@RegionName, @Description)";
                        foreach (var distinctRegion in distinctRegions)
                        {
                            dbConnection.Execute(regionSql, new { RegionName = distinctRegion, Description = "Some description" });
                        }
                        const string mappingSql = @"INSERT INTO RegionBankHolidays (RegionId, HolidayId)
                                                    SELECT @RegionId, Id FROM Holidays
                                                    WHERE Region IN @Regions";
                        dbConnection.Execute(mappingSql, new { RegionId = regionId, Regions = distinctRegions });
                    }

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    logger.LogError(ex, $"Error occurred while saving bank holidays for region with Id: {regionId}");
                    throw;
                }
            }
        }

        public IEnumerable<BankHoliday> GetBankHolidaysForRegion(int regionId)
        {
            const string sql = "SELECT * FROM RegionBankHolidays WHERE RegionId = @RegionId";
            return dbConnection.Query<BankHoliday>(sql, new { RegionId = regionId });
        }

        public void UpdateBankHolidaysForRegion(int regionId, IEnumerable<BankHoliday> bankHolidays)
        {

            const string deleteSql = "DELETE FROM RegionBankHolidays WHERE RegionId = @RegionId";
            dbConnection.Execute(deleteSql, new { RegionId = regionId });

            SaveBankHolidaysForRegion(regionId, bankHolidays);
        }

        public void DeleteRegion(int regionId)
        {
            const string sql = "DELETE FROM Regions WHERE Id = @Id";
            dbConnection.Execute(sql, new { Id = regionId });
        }
    }
}
