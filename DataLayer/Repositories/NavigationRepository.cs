using Dapper;
using DataLayer.Models;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

namespace DataLayer.Repositories
{
    public class NavigationRepository
    {
        private readonly IDbConnection dbConnection;
        private readonly ILogger logger;

        public NavigationRepository(IDbConnection dbConnection, ILogger<NavigationRepository> logger)
        {
            this.dbConnection = dbConnection;
            this.logger = logger;
        }

        public IEnumerable<Navigation> GetAllNavigations()
        {
            try
            {
                const string sql = "spt_GetAllNavigations";
                return dbConnection.Query<Navigation>(sql);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error occurred while retrieving navigation data");
                throw;
            }
        }
    }
}
