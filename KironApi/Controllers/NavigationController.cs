using DataLayer.Models;
using KironApi.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace KironApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NavigationController : ControllerBase
    {
        private readonly NavigationService navigationService;
        private readonly ILogger logger;

        public NavigationController(NavigationService navigationService, ILogger<NavigationController> logger)
        {
            this.navigationService = navigationService;
            this.logger = logger;
        }

        [HttpGet]
        public IActionResult GetNavigationData()
        {
            try
            {
                var navigationTree = navigationService.GetNavigationTree();
                return Ok(navigationTree);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving navigation data");
                return StatusCode(500, "An error occurred while retrieving navigation data.");
            }
        }
    }
}
