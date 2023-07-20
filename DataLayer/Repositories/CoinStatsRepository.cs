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
    public class CoinStatsRepository
    {
        private readonly IDbConnection dbConnection;

        public CoinStatsRepository(IDbConnection dbConnection)
        {
            this.dbConnection = dbConnection;
        }

        public void SaveCoinStats(CoinStats coinStats)
        {
            const string sql = @"INSERT INTO CoinStats (CoinName, Price, MarketCap) 
                                 VALUES (@CoinName, @Price, @MarketCap)";
            dbConnection.Execute(sql, coinStats);
        }

        public CoinStats GetCachedCoinStats()
        {
            const string sql = "SELECT TOP 1 * FROM CoinStats";
            return dbConnection.QueryFirstOrDefault<CoinStats>(sql);
        }
    }
}