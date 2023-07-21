using Dapper;
using DataLayer.Models;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public class UserRepository
    {
        private readonly IDbConnection dbConnection;
        private readonly ILogger<UserRepository> logger;

        public UserRepository(IDbConnection dbConnection, ILogger<UserRepository> logger)
        {
            this.dbConnection = dbConnection;
            this.logger = logger;
        }

        public bool CreateUser(User user, string password)
        {
            try
            {

                user.PasswordHash = HashPassword(password);
                const string sql = @"INSERT INTO Users (Username, PasswordHash) 
                                     VALUES (@Username, @PasswordHash)";
                dbConnection.Execute(sql, user);
                return true;
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while creating user");
                return false;
            }
        }

        public async Task<User> GetUserByUsername(string username)
        {
            try
            {
                const string sql = "SELECT * FROM Users WHERE Username = @Username";
                return await dbConnection.QuerySingleOrDefaultAsync<User>(sql, new { Username = username });
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving user");
                throw;
            }
        }

        public async Task<byte[]> GetHashedPasswordByUsername(string username)
        {
            try
            {
                const string sql = "SELECT PasswordHash FROM Users WHERE Username = @Username";
                return await dbConnection.QuerySingleOrDefaultAsync<byte[]>(sql, new { Username = username });
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving hashed password");
                throw;
            }
        }

        private byte[] HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {

                byte[] passwordBytes = Encoding.UTF8.GetBytes(password);

                byte[] hashBytes = sha256.ComputeHash(passwordBytes);

                return hashBytes;
            }
        }

        public async Task<byte[]> GetHashedPasswordByUsernameAsync(string username)
        {
            try
            {
                const string sql = "SELECT PasswordHash FROM Users WHERE Username = @Username";
                return await dbConnection.QuerySingleOrDefaultAsync<byte[]>(sql, new { Username = username });
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving hashed password");
                throw;
            }
        }

        //public bool VerifyPassword(string inputPassword, string hashedPassword)
        //{
        //    string inputHash = HashPassword(inputPassword);
        //    return inputHash.Equals(hashedPassword, StringComparison.OrdinalIgnoreCase);
        //}
    }
}
