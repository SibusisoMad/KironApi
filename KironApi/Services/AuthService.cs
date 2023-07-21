using DataLayer.Repositories;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace KironApi.Services
{
    public class AuthService
    {
        private readonly UserRepository userRepository;
        private readonly string secretKey;
        private readonly double tokenExpiryHours;
        private readonly ILogger<AuthService> logger;

        public AuthService(UserRepository userRepository, string secretKey, double tokenExpiryHours, ILogger<AuthService> logger)
        {
            this.userRepository = userRepository;
            this.secretKey = secretKey;
            this.tokenExpiryHours = tokenExpiryHours;
            this.logger = logger;
        }

        public async Task<string> AuthenticateUser(string username, string password)
        {
            try
            {
                
                var hashedPassword = await userRepository.GetHashedPasswordByUsername(username);

               
                if (PasswordVerification(password, hashedPassword))
                {
                   
                    return GenerateJwtToken(username);
                }

                return null;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred during user authentication");
                throw;
            }
        }

        private string GenerateJwtToken(string username)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(secretKey);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim(ClaimTypes.Name, username)
                }),
                Expires = DateTime.UtcNow.AddHours(tokenExpiryHours),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }

        private bool PasswordVerification(string inputPassword, string hashedPassword)
        {
            return inputPassword == hashedPassword;
        }
    }
}
