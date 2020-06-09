using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace OnlineBanking.Models
{
    public class FixedDepositClass
    {
        [Required(ErrorMessage ="Please enter the Amount")]
        [Display(Name ="Fixed Deposit Amount")]
        public long fd_amount { get; set; }
     
        [Required(ErrorMessage = "Please enter the Amount")]
        [Display(Name = "Fixed deposit Duration(in months)")]
        public DateTime duration { get; set; }

        [Required(ErrorMessage = "Please enter the Nominee")]
        [Display(Name = "Name of the Nominee")]
        public string nominee { get; set; }

    }
}