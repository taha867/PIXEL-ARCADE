<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm6.aspx.cs" Inherits="Pixel_Play.WebForm6" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        .bilal{
            background-color: black;
            margin: -10px;
        }
        .browse-category hr {
        flex: 2;
        height: 1px;
        margin-left: 280px;
        margin-right: 150px;
        background-color: whitesmoke;
        border: none;
        position:relative; bottom: 38px;
        }
        .browse-category h1 {
            color: white;
        }
        img {
        max-width: 350px;
        max-height: 300px;
        }
        .Cart {
            display: flex;
            flex-wrap: wrap;
            justify-content: flex-start;
            align-items: flex-start;
            width: 1000px; /* or any other appropriate width */
             margin: 0 auto; /* to center the container on the page */
        }
        .games-container {
            width: 32%;
            padding: 10px;
            box-sizing: border-box;
        }
        .games {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            max-width: 233px;
            width: 100%;
            margin: auto;
            position: relative;
            bottom: 25px;
            left: 0px;
            text-align: center;
            font-family: arial;
            background-color: black;
            color: white;
        }
        .games-button {
            border: none;
            outline: 0;
            padding: 12px;
            color: black;
            background-color: gray;
            text-align: center;
            position: relative; 
            left:40px;
            bottom: 30px;
            cursor: pointer;
            width: 300px;
            font-size: 18px;
        }
        .games-button:hover {
            color: white;
        }
        
        .footer {
            background-color:black;
            color: white;
            margin: -10px;
            height: 380px;
        }
        .my-label-class {
            color: white;
            font-size: 20px;
            font-weight: bold;
            position: relative; bottom: 60px; left: 900px;
        }

    </style>
    <title>Accessories</title>
</head>
<body style="background-color:black">
    <form id="form1" runat="server">
        <nav class="bilal">
        <a  href="Homepage.aspx"><img src="profile.png" alt="themeatbusters logo" height="120"  style="position: relative; top: 20px; left: 504px; border-radius: 10px; width: 386px;"/></a>
       <asp:Label ID="CartCountLabel" runat="server" Text="0" CssClass="my-label-class"></asp:Label>
    <div class="cartlogo">
      <a href="Cart.aspx" id="cart-count"><img src="cart4.jpg" alt="cart logo" height="60"  style="position: relative; bottom: 60px; left: 1200px; border-radius: 5px; "/></a>
    </div>
    <div class="Menubtn">
                <asp:TextBox ID="TextBox1" runat="server" style="position:relative;left: 200px;bottom:150px" ForeColor="White" BackColor="black"></asp:TextBox>

        <asp:Button ID="btnPS5" runat="server" Text="PS5 Games" style="position: relative; top: -20px; left: 325px;
        background-color:purple;
        color: white;
        padding: 15px;
        width: 175px;
        font-size: 16px;
        border: 2px solid rgb(96, 20, 20); 
        border-radius: 0px; " OnClick="btnPS5_Click" />
        <asp:Button ID="BtnPCgamesr" runat="server" Text="PC Games" style="position: relative; top: -20px; left: 350px;
        background-color: purple;
        color: white;
        padding: 15px;
        width: 175px;
        font-size: 16px;
        border: 2px solid rgb(96, 20, 20); 
        border-radius: 0px; " OnClick="BtnPCgamesr_Click"/>
        <asp:Button ID="BtnPS5Acc" runat="server" Text="PS5 Accessories" style="position: relative; top: -20px; left: 375px;
        background-color: purple;
        color: white;
        padding: 15px;
        width: 200px;
        font-size: 16px;
         border: 2px solid rgb(96, 20, 20); 
        border-radius: 0px;" OnClick="BtnPS5Acc_Click"/>
        <asp:Button ID="BtnPcAcc" runat="server" Text="PC Accessories" style="position: relative; top: -20px; left: 400px;
        background-color: purple;
        color: white;
        padding: 15px;
        width: 175px;
        font-size: 16px;
        border: 2px solid white;
        border-radius: 0px;"/>
    </div>
</nav>
    <br><br>
    <div class="browse-category">
        <h1 style="position: relative; left:48px; top: -6px;"> PC Accessories</h1> <hr>
    </div>
    <br><br>

    <div class="Cart" style="text-align:center;">
          <asp:Repeater ID="reptProduct" runat="server" OnItemCommand="reptProduct_ItemCommand"> 
                <ItemTemplate>
                    <div class="games-container">
                            <div class="games">
                                <asp:Image runat="server" ID="ProductImage" ImageUrl='<%# Eval("imageurl") %>' CssClass="img"/>
                                <h1><asp:label runat="server" ID="lblName" Text='<%# Eval("Itemname") %>' ></asp:label></h1>
                                <p style="color:grey;"><asp:label runat="server" ID="Label1" Text='<%# "RS:" + Eval("Price") %>' Visible="true"></asp:label></p>
                                <p><asp:label runat="server" ID="Label2" Text='<%# Eval("Description") %>' ></asp:label></p>
                            </div>
<%--                            <asp:Button ID="btnAddtocart" runat="server" Text="BOOKING" CssClass="games-button" CommandName="AddToCart" CommandArgument='<%# Eval("ItemID") %>' />--%>

                        </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
</form>
 
    <footer>
        <h1 "style = color = white; font-family:Cambria, Cochin, Georgia, Times, 'Times New Roman' ">ABOUT US</h1>



    </footer>
</body>
</html>
