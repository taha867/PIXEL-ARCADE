using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Web.UI.HtmlControls;

namespace Pixel_Play
{
    public partial class WebForm4 : System.Web.UI.Page
    {
		protected void Page_Load(object sender, EventArgs e)
		{
			if (!IsPostBack)
			{
                if (Session["FirstName"] == null)
                {
                    // user is not logged in, redirect to the login page
                    Response.Redirect("WebForm1.aspx");
                    return;
                }
                else
                {
                    // user is logged in, retrieve the email from the session variable
                    string username = Session["FirstName"].ToString();
                    // use the email to personalize the content of the page
                    TextBox1.Text = username;
                }
                string connectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS02;initial catalog=project12;integrated Security=true";
				string query = "SELECT ItemID,Itemname,Price,Description,imageurl FROM Gamespc";
				SqlConnection connection = new SqlConnection(connectionString);

				SqlCommand command = new SqlCommand(query, connection);

				connection.Open();
				SqlDataReader reader = command.ExecuteReader();
				reptProduct.DataSource = reader;
				reptProduct.DataBind();
				connection.Close();

				// Retrieve the cart count from the session and display it
				int cartCount = CartHelper.GetCartCount();
				CartCountLabel.Text = cartCount.ToString();
			}
		}
		protected void reptProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
		{
			int ID = Convert.ToInt32(e.CommandArgument);
            string username = TextBox1.Text;
            string connectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS02;initial catalog=project12;integrated Security=true";
			SqlConnection connection = new SqlConnection(connectionString);
			connection.Open();

			string query = "SELECT ItemID,Itemname,Price,Description,imageurl FROM Gamespc where ItemID=@ItemID";
			SqlCommand command = new SqlCommand(query, connection);
			command.Parameters.AddWithValue("@ItemID", ID);

			SqlDataAdapter adapter = new SqlDataAdapter(command);
			DataTable dataTable = new DataTable();
			adapter.Fill(dataTable);

			DataRow row = dataTable.Rows[0];
			int ID_ = (int)row["ItemID"];
			string name = (string)row["Itemname"];
			int priceValue = (int)row["Price"];
			string Description = (string)row["Description"];
			string imageurl = (string)row["imageurl"];

			SqlCommand cmdCheck = new SqlCommand("SELECT COUNT(*) FROM CartB WHERE Itemname = @Itemname", connection);
			cmdCheck.Parameters.AddWithValue("@Itemname", name);
			int count = (int)cmdCheck.ExecuteScalar();

			if (count == 0)
			{
                SqlCommand cmd = new SqlCommand("INSERT INTO CartB (Itemname, Price, Houres, imageurl,Name) VALUES (@Itemname, @Price, 1, @imageurl,@Name)", connection);
                cmd.Parameters.AddWithValue("@Itemname", name);
                cmd.Parameters.AddWithValue("@Price", priceValue);
                cmd.Parameters.AddWithValue("@imageurl", imageurl);
                cmd.Parameters.AddWithValue("@Name", username);
                cmd.ExecuteNonQuery();

			}
			else
			{
				SqlCommand cmdUpdate = new SqlCommand("UPDATE CartB SET Houres = Houres + 1, imageurl = @imageurl WHERE Itemname = @Itemname", connection);
				cmdUpdate.Parameters.AddWithValue("@itemname", name);
				cmdUpdate.Parameters.AddWithValue("@imageurl", imageurl);
				cmdUpdate.ExecuteNonQuery();
			}

			int cartCount = CartHelper.GetCartCount();
			cartCount++;

			// Store the updated cart count in the session
			CartHelper.SetCartCount(cartCount);

			// Update the cart count label on the current page
			CartCountLabel.Text = cartCount.ToString();

		}

        protected void btnPS5_Click(object sender, EventArgs e)
        {
            Response.Redirect("WebForm3.aspx");
        }

        protected void BtnPS5Acc_Click(object sender, EventArgs e)
        {
            Response.Redirect("WebForm5.aspx");
        }

        protected void BtnPcAcc_Click(object sender, EventArgs e)
        {
            Response.Redirect("WebForm6.aspx");
        }
    }
}