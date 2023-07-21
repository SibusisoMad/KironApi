using DataLayer.Models;
using KironApi.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;

namespace KironApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegionController : ControllerBase
    {
        private readonly RegionService regionService;
        private readonly ILogger logger;

        public RegionController(RegionService regionService, ILogger<RegionController> logger)
        {
            this.regionService = regionService;
            this.logger = logger;
        }

        [HttpGet]
        public IActionResult GetAllRegions()
        {
            try
            {
                var regions = regionService.GetAllRegions();
                return Ok(regions);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving all regions");
                return StatusCode(500, "An error occurred while retrieving all regions.");
            }
        }

        [HttpGet("{id}")]
        public IActionResult GetRegionById(int id)
        {
            try
            {
                var region = regionService.GetRegionById(id);
                if (region == null)
                {
                    return NotFound();
                }
                return Ok(region);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while retrieving region with Id: {id}");
                return StatusCode(500, $"An error occurred while retrieving region with Id: {id}.");
            }
        }

        [HttpGet("name/{name}")]
        public IActionResult GetRegionByName(string name)
        {
            try
            {
                var region = regionService.GetRegionByName(name);
                if (region == null)
                {
                    return NotFound();
                }
                return Ok(region);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while retrieving region with Name: {name}");
                return StatusCode(500, $"An error occurred while retrieving region with Name: {name}.");
            }
        }

        [HttpPost]
        public IActionResult CreateRegion(Region region)
        {
            try
            {
                regionService.CreateRegion(region);
                return Ok(region);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while creating region");
                return StatusCode(500, "An error occurred while creating region.");
            }
        }

        [HttpGet("region")]
        public IActionResult CreateRegions()
        {
            try
            {
                regionService.CreateRegions();
                return Ok();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while creating regions");
                return StatusCode(500, "An error occurred while creating regions.");
            }
        }

        [HttpPut("{id}")]
        public IActionResult UpdateRegion(int id, Region region)
        {
            try
            {
                if (id != region.Id)
                {
                    return BadRequest("Region Id mismatch");
                }

                regionService.UpdateRegion(region);
                return Ok(region);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while updating region with Id: {id}");
                return StatusCode(500, $"An error occurred while updating region with Id: {id}.");
            }
        }

        [HttpDelete("{id}")]
        public IActionResult DeleteRegion(int id)
        {
            try
            {
                regionService.DeleteRegion(id);
                return Ok();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while deleting region with Id: {id}");
                return StatusCode(500, $"An error occurred while deleting region with Id: {id}.");
            }
        }

        [HttpGet("{regionId}/bankholidays")]
        public IActionResult GetBankHolidaysForRegion(int regionId)
        {
            try
            {
                var bankHolidays = regionService.GetBankHolidaysForRegion(regionId);
                return Ok(bankHolidays);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while retrieving bank holidays for region with Id: {regionId}");
                return StatusCode(500, $"An error occurred while retrieving bank holidays for region with Id: {regionId}.");
            }
        }

        [HttpPost("{regionId}/bankholidays")]
        public IActionResult SaveBankHolidaysForRegion(int regionId, IEnumerable<BankHoliday> bankHolidays)
        {
            try
            {
                regionService.SaveBankHolidaysForRegion(regionId, bankHolidays);
                return Ok();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while saving bank holidays for region with Id: {regionId}");
                return StatusCode(500, $"An error occurred while saving bank holidays for region with Id: {regionId}.");
            }
        }

        [HttpPut("{regionId}/bankholidays")]
        public IActionResult UpdateBankHolidaysForRegion(int regionId, IEnumerable<BankHoliday> bankHolidays)
        {
            try
            {
                regionService.UpdateBankHolidaysForRegion(regionId, bankHolidays);
                return Ok();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, $"Error occurred while updating bank holidays for region with Id: {regionId}");
                return StatusCode(500, $"An error occurred while updating bank holidays for region with Id: {regionId}.");
            }
        }
    }
}
