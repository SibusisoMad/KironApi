using DataLayer.Models;
using DataLayer.Repositories;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;

namespace KironApi.Services
{
    public class RegionService
    {
        private readonly RegionRepository regionRepository;
        private readonly ILogger logger;
        private readonly BankHolidayRepository bankHolidayRepository;

        public RegionService(RegionRepository regionRepository, ILogger<RegionService> logger, BankHolidayRepository bankHolidayRepository)
        {
            this.regionRepository = regionRepository;
            this.logger = logger;
            this.bankHolidayRepository = bankHolidayRepository;
        }

        public IEnumerable<Region> GetAllRegions()
        {
            try
            {
                var regions = regionRepository.GetAllRegions();
                return regions;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving all regions");
                throw;
            }
        }

        public Region GetRegionById(int id)
        {
            try
            {
                var region = regionRepository.GetRegionById(id);
                return region;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while retrieving region with Id: {id}");
                throw;
            }
        }

        public Region GetRegionByName(string name)
        {
            try
            {
                var region = regionRepository.GetRegionByName(name);
                return region;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while retrieving region with Name: {name}");
                throw;
            }
        }

        public void CreateRegion(Region region)
        {
            try
            {
                regionRepository.SaveRegion(region);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while creating region");
                throw;
            }
        }
        public void CreateRegions()
        {
            try
            {
                var allRegions = regionRepository.GetAllRegions();
                if (!allRegions.Any())
                {
                    var regionHolidays = bankHolidayRepository.LoadBankHolidaysFromAPI().Result;
                    var distinctRegions = regionHolidays.Select(bh => bh.Region).Distinct();

                    const string regionSql = "spt_InsertRegions";
                    foreach (var distinctRegion in distinctRegions)
                    {
                        regionRepository.SaveRegion(new Region { Name = distinctRegion });
                    }
                }
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while creating regions");
                throw;
            }
        }

        public void UpdateRegion(Region region)
        {
            try
            {
                regionRepository.UpdateRegion(region);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while updating region with Id: {region.Id}");
                throw;
            }
        }


        public void DeleteRegion(int regionId)
        {
            try
            {
                regionRepository.DeleteRegion(regionId);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while deleting region with Id: {regionId}");
                throw;
            }
        }


        public void SaveBankHolidaysForRegion(int regionId, IEnumerable<BankHoliday> bankHolidays)
        {
            try
            {
                regionRepository.SaveBankHolidaysForRegion(regionId, bankHolidays);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while saving bank holidays for region with Id: {regionId}");
                throw;
            }
        }

        public IEnumerable<BankHoliday> GetBankHolidaysForRegion(int regionId)
        {
            try
            {
                var bankHolidays = regionRepository.GetBankHolidaysForRegion(regionId);
                return bankHolidays;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while retrieving bank holidays for region with Id: {regionId}");
                throw;
            }
        }

        public void UpdateBankHolidaysForRegion(int regionId, IEnumerable<BankHoliday> bankHolidays)
        {
            try
            {
                regionRepository.UpdateBankHolidaysForRegion(regionId, bankHolidays);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while updating bank holidays for region with Id: {regionId}");
                throw;
            }
        }
    }
}
