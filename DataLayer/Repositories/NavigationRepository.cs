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
    public class NavigationRepository
    {
        private readonly IDbConnection dbConnection;

        public NavigationRepository(IDbConnection dbConnection)
        {
            this.dbConnection = dbConnection;
        }

        public IEnumerable<Navigation> GetAllNavigations()
        {
            const string sql = "SELECT * FROM Navigation";
            return dbConnection.Query<Navigation>(sql);
        }
    }
}