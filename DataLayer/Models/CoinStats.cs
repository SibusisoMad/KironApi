using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models
{
    public class CoinStats
    {
        public string? CoinName { get; set; }
        public double Price { get; set; }
        public double MarketCap { get; set; }
    }
}
