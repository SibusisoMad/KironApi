using System;
using System.Collections.Generic;
using System.Data;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;
using Dapper;
using DataLayer.DAL;
using DataLayer.Models;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace DataLayer.Repositories
{
    public class BankHolidayRepository
    {
        private readonly DBConnectionManager dbConnectionManager;
        private readonly IMemoryCache memoryCache;
        private readonly HttpClient httpClient;
        private readonly ILogger logger;
        private readonly IConfiguration configuration;

        public BankHolidayRepository(DBConnectionManager dbConnectionManager, IMemoryCache memoryCache, ILogger logger, IConfiguration configuration)
        {
            this.dbConnectionManager = dbConnectionManager;
            this.memoryCache = memoryCache;
            this.logger = logger;
            this.configuration = configuration;

            httpClient = new HttpClient();
            httpClient.DefaultRequestHeaders.Add("User-Agent", "MinimalTrafficClient");
        }

        public async Task<IEnumerable<BankHoliday>> GetHolidaysWithRegions()
        {
            const string sql = @"
                SELECT * 
                FROM Holidays h
                LEFT JOIN HolidayRegion hr ON h.HolidayId = hr.HolidayId
                LEFT JOIN Regions r ON hr.RegionId = r.RegionId";

            var holidaysWithRegions = new Dictionary<int, BankHoliday>();

            using (var connection = dbConnectionManager.GetConnection())
            {
                try
                {
                    connection.Open();

                    var result = await connection.QueryAsync<BankHoliday, HolidayRegion, Region, BankHoliday>(
                        sql,
                        (bankHoliday, holidayRegion, region) =>
                        {
                            if (!holidaysWithRegions.TryGetValue(bankHoliday.HolidayId, out var holidayEntry))
                            {
                                holidayEntry = bankHoliday;
                                holidayEntry.HolidayRegions = new List<HolidayRegion>();
                                holidaysWithRegions.Add(bankHoliday.HolidayId, holidayEntry);
                            }

                            if (holidayRegion != null && region != null)
                            {
                                holidayRegion.Region = region;
                                holidayEntry.HolidayRegions.Add(holidayRegion);
                            }

                            return holidayEntry;
                        },
                        splitOn: "HolidayRegionId, RegionId"
                    );

                    return result.Distinct();
                }
                catch (Exception ex)
                {
                    logger.LogError(ex, "Error occurred while retrieving holidays with regions");
                    return Enumerable.Empty<BankHoliday>();
                }
            }
        }

        public async Task<IEnumerable<BankHoliday>> GetBankHolidays()
        {
            var cacheKey = "BankHolidaysCache";

            if (!memoryCache.TryGetValue(cacheKey, out IEnumerable<BankHoliday> bankHolidays))
            {
                bankHolidays = await LoadBankHolidaysFromDatabase();
                if (bankHolidays == null)
                {
                    bankHolidays = await LoadBankHolidaysFromAPI();
                    await SaveBankHolidaysToDatabase(bankHolidays);
                }

                memoryCache.Set(cacheKey, bankHolidays, TimeSpan.FromMinutes(30));
            }

            return bankHolidays;
        }

        private async Task<IEnumerable<BankHoliday>> LoadBankHolidaysFromDatabase()
        {
            using (var connection = dbConnectionManager.GetConnection())
            {
                try
                {
                    connection.Open();

                    var query = "SELECT * FROM BankHolidays";
                    var bankHolidays = await connection.QueryAsync<BankHoliday>(query);
                    return bankHolidays;
                }
                catch (Exception ex)
                {
                    
                    logger.LogError(ex, "Error occurred while retrieving bank holidays from the database");
                    throw ;
                }
            }

            return null;
        }

        public async Task<IEnumerable<BankHoliday>> LoadBankHolidaysFromAPI()
        {
            try
            {
                var apiUrl = configuration["AppSettings:UKBankHolidaysApiUrl"];

                var response = await httpClient.GetAsync(apiUrl);
                response.EnsureSuccessStatusCode();

                var content = await response.Content.ReadAsStringAsync();

                var options = new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true,
                    PropertyNamingPolicy = JsonNamingPolicy.CamelCase
                };

                var bankHolidayData = JsonSerializer.Deserialize<Dictionary<string, BankHolidayData>>(content, options);

                var bankHolidays = new List<BankHoliday>();
                foreach (var division in bankHolidayData)
                {
                    foreach (var eventItem in division.Value.Events)
                    {
                        var bankHoliday = new BankHoliday
                        {
                            HolidayName = eventItem.Title,
                            HolidayDate = eventItem.Date,
                            Region = division.Value.Division
                        };
                        bankHolidays.Add(bankHoliday);
                    }
                }

                return bankHolidays;

            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving bank holidays from the API");
                throw;
            }
        }

        public async Task SaveBankHolidaysToDatabase(IEnumerable<BankHoliday> bankHolidays)
        {
            using (var connection = dbConnectionManager.GetConnection())
            {
                try
                {
                    connection.Open();

                    foreach (var bankHoliday in bankHolidays)
                    {
                        var query = "INSERT INTO Holidays (Name, Date, Region) VALUES (@Name, @Date, @Region)";

                        await connection.ExecuteAsync(query, new
                        {
                            Name = bankHoliday.HolidayName,
                            Date = bankHoliday.HolidayDate,
                            Region = bankHoliday.Region
                        });
                    }
                }
                catch (Exception ex)
                {
                    logger.LogError(ex, "Error occurred while saving bank holidays to the database");
                    throw;
                }
            }
        }


    }
}
