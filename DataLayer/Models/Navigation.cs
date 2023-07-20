using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models
{
    public class Navigation
    {
        public int Id { get; set; }
        public string? NavText { get; set; }
        public int ParentID { get; set; }
    }
}
