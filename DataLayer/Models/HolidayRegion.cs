using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models
{
    public class HolidayRegion
    {
        public int HolidayId { get; set; }
        public int RegionId { get; set; }
        

        
        public BankHoliday Holiday { get; set; }
        public Region Region { get; set; }
        public List<BankHoliday> Holidays { get; set; }
    }
}
