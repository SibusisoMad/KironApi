using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models
{
    public class BankHoliday
    {
        public DateTime HolidayDate { get; set; }
        public string HolidayName { get; set; }

        public string Region { get; set; }
    }
}
