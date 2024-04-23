using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Pixel_Play
{
	public class CartHelper
	{
		public static int GetCartCount()
		{
			// Retrieve the current cart count from the session
			int cartCount = 0;
			if (HttpContext.Current.Session["cartCount"] != null)
			{
				cartCount = (int)HttpContext.Current.Session["cartCount"];
			}

			return cartCount;
		}

		public static void SetCartCount(int cartCount)
		{
			// Store the updated cart count in the session
			HttpContext.Current.Session["cartCount"] = cartCount;
		}
	}

}