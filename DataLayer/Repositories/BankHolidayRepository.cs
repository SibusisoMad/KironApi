using Dapper;
using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public class BankHolidayRepository
    {
        private readonly IDbConnection dbConnection;

        public BankHolidayRepository(IDbConnection dbConnection)
        {
            this.dbConnection = dbConnection;
        }

        public void CreateBankHoliday(BankHoliday bankHoliday)
        {
            const string sql = @"INSERT INTO BankHolidays (Name, Date) 
                                 VALUES (@Name, @Date)";
            dbConnection.Execute(sql, bankHoliday);
        }

        public IEnumerable<BankHoliday> GetBankHolidaysForRegion(int regionId)
        {
            const string sql = @"SELECT bh.* FROM BankHolidays bh
                                 JOIN RegionBankHolidays rbh ON bh.Id = rbh.BankHolidayId
                                 WHERE rbh.RegionId = @RegionId";
            return dbConnection.Query<BankHoliday>(sql, new { RegionId = regionId });
        }
    }
}