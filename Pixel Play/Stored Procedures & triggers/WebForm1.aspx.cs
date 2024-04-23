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

namespace Pixel_Play
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS;initial catalog=trying2;integrated Security=true";

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string storedProcedureName = "RegisterUser2";
            SqlCommand command = new SqlCommand(storedProcedureName, con);
            command.CommandType = CommandType.StoredProcedure;

            // Add parameters to the command
            command.Parameters.AddWithValue("@Name", TextBox1.Text);
            command.Parameters.AddWithValue("@Address", TextBox2.Text);
            command.Parameters.AddWithValue("@City", TextBox4.Text);
            command.Parameters.AddWithValue("@Contactno", TextBox5.Text);
            command.Parameters.AddWithValue("@Email", TextBox9.Text);
            command.Parameters.AddWithValue("@Password", TextBox10.Text);
            command.Parameters.AddWithValue("@SecurityQ", TextBox12.Text);
            if (string.IsNullOrEmpty(TextBox1.Text) || string.IsNullOrEmpty(TextBox2.Text) || string.IsNullOrEmpty(TextBox4.Text) || string.IsNullOrEmpty(TextBox5.Text) || string.IsNullOrEmpty(TextBox9.Text))
            {
                Label1.Text = "Please fill in all fields";
            }
            else if (!IsValidEmail(TextBox9.Text))
            {
                Label1.Text = "Please enter a valid email address";
            }
            else if (TextBox10.Text != TextBox13.Text)
            {
                Label1.Text = "Passwords do not match";
            }
            else
            {
                try
                {
                    con.Open();
                    command.ExecuteNonQuery();
                    con.Close();
                    // Registration was successful
                    Response.Redirect("WebForm2.aspx");
                }
                catch (SqlException ex)
                {
                    // An error occurred, handle it here
                    string errorMessage = ex.Message;
                    Label1.Text = errorMessage;
                    // Display error message on the page, log it, etc.
                }
            }




        }
        private bool IsValidEmail(string email)
        {
            // Define a regular expression pattern for valid email format
            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, pattern);
        }
    }

}