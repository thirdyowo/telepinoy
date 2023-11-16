<% Option Explicit %>
<html>
<head>
<title>My Shopping Cart</title>
<link rel="stylesheet" href="style.css">
</head>

<body>

<!--#include file="header.asp"-->

<p class="center">

<!--#include file="connect.asp"-->

<%
 Dim categoryname, productname, productimage, price
 Dim c, k, quantity, cart, totalItems, totalPrice, rsCart
%>

<h1 class="center">
My Shopping Cart
</h1>
<p class="center">

   <form name="cart" method="post" action="checkout.asp">

   <table class="items" border="1">
   <tr class="center title">
    <td>ITEM</td>
    <td>QUANTITY</td>
    <td>PRICE</td>
    <td>Remove from cart</td>
   </tr>

   <%
   totalItems = 0
   totalPrice = 0

   If IsObject(Session("shoppingcart"))=True Then
     Set cart=Session("shoppingcart")
     Set rsCart=Server.CreateObject("ADODB.Recordset")

     'get the keys from the dictionary
     k = cart.Keys

     'go through each key stored in the array
     For c = 0 to cart.Count - 1
      productname = k(c)
      quantity = cart.Item(productname)

      SQL = "select * from products "
      SQL = SQL & " inner join category on "
      SQL = SQL & " products.categoryid=category.categoryid "
      SQL = SQL & " where productname='" & productname & "' "

      rsCart.Open SQL, conn
      categoryname = rsCart("categoryname")
      price = rsCart("price")
      productimage = "images/" & categoryname & "/thumbnails/" & rsCart("productimage")

      Response.Write("<tr><td class='center'>")
      Response.Write("<img src='" & productimage & "'><br>")
      Response.Write("<a href='productinfo.asp?productname=" & productname & "'>")
      Response.Write(categoryname & " " & productname)
      Response.Write("</a>")
      Response.Write("</td>")
      Response.Write("<td class='center'>")
      Response.Write(quantity)
      Response.Write("</td>")
      Response.Write("<td>")
      Response.Write(FormatNumber(price,2))
      Response.Write("</td><td class='center'>")
      Response.Write("<a href='removefromcart.asp?productname=" & productname & "'>")
      Response.Write("Remove</a>")
      Response.Write("</td></tr>")

      totalItems = totalItems + quantity
      totalPrice = totalPrice + (quantity * price)

      rsCart.Close
      Next

    Set cart = Nothing
    End If
   %>

     </table>
     Total Items: <%=totalItems%>
     <p class="center title">
      Total amount: <%=FormatNumber(totalPrice,2)%> PHP

      <% If totalItems > 0 Then %>
       <input type="submit" value="Continue to checkout>>>">
      <% Else %>
       <p class="center title">There are no items in your cart</p>
      <% End If %>

     </p>
    </form>
   </p>

 <%
  Set conn = Nothing
 %>

</p>
</body>
</html>