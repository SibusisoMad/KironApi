using Dapper;
using DataLayer.Models;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging;
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
        private readonly IMemoryCache memoryCache;

        public CoinStatsRepository(IDbConnection dbConnection, IMemoryCache memoryCache)
        {
            this.dbConnection = dbConnection;
            this.memoryCache = memoryCache;
        }

        public void SaveCoinStats(CoinStats coinStats)
        {
            const string sql = "dbo.spt_SaveCoinStats";
            dbConnection.Execute(sql, coinStats);

            memoryCache.Remove("CoinStatsData");
        }

        public CoinStats GetCachedCoinStats()
        {
            if (!memoryCache.TryGetValue("CoinStatsData", out CoinStats coinStatsData))
            {
                const string sql = "spt_GetCachedCoinStats";
                coinStatsData = dbConnection.QueryFirstOrDefault<CoinStats>(sql);

                if (coinStatsData != null)
                {
                    
                    memoryCache.Set("CoinStatsData", coinStatsData, TimeSpan.FromHours(1));
                }
            }

            return coinStatsData;
        }
    }
}
