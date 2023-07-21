using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models
{
    public class BankHolidayData
    {
        public string Division { get; set; }
        public List<BankHolidayEvent> Events { get; set; }

        public class BankHolidayEvent
        {
            public string Title { get; set; }
            public DateTime Date { get; set; }
            public string Notes { get; set; }
            public bool Bunting { get; set; }
        }
    }
}
