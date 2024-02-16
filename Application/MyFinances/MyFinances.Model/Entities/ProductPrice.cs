using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFinances.Model
{
    public class ProductPrice
    {
        //public int ProductId { get; set; }
        public DateTime Date { get; set; }
        public int RetailerId { get; set; }
        public string RetailerName { get; set; }
        public decimal Price { get; set; }
    }
}
