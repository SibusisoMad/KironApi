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
            const string sql = "spt_GetAllRegions";
            return dbConnection.Query<Region>(sql, commandType: CommandType.StoredProcedure);
        }

        public Region GetRegionById(int id)
        {
            const string sql = "spt_GetRegionById";
            var parameters = new { Id = id };
            return dbConnection.QuerySingleOrDefault<Region>(sql, parameters, commandType: CommandType.StoredProcedure);
        }

        public Region GetRegionByName(string name)
        {
            const string sql = "spt_GetRegionByName";
            var parameters = new { Name = name };
            return dbConnection.QuerySingleOrDefault<Region>(sql, parameters, commandType: CommandType.StoredProcedure);
        }

        public void SaveRegion(Region region)
        {
            const string sql = "EXEC spt_InsertRegion @Name";
            int regionId = dbConnection.ExecuteScalar<int>(sql, region);
            region.Id = regionId;
        }

        public void UpdateRegion(Region region)
        {
            const string sql = "EXEC spt_UpdateRegion @Id, @Name";
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
                        var region = dbConnection.QuerySingleOrDefault<Region>("spt_GetRegionById", new { RegionId = regionId });

                        if (region == null)
                        {
                            var regionHolidays = bankHolidayRepository.LoadBankHolidaysFromAPI().Result;
                            var distinctRegions = regionHolidays.Select(bh => bh.Region).Distinct();

                            const string insertRegionSql = "InsertRegion";
                            const string mapRegionsSql = "spt_RegionsWithBankHolidays";

                            foreach (var distinctRegion in distinctRegions)
                            {
                                dbConnection.Execute(insertRegionSql, new { Name = distinctRegion, Description = "Some description" }, commandType: CommandType.StoredProcedure);
                            }

                            var regionsTable = new DataTable();
                            regionsTable.Columns.Add("Item", typeof(string));
                            foreach (var distinctRegion in distinctRegions)
                            {
                                regionsTable.Rows.Add(distinctRegion);
                            }

                            dbConnection.Execute(mapRegionsSql, new { RegionId = regionId, Regions = regionsTable.AsTableValuedParameter("dbo.StringList") }, commandType: CommandType.StoredProcedure);
                        }
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
            const string sql = "spt_GetBankHolidaysForRegion";
            var parameters = new { RegionId = regionId };
            return dbConnection.Query<BankHoliday>(sql, parameters, commandType: CommandType.StoredProcedure);
        }

        public void UpdateBankHolidaysForRegion(int regionId, IEnumerable<BankHoliday> bankHolidays)
        {
            const string sql = "spt_UpdateBankHolidaysForRegion";

            var dataTable = new DataTable();
            dataTable.Columns.Add("HolidayId", typeof(int));
            foreach (var bh in bankHolidays)
            {
                dataTable.Rows.Add(bh.HolidayId);
            }

            var parameters = new { RegionId = regionId, BankHolidays = dataTable.AsTableValuedParameter("dbo.BankHolidayType") };

            dbConnection.Execute(sql, parameters, commandType: CommandType.StoredProcedure);
        }

        public void DeleteRegion(int regionId)
        {
            const string sql = "spt_DeleteRegion";
            var parameters = new { RegionId = regionId };
            dbConnection.Execute(sql, parameters, commandType: CommandType.StoredProcedure);
        }
    }
}
