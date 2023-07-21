using DataLayer.Models;
using DataLayer.Repositories;
using KironApi.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;
using System.Text;

namespace KironApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserRepository userRepository;
        private readonly AuthService authService;
        private readonly ILogger<UserController> logger;

        public UserController(UserRepository userRepository, AuthService authService, ILogger<UserController> logger)
        {
            this.userRepository = userRepository;
            this.authService = authService;
            this.logger = logger;
        }

        [HttpPost("register")]
        public IActionResult RegisterUser([FromBody] UserRegistrationModel model )
        {
            try
            {
                if (model.User == null || string.IsNullOrEmpty(model.Password))
                {
                    return BadRequest("Invalid user registration data");
                }

                byte[] hashedPassword = GetHashedPassword(model.Password);
                model.User.PasswordHash = hashedPassword;

                bool isUserCreated = userRepository.CreateUser(model.User, model.Password);

                if (!isUserCreated)
                {
                    return Ok("User registered successfully");
                }
                else
                {
                    return StatusCode(500, "Failed to register user");
                }
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while registering user");
                return StatusCode(500, "An error occurred while registering user");
            }
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest loginRequest)
        {
            try
            {
                if (loginRequest == null || string.IsNullOrEmpty(loginRequest.Username) || string.IsNullOrEmpty(loginRequest.Password))
                {
                    return BadRequest("Invalid request");
                }

                string username = loginRequest.Username;
                string password = loginRequest.Password;

                string token = await authService.AuthenticateUser(username, password);

                if (string.IsNullOrEmpty(token))
                {
                    return Unauthorized("Invalid username or password");
                }

                return Ok(new { Token = token });
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while logging in");
                return StatusCode(500, "An error occurred while logging in");
            }
        }

        private byte[] GetHashedPassword(string password)
        {
            using var sha256 = SHA256.Create();
            return sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
        }
    }
}
