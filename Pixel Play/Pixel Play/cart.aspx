<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<!DOCTYPE html>



<script>


	function removeItem(name, quantity)
	{
        console.log(name);
        alert("Item " + name + " removed from cart.");
        // Send AJAX request to server to remove item from cart
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                // Reload the page to update the cart
                location.reload();
            }
        };
        xmlhttp.open("GET", "removeItem.aspx?Itemname=" + name + "&Houres=" + quantity, true);
        xmlhttp.send();
	}

</script>



<html>
<head>
	<title>Display Image from SQL Server in ASP.NET</title>
    <style type="text/css">
		body {
			background-color: black;
			color: black;
			font-family: Arial, sans-serif;
           
		}
		
		form {
			display: flex;
			flex-direction: row;
			align-items: flex-start;
		}
		
		table {
			margin-top: 20px;
			border-collapse: collapse;
		}
		
		th, td {
			padding: 10px;
			
		}
		
		img {
			max-width: 100px;
			max-height: 100px;
		}
		.left {
    flex: 1;
    margin-right: 10px;
    padding: 10px;
    background-color: whitesmoke;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

.right {
    flex: 1;
    margin-left: 10px;
    padding: 10px;
    background-color: whitesmoke;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}
        button {
            background-color: purple;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
        }
         button:hover 
        {
            background-color: rgb(96,20,20);
        }
    </style>
</head>
<body>
	
	 <a  href="Homepage.aspx">&nbsp;</a><p>P</p>
	
		
	
    <h1 style="margin-left: 40px">
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
     </h1>
    <br />
	<br />
	<div class="left">
		<h1>Cart Items</h1>
	
		<table>
			<tr>
				<th>Image</th>
				<th>Name</th>
				<th>Price</th>
				<th>Hours</th>
				<th></th>
			</tr>

			<% 
				// Connect to SQL Server database
				string connectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS02;initial catalog=project12;integrated Security=true";
				SqlConnection connection = new SqlConnection(connectionString);
				connection.Open();

				// Retrieve data from "cart" table
				string query = "SELECT Itemname, Price, Houres, imageurl FROM CartB";
				SqlCommand command = new SqlCommand(query, connection);
				SqlDataReader reader = command.ExecuteReader();
				int total = 0;
				while (reader.Read())

				{
					// Get values from database
					string name = reader.GetString(0);
					int price = reader.GetInt32(1);
					int houres = reader.GetInt32(2);
					string Imagepath = reader.GetString(3);
					total = total + (price * houres);
					// Display data in table row
    %>
    <tr>
    <td><img src="<%= Imagepath %>"></td>
    <td><%= name %></td>
    <td><%= price %></td>
    <td><%= houres %></td>
    <td><button onclick="removeItem('<%= name %>','<%= houres %>')">Remove</button></td>
</tr>

    <%
		}

		reader.Close();
		string query3 = "Insert into total_(tprice) Values(@tprice)";
		SqlCommand command3 = new SqlCommand(query3, connection);
		command3.Parameters.AddWithValue("@tprice", total);
		SqlDataReader reader3 = command3.ExecuteReader();

		// Close database connection and reader
		
		reader3.Close();
		connection.Close();
			%>
		</table>
		
		
		</div>
     <br />
     <br />
	<div class="left">
		<p>NOTE: FOR CONFIRMATION OF TIME YOU'LL RECEIVE A CALL FORM OUR EXPERT SHORTLY AND
				YOUR BOOKING IS ONLY VALID FOR TODAY 
			
		</p>
		<form id="form1" runat="server">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<asp:Button ID="Button1" runat="server" Text="Proceed to Checkout" OnClick="checkout" href="Homepage2.aspx" BackColor="Purple" ForeColor="White" Height="43px" />
		<asp:TextBox ID="textbox1" runat="server" Text='<%= total %>'></asp:TextBox>
			
		</form>
	
		<script language="C#" runat="server">
			void checkout(object sender, EventArgs e)
			{
				string connectionString = "Data source=DESKTOP-UTRLQ39\\SQLEXPRESS02;initial catalog=project12;integrated Security=true";
				SqlConnection connection = new SqlConnection(connectionString);
				connection.Open();

				// Retrieve data from "cart" table
				string query = "SELECT Name FROM CartB";
				SqlCommand command = new SqlCommand(query, connection);
				SqlDataReader reader = command.ExecuteReader();

				string name = null;

				while (reader.Read())
				{
					// Get name value from database
					name = reader.GetString(0);
					break; // Only need the first row
				}

				reader.Close(); // Close previous reader before executing new command



				// Create the SqlCommand object and set its properties
				string query4 = "SELECT tprice FROM total_";
				SqlCommand command4 = new SqlCommand(query4, connection);
				SqlDataReader reader4 = command4.ExecuteReader();

				int subtotal = 0;

				while (reader4.Read())
				{
					subtotal = reader4.GetInt32(0);
					break;
				}
				reader4.Close();

				string query2 = "IF (SELECT PAstuff FROM PA WHERE Name = @name) >= @subtotal " +
								"UPDATE PA SET PAstuff = PAstuff - @subtotal WHERE Name = @name ";//+
																								  //"ELSE RAISERROR('Insufficient PAstuff', 16, 1)";
				SqlCommand command2 = new SqlCommand(query2, connection);
				command2.Parameters.AddWithValue("@name", name);
				command2.Parameters.AddWithValue("@subtotal", subtotal);
				SqlDataReader reader_ = command2.ExecuteReader();

				reader_.Close();
				/*using (SqlCommand command2 = new SqlCommand(query2, connection))
			{
				command2.Parameters.AddWithValue("@name", name);
				command2.Parameters.AddWithValue("@subtotal", subtotal);

				// Use ExecuteNonQuery for non-query operations
				int rowsAffected = command2.ExecuteNonQuery();

				if (rowsAffected == 0)
				{
					// Insufficient funds, handle accordingly
					// You might want to throw an exception or show an error message
					throw new InvalidOperationException("Insufficient PAstuff");
				}
			}*/

				string query5 = "Delete from total_";
				SqlCommand command5 = new SqlCommand(query5, connection);
				command5.ExecuteNonQuery();

				string query6 = "Delete from CartB";
				SqlCommand command6 = new SqlCommand(query6, connection);
				command6.ExecuteNonQuery();

				connection.Close();

				Response.Redirect("Homepage2.aspx");
			}

			</script>
	</div>

	
</body>	
</html>