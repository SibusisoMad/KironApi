using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models
{

    public class Navigation
    {
        public int ID { get; set; }
        public string Text { get; set; }
        public int ParentID { get; set; }
    }

}
