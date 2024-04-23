<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage2.aspx.cs" Inherits="Pixel_Play.Homepage2" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width = device.width, initial-scale = 1">
    <style>
        input[type=text], select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-top: 6px;
            margin-bottom: 16px;
            resize: vertical;
        }

        input[type=submit] {
            background-color: rgb(24, 64, 156);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

            input[type=submit]:hover {
                background-color: rgb(144, 15, 144);
            }

        .container {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .slider {
            width: 1270px;
            height: 500px;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
            left: 96px;
        }

        .slides {
            width: 500%;
            height: 500px;
            display: flex;
        }

            .slides input {
                display: none;
            }

        .slide {
            width: 20%;
            transition: 2s;
        }

            .slide img {
                width: 1270px;
                height: 500px;
            }

        .navigation-manual {
            position: absolute;
            width: 1270px;
            margin-top: -40px;
            display: flex;
            justify-content: center;
        }

        .manual-btn {
            border: 2px solid rgb(96, 20, 20);
            padding: 5px;
            border-radius: 10px;
            cursor: pointer;
            transition: 1s;
        }

            .manual-btn:not(:last-child) {
                margin-right: 40px;
            }

            .manual-btn:hover {
                background-color: rgb(96, 20, 20);
            }

        #radio1:checked ~ .first {
            margin-left: 60px;
        }

        #radio2:checked ~ .first {
            margin-left: -20%;
        }

        #radio3:checked ~ .first {
            margin-left: -40%;
        }

        #radio4:checked ~ .first {
            margin-left: -60%;
        }

        .navigation-auto {
            position: absolute;
            width: 1270px;
            margin-top: 460px;
            display: flex;
            justify-content: center;
        }

            .navigation-auto div {
                border: 2px solid rgb(96, 20, 20);
                padding: 5px;
                border-radius: 10px;
                cursor: pointer;
                transition: 1s;
            }

                .navigation-auto div:not(:last-child) {
                    margin-right: 40px;
                }

        #radio1:checked ~ .navigation-auto .auto-btn1 {
            background: rgb(96, 20, 20);
        }

        #radio2:checked ~ .navigation-auto .auto-btn2 {
            background: rgb(96, 20, 20);
        }

        #radio3:checked ~ .navigation-auto .auto-btn3 {
            background: rgb(96, 20, 20);
        }

        #radio4:checked ~ .navigation-auto .auto-btn4 {
            background: rgb(96, 20, 20);
        }

        .browse-category {
            display: flex;
            align-items: center;
        }

        body {
            background-color: black;
        }

        nav {
            background-color: black;
            color: white;
            padding: 10px;
            text-align: center;
        }

            nav a {
                display: inline-block;
                position: relative;
                bottom: 25px;
                color: white;
                text-decoration: none;
                padding: 10px;
                margin: 0 5px;
                border-radius: 0;
                transition: background-color 0.3s ease;
            }

                nav a:hover {
                    background-color: rgb(144, 15, 144);
                }

        .dropbtn {
            background-color: black;
            color: rgb(247, 243, 243);
            padding: 10px;
            font-size: 16px;
            border: none;
        }

        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: rgb(9, 9, 9);
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
            position: absolute;
            top: 50px;
        }

            .dropdown-content a {
                color: rgb(252, 246, 246);
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

                .dropdown-content a:hover {
                    background-color: rgba(66, 66, 66, 0.87);
                }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        .dropdown:hover .dropbtn {
            background-color: rgb(144, 15, 144);
        }
    </style>
    <script type="text/javascript">
        var counter = 1;
        setInterval(function () {
            document.getElementById('radio' + counter).checked = true;
            counter++;
            if (counter > 4) {
                counter = 1;
            }
        }, 3000);</script>
</head>
<body>
    <form id="form1" runat="server">
    <nav>
        <img> <a href="#"></a> <img src="profile.png" alt="PP's Logo" height="80" style="position: relative ; top:11px ;right:10px ;width:150px"> </img>
        
         
        <a href="WebForm3.aspx">Menu</a>
        <a href="HomePage.aspx">Logout</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
        
                <asp:TextBox ID="TextBox1" runat="server" width="150px" BackColor="Black" ForeColor="White" Style="position:relative;bottom:20px" ></asp:TextBox>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Repeater ID="reptProduct" runat="server">
            <ItemTemplate>
                
                <asp:label ID="TextBox2" runat="server" width="150px" BackColor="Black" ForeColor="White" Style="position:relative;bottom:20px" text='<%# "PP Stuff: " + Eval("PPstuff")  %>'></asp:label>
                 
            </ItemTemplate>
        </asp:Repeater>
    </nav>
    <br>
    <div class="slider">
        <div class="slides">
            <input type="radio" name="radio-btn" id="radio1">
            <input type="radio" name="radio-btn" id="radio2">
            <input type="radio" name="radio-btn" id="radio3">
            <input type="radio" name="radio-btn" id="radio4">

            <div class="slide first">
                <a href="#"><img src="Blue Pink Gradient Fashion Banner.png" alt="IMAGE"></a>
            </div>
            <div class="slide">
                <a href="#"><img src="CoD Wallpaper.jpg" alt="IMAGE"></a>
            </div>
            <div class="slide">
                <a href="#"><img src="Fifa Wallapaper.jpg" alt="IMAGE"></a>
            </div>
            <div class="slide">
                <a href="#"><img src="Tekken Wallpaper.jpg" alt="IMAGE"></a>
            </div>

            <div class="navigation-auto">
                <div class="auto-btn1"></div>
                <div class="auto-btn2"></div>
                <div class="auto-btn3"></div>
                <div class="auto-btn4"></div>
            </div>
        </div>
        <div class="navigation-manual">
            <label for="radio1" class="manual-btn"></label>
            <label for="radio2" class="manual-btn"></label>
            <label for="radio3" class="manual-btn"></label>
            <label for="radio4" class="manual-btn"></label>
        </div>
    </div>
    <br><br>
    <h3 style="text-align: center;font-size:36px; font-family: Arial, Helvetica, sans-serif; color: rgb(24, 64, 156);">User Feedback Form</h3>

    <div class="container">
        <form method="post" action="mailto:abdullahsakib431@gmail.com">
            <label for="fname">First Name</label>
            <input type="text" id="fname" name="firstname" placeholder="Your First name..">

            <label for="lname">Last Name</label>
            <input type="text" id="lname" name="lastname" placeholder="Your Last name..">

            <label for="Email">Email</label>
            <input type="text" id="email" name="email" placeholder="Your Email..">

            <label for="country">Platform</label>
            <select id="country" name="country">
                <option value="pakistan">PS5</option>
                <option value="canada">PC</option>

            </select>

            <label for="subject">Feedback</label>
            <textarea id="subject" name="subject" placeholder="Write something.." style="height:200px"></textarea>

            <input type="submit" value="Submit">
        </form>
    </div>
    <footer>
        <p style="color: white; text-align: center;">© Pixel Play </p>
    </footer>
        </form>
</body>
</html>
