using DataLayer.Models;
using DataLayer.Repositories;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging;
using System;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

namespace KironApi.Services
{
    public class CoinStatsService
    {
        private readonly CoinStatsRepository coinStatsRepository;
        private readonly ILogger logger;
        private readonly IMemoryCache memoryCache;

        private readonly IConfiguration configuration;

        public CoinStatsService(CoinStatsRepository coinStatsRepository, ILogger<CoinStatsService> logger, IMemoryCache memoryCache, IConfiguration configuration)
        {
            this.coinStatsRepository = coinStatsRepository;
            this.logger = logger;
            this.memoryCache = memoryCache;
            this.configuration = configuration;
        }

        public async Task<CoinStats> GetCoinStats()
        {
            if (!memoryCache.TryGetValue("CoinStatsData", out CoinStats coinStatsData))
            {
                
                coinStatsData = await FetchCoinStatsFromAPI();

                if (coinStatsData != null)
                {
                    memoryCache.Set("CoinStatsData", coinStatsData, TimeSpan.FromHours(1));
                }
            }

            return coinStatsData;
        }

        private async Task<CoinStats> FetchCoinStatsFromAPI()
        {
            try
            {
                using (var httpClient = new HttpClient())
                {
                    
                    var apiUrl = configuration["AppSettings:UKBankHolidaysApiUrl"];
                    var response = await httpClient.GetAsync(apiUrl);

                    if (response.IsSuccessStatusCode)
                    {
                        var jsonContent = await response.Content.ReadAsStringAsync();
                        var coinStatsData = JsonSerializer.Deserialize<CoinStats>(jsonContent);

                        return coinStatsData;
                    }
                }
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while fetching coin stats from the API");
            }

            return null;
        }
    }
}
