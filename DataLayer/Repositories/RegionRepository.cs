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

        public void CreateRegion(Region region)
        {
            try
            {
                var regions = new Region();
                if (regions != null && regions.HolidayRegions == null)
                {
                    var bankHolidays = region.HolidayRegions?.Select(hr => hr.Holiday)?.ToList();
                    if (bankHolidays != null && bankHolidays.Any())
                    {
                        var regionHolidays = bankHolidayRepository.LoadBankHolidaysFromAPI().Result;
                        var distinctRegions = regionHolidays.Select(bh => bh.Region).Distinct();

                        const string regionSql = @"INSERT INTO Region (RegionName, Description)
                                          VALUES (@RegionName, @Description)";
                        foreach (var distinctRegion in distinctRegions)
                        {
                            dbConnection.Execute(regionSql, new { RegionName = distinctRegion, Description = "Some description" });
                        }

                        region.HolidayRegions = distinctRegions.Select(distinctRegion => new HolidayRegion
                        {
                            RegionId = region.Id,
                            Holiday = bankHolidays.FirstOrDefault(bh => bh.Region == distinctRegion)
                        }).ToList();
                    }
                }

                // Insert the region data into the "Region" table
                const string sql = @"INSERT INTO Regions (Name) VALUES (@Name);
                             SELECT CAST(SCOPE_IDENTITY() as int)";
                int regionId = dbConnection.ExecuteScalar<int>(sql, region);
                region.Id = regionId;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while creating the region");
                throw;
            }
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
                        // Step 1: Insert the bank holidays data into the "Holidays" table
                        const string holidaysSql = @"INSERT INTO Holidays (Name, Date, Region)
                                                   VALUES (@Name, @Date, @Region)";
                        dbConnection.Execute(holidaysSql, bankHolidays);
                    }

                    // Step 2: Check if the region data is null or empty
                    var region = dbConnection
                        .QuerySingleOrDefault<Region>("SELECT * FROM Region WHERE RegionId = @RegionId", new { RegionId = regionId });

                    if (region == null)
                    {
                        // Step 3: If region data is null, fetch it from the external API
                        var regionHolidays = bankHolidayRepository.LoadBankHolidaysFromAPI().Result;
                        var distinctRegions = regionHolidays.Select(bh => bh.Region).Distinct();

                        // Step 4: Insert the fetched region data into the "Region" table
                        const string regionSql = @"INSERT INTO Region (RegionName, Description)
                                                   VALUES (@RegionName, @Description)";
                        foreach (var distinctRegion in distinctRegions)
                        {
                            dbConnection.Execute(regionSql, new { RegionName = distinctRegion, Description = "Some description" });
                        }

                        // Step 5: Insert the mapping data into the "RegionBankHolidays" table
                        const string mappingSql = @"INSERT INTO RegionBankHolidays (RegionId, HolidayId)
                                                    SELECT @RegionId, Id FROM Holidays
                                                    WHERE Region IN @Regions";
                        dbConnection.Execute(mappingSql, new { RegionId = regionId, Regions = distinctRegions });
                    }

                    // Commit the transaction if all steps succeed
                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    // Rollback the transaction if any step fails
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
