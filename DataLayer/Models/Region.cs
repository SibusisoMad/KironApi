﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models
{
    public class Region
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public List<HolidayRegion> HolidayRegions { get; set; }
    }
}
