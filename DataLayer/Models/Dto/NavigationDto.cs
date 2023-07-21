using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataLayer.Models.Dto
{
    public class NavigationDto
    {
        public string Text { get; set; }
        public List<NavigationDto> Children { get; set; }
    }
}
