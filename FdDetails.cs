using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OnlineBanking.Models
{
	public class FdDetails
	{
		public List<FdDetails> FdDetailList { get; set; }
		public long account_no { get; set; }
		public int deposit_id  {get ;set;}
	    public string fd_date { get; set; }
        public decimal fd_amount { get; set; }
	    public int duration { get; set; }
	    public decimal rate_of_interest { get; set; }
	    public string maturity_date { get; set; }
	    public decimal maturity_amount { get; set; }
	   public string nominee { get; set; }

	}
}