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
    public class RegionRepository
    {
        private readonly IDbConnection dbConnection;

        public RegionRepository(IDbConnection dbConnection)
        {
            this.dbConnection = dbConnection;
        }

        public IEnumerable<Region> GetAllRegions()
        {
            const string sql = "SELECT * FROM Regions";
            return dbConnection.Query<Region>(sql);
        }
    }
}
