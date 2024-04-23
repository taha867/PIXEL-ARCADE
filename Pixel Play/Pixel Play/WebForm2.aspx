<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="Pixel_Play.WebForm2" %>

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
            padding: 30px;
            border-radius: 10px;
            margin-top: 50px;
            text-align: left;
          
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
       
        button:hover 
        {
            background-color: rgb(96,20,20);
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
     
    <form id="form1" runat="server">
        <label for="Email"><b>Email</b></label>
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
&nbsp;<label for="password"><b>Password</b></label>
        <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>

        <a href="Webform4.aspx" style="text-decoration: underline; display: inline-block;  color:black;">Forgot Password?</a><br />
        
&nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button_Click" Text="Login" BackColor="blue" ForeColor="White" Height="44px" style="margin-left: 0px" Width="100%" />

        <div class="error" id="error">

        <asp:Label ID="Label1" runat="server"></asp:Label>

        </div>

    </form>
   


</body>
</html>