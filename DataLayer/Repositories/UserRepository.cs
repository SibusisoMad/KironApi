using Dapper;
using DataLayer.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Repositories
{
    public class UserRepository
    {
        private readonly IDbConnection dbConnection;

        public UserRepository(IDbConnection dbConnection)
        {
            this.dbConnection = dbConnection;
        }

        public void CreateUser(User user)
        {
            const string sql = @"INSERT INTO Users (Username, PasswordHash) 
                                 VALUES (@Username, @PasswordHash)";
            dbConnection.Execute(sql, user);
        }

        public User GetUserByUsername(string username)
        {
            const string sql = "SELECT * FROM Users WHERE Username = @Username";
            return dbConnection.QuerySingleOrDefault<User>(sql, new { Username = username });
        }
    }
}
