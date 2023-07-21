using KironApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace KironApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BankHolidayController : ControllerBase
    {
        private readonly BankHolidayService bankHolidayService;
        private readonly ILogger<BankHolidayController> logger;

        public BankHolidayController(BankHolidayService bankHolidayService, ILogger<BankHolidayController> logger)
        {
            this.bankHolidayService = bankHolidayService;
            this.logger = logger;
        }

        [HttpGet]
        public async Task<IActionResult> GetBankHolidays()
        {
            try
            {
                var bankHolidays = await bankHolidayService.GetBankHolidays();
                return Ok(bankHolidays);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving bank holidays");
                return StatusCode(500, new { Error = "An error occurred while retrieving bank holidays." });
            }
        }
    }
}
