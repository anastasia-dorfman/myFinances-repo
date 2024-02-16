using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MyFinances.Model
{
    public class Retailer
    {
        [Display(Name = "Id")]
        public int RetailerId { get; set; }

        [Required(ErrorMessage = "Name is required.")]
        [StringLength(40, ErrorMessage = "Name cannot exceed 40 characters in length.")]
        public string? Name { get; set; }
    }
}
