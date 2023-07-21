using KironApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace KironApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CoinStatsController : ControllerBase
    {
        private readonly CoinStatsService coinStatsService;
        private readonly ILogger logger;

        public CoinStatsController(CoinStatsService coinStatsService, ILogger<CoinStatsController> logger)
        {
            this.coinStatsService = coinStatsService;
            this.logger = logger;
        }

        [HttpGet]
        public async Task<IActionResult> GetCoinStats()
        {
            try
            {
                var coinStatsData = await coinStatsService.GetCoinStats();
                return Ok(coinStatsData); 
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving coin stats");
                return StatusCode(500, "An error occurred while retrieving coin stats.");
            }
        }
    }
}
