﻿using DataLayer.Models;
using DataLayer.Repositories;

namespace KironApi.Services
{
    public class BankHolidayService
    {
        private readonly BankHolidayRepository bankHolidayRepository;
        private readonly ILogger<BankHolidayService> logger;

        public BankHolidayService(BankHolidayRepository bankHolidayRepository, ILogger<BankHolidayService> logger)
        {
            this.bankHolidayRepository = bankHolidayRepository;
            this.logger = logger;
        }

        public async Task<IEnumerable<BankHoliday>> GetBankHoliday()
        {
            try
            {
                return await bankHolidayRepository.GetBankHolidays();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving bank holidays");

                return new List<BankHoliday>
                {
                    new BankHoliday { HolidayName = "Error", HolidayDate = DateTime.Now, Region = "Error" }
                };
            }
        }

        public async Task<IEnumerable<BankHoliday>> GetHolidaysWithRegions()
        {
            try
            {
                return await bankHolidayRepository.GetHolidaysWithRegions();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving holidays with regions");

                return new List<BankHoliday>
                {
                    new BankHoliday { HolidayName = "Error", HolidayDate = DateTime.Now, Region = "Error" }
                };
            }
        }

        public async Task UpdateBankHolidaysFromAPI()
        {
            var bankHolidays = await bankHolidayRepository.GetBankHolidays();

        }
    }
}