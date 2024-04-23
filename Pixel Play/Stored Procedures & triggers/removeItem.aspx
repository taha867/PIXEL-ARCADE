<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get item name and quantity from query string
        string name = Request.QueryString["Itemname"];
        int quantity = Int32.Parse(Request.QueryString["Houres"]);

        // Connect to SQL Server database
        string connectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS;initial catalog=trying2;integrated Security=true";
        SqlConnection connection = new SqlConnection(connectionString);
        connection.Open();

        // Update the cart in the database
        string query = "UPDATE CartB SET Houres = Houres - 1 WHERE Itemname = @Itemname";
        SqlCommand command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@Itemname", name);
        command.ExecuteNonQuery();

        string query2 = "Delete from total_";
        SqlCommand command2 = new SqlCommand(query2, connection);
        command2.ExecuteNonQuery();

        // Check if the updated quantity is zero
        query = "SELECT Houres FROM CartB WHERE Itemname = @Itemname";
        command = new SqlCommand(query, connection);
        command.Parameters.AddWithValue("@Itemname", name);
        int updatedQuantity = (int)command.ExecuteScalar();
        if (updatedQuantity == 0)
        {
            // Remove the row from the cart
            query = "DELETE FROM CartB WHERE Itemname = @Itemname";
            command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@Itemname", name);
            command.ExecuteNonQuery();

        }

        // Close the database connection
        connection.Close();
    }
</script>