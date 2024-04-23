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
    public partial class Homepage2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["FirstName"] == null)
            {
                // user is not logged in, redirect to the login page
                Response.Redirect("Sign In.aspx");
                return;
            }
            else
            {
                // user is logged in, retrieve the email from the session variable
                string username = Session["FirstName"].ToString();
                // use the email to personalize the content of the page
                TextBox1.Text = username;
                string connectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS;initial catalog=trying2;integrated Security=true";
                SqlConnection connection = new SqlConnection(connectionString);
                connection.Open();

                // Retrieve data from "cart" table
                string query = "SELECT PPstuff FROM PP where Name=@username";
                
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@username", username);
                SqlDataReader reader = command.ExecuteReader();

                reptProduct.DataSource = reader;
                reptProduct.DataBind();
                connection.Close();
            }
        }
    }
}