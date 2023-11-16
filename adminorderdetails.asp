<% Option Explicit %>
<html>
<head>
  <title>Admin: Order Details</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>

<!--#include file="adminheader.asp"-->
<!--#include file="connect.asp"-->

<h1 class="center">Order Details</h1>

<p class="center">

<%
  Dim orderid, orderdate, lastname, firstname, middlename, status
  Dim recipient, street, village, city, email, telephone, mobilephone
  Dim ipaddress, paymentmode, shippingamount
  Dim categoryname, productname, quantity, price, totalitems, totalprice
  Dim pending, approved, delivered, cancelled

  orderid = Request.QueryString("orderid")

  SQL = "select * from orders inner join paymentmode "
  SQL = SQL & "on orders.paymentmodeid=paymentmode.paymentmodeid "
  SQL = SQL & " where orderid=" & orderid
  rs.Open SQL, conn

  orderdate = rs("orderdate")
  lastname = rs("lastname")
  firstname = rs("firstname")
  middlename = rs("middlename")
  status = rs("status")
  recipient = rs("recipient")
  street = rs("street")
  village = rs("village")
  city = rs("city")
  email = rs("email")
  telephone = rs("telephone")
  mobilephone = rs("mobilephone")
  paymentmode = rs("paymentmode")
  shippingamount = rs("shippingamount")
  ipaddress = rs("ipaddress")
%>

<p class="title">
  ORDER ID #: <%=orderid%><br>
  ORDER DATE: <%=orderdate%>
</p>

<p class="title">Customer Information</p>

Last name: <%=lastname%><br>
First name: <%=firstname%><br>
Middle name: <%=middlename%><br>
Recipient's name: <%=recipient%><br>

<p class="title">Address</p>

Street: <%=street%><br>
Village/Subdivision: <%=village%><br>
Town/City: <%=city%><br>
<br>

<p class="title">Contact Information</p>

Telephone: <%=telephone%><br>
Mobilephone: <%=mobilephone%><br>
Email: <%=email%><br>
IP Address: <%=ipaddress%><br>

<br />Payment mode: <%=paymentmode%>
  (PHP <%=FormatNumber(shippingamount,2)%>)

<p class="title">ORDERED ITEMS</p>

  <table class="items" border="1">
  <tr class="center title">
    <td>ITEM</td>
    <td>QUANTITY</td>
    <td class="center">PRICE PER UNIT</td>
  </tr>

  <%
    rs.Close

    SQL = "select productorders.productname, productorders.quantity, "
    SQL = SQL & " productorders.price, category.categoryname "
    SQL = SQL & " from productorders, products, category where "
    SQL = SQL & " productorders.productname=products.productname and "
    SQL = SQL & " products.categoryid=category.categoryid "
    SQL = SQL & " and productorders.orderid=" & orderid

    rs.Open SQL, conn

    totalPrice = 0
    totalItems = 0

    While rs.EOF = False
      categoryname = rs("categoryname")
      productname = rs("productname")
      quantity = rs("quantity")
      price = rs("price")

	Response.Write("<td><tr class='center'>")
	Response.Write(categoryname & "" & productname)
	Response.Write("</td>")
	Response.Write("<td class='center'>")
	Response.Write(quantity)
	Response.Write("</td>")
	Response.Write("<td>")
	Response.Write(FormatNumber(price,2))
	Response.Write("</td></tr>")
	totalItems = totalItems + quantity
	totalPrice = totalPrice + (quantity * price)

	rs.MoveNext
    Wend
  %>
  </table>

  Total Items: PHP<%=totalitems%><br>
  Amount: PHP <%=FormatNumber(totalprice,2)%><br>
  Shipping cost: PHP <%=FormatNumber(shippingamount,2)%><br><br>

  Total: PHP <%=FormatNumber(totalprice+shippingamount,2)%><br />

  <%
    Select Case Status
	Case "PENDING"
	  pending = "selected='selected'"
	Case "APPROVED"
	  approved = "selected='selected'"
	Case "DELIVERED"
	  delivered = "seleted='selected'"
	Case Else
	  cancelled = "selected='selected'"
      End Select 
  %>

  <form name="orderstatus" method="post" ation="adminchangestatus.asp">
    Current order status:
    <select name="orderstatus">
	<option value="PENDING" <%=pending%>>PENDING</option>
	<option value="APPROVED" <%=approved%>>APPROVED</option>
	<option value="DELIVERED" <%=delivered%>>DELIVERED</option>
	<option value="CANCELLED" <%=cancelled%>>CANCELLED</option>
    </select>
    <input type="submit" value="Update Status">
    <input type="hidden" name="orderid" value="<%=orderid%>">
  </form>

  <%
    rs.Close
    Set conn=Nothing
  %>

</p>
</body>
</html>