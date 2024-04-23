<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Pixel_Play.WebForm1" %>

<!DOCTYPE html>
<html>
<head>
    <title>Sign In Page</title>
    <style>
        body {
            background-color: black;
            font-family: Arial, sans-serif;
            text-align: center;
        }

        h1 {
            color:purple;
            margin-top: 50px;
        }

        form {
            display: inline-block;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            margin-top: 50px;
            text-align: left;
            width: 695px;
        }

        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        button {
            background-color: blue;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
        }
       
        

        .error {
            color: red;
            font-size: 12px;
            margin-top: 5px;
        }
        

    </style>
</head>
<body>
    
       
    
    <header>

        <img src="profile.png" alt="pixel play logo" height="120"  style="position: relative; top: 2px; left: -1px; border-radius:10px; width: 273px;"/>

    </header>
    <h1>PIXEL PLAY (c)</h1>
     <form id="form1" runat="server">
        <label for="username"><b>Name</b></label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
         <strong>Address </strong>
        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
        <label for="phone"><b>City</b></label>
        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
         <strong>Contact Number</strong>
        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
        <label for="email"><b>Email</b></label>
        


        <label for="password"><b>
         <br />
         <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
         <br />
         Password</b></label>
         <br />
         <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox>
         <br />
         <label for="password"><b>Confirm Password</b></label>
         <br />
         <asp:TextBox ID="TextBox13" runat="server"></asp:TextBox>
         <br />
         <strong>Security Question</strong><br />
         <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox>
         <br />
         <strong>Answer</strong><br />
         <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox>
         <br />

         
        
&nbsp;<asp:Button ID="Button2" runat="server"  Text="Register" BackColor="blue" ForeColor="White" Height="44px" style="margin-left: 0px" Width="100%" OnClick="Button2_Click"  />

        <div class="error" id="error">

        <asp:Label ID="Label1" runat="server"></asp:Label>

        </div>

    </form>
   


</body>
</html>




