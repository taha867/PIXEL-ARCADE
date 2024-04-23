using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Pixel_Play
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection();
        SqlDataAdapter sda = new SqlDataAdapter();
        DataSet ds = new DataSet();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.ConnectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS;initial catalog=trying2;integrated Security=true";

        }
        protected void Button_Click(object sender, EventArgs e)
        {

            string storedProcedureName = "LoginUser";
            SqlCommand command = new SqlCommand(storedProcedureName, con);
            command.CommandType = CommandType.StoredProcedure;

            // Add parameters to the command
            command.Parameters.AddWithValue("@Name", TextBox1.Text);
            command.Parameters.AddWithValue("@Password", TextBox2.Text);

            if (string.IsNullOrEmpty(TextBox1.Text) || string.IsNullOrEmpty(TextBox2.Text))
            {
                Label1.Text = "Please fill in all fields";
            }
            else
            {
                try
                {

                    con.Open();
                    command.ExecuteNonQuery();
                    con.Close();
                    // Registration was successful
                    string name = TextBox1.Text;
                    Session["FirstName"] = name;
                    Response.Redirect("HomePage2.aspx");
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

	USE trying2;

		--Create an audit table to store login information
		CREATE TABLE LoginAudit(
   		 LoginAuditID INT PRIMARY KEY IDENTITY(1,1),
    		UserName NVARCHAR(255),
    		LoginTime DATETIME DEFAULT GETDATE()
		);

          		  --Create a trigger to log login information
		CREATE TRIGGER trgLoginAudit
		ON YourUserTable-- Replace YourUserTable with the actual table storing user information
		AFTER INSERT
		AS
		BEGIN
  		  INSERT INTO LoginAudit(UserName)
  		  SELECT Name
  		  FROM inserted;
    		        END;




    }

}