using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.DAL
{
    public class DBConnectionManager
    {
        private readonly string connectionString;

        public DBConnectionManager(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public IDbConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }
    }
}
