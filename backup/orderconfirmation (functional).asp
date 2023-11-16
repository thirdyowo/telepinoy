<% Option Explicit %>

<%
  'check if a shopping cart exists
  If IsObject(Session("shoppingcart"))=False Then
    Response.Redirect("index.asp")
  End If
  
  'check if orderconfirmation.asp has been properly loaded
  If Request.ServerVariables("HTTP_REFERER")<>"http://localhost/checkout.asp" Then
    Response.Redirect("index.asp")
  End If
%>

<html>
<head>
  <title>Checkout: Order Confirmation</title>
  <link rel="stylesheet" href="style.css">
</head>

<body>

<!--#include file="header.asp"-->
<!--#include file="connect.asp"-->

<h1 class="center">
	Order Confirmation Page
</h1>

<p class="center">

  <%
    Dim categoryname, productname, price
	Dim c, k, quantity, cart, totalItems, totalPrice, rsCart
	Dim lastname, firstname, middlename, recipient, street, village, city
	Dim telephone, mobilephone, email, paymentmodeid, shippingamount, orderid
	Dim ipaddress
	
	'get the form data
	lastname = Request.Form("lastname")
	firstname = Request.Form("firstname")
	middlename = Request.Form("middlename")
	recipient = Request.Form("recipient")
	street = Request.Form("street")
	village = Request.Form("village")
	city = Request.Form("city")
	telephone = Request.Form("telephone")
	mobilephone = Request.Form("mobilephone")
	email = Request.Form("email")
	paymentmodeid = Request.Form("paymentmodeid")
	
	'get the IP address
	ipaddress = Request.ServerVariables("REMOTE_ADDR")
	
	'generate the SQL query string
	SQL = "insert into orders(lastname,firstname,middlename,recipient"
	SQL = SQL & ",street,village,city,telephone,mobilephone,email"
	SQL = SQL & ",paymentmodeid,orderdate,ipaddress,status) "
	SQL = SQL & " values('" & lastname & "','" & firstname & "','"
	SQL = SQL & middlename & "','" & recipient & "','" & street & "','"
	SQL = SQL & village & "','" & city & "','" & telephone & "','"
	SQL = SQL & mobilephone & "','" & email & "'," & paymentmodeid
	SQL = SQL &  ",#" & Date() & "#,'" & ipaddress & "','PENDING')"
	
	'perform the INSERT INTO SQL query
	conn.Execute SQL
	
	'get the order ID number
	SQL = "select orderid from orders where lastname='" & lastname & "' "
	SQL = SQL & " and firstname='" & firstname & "' "
	SQL = SQL & " and middlename='" & middlename & "' "
	SQL = SQL & " and orderdate=#" & Date() & "#"
	rs.Open SQL, conn
	orderid = rs("orderid")
	rs.Close
  %>

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

  <br>Payment mode:

  <%
		SQL = "select * from paymentmode "
		SQL = SQL & "where paymentmodeid=" & paymentmodeid
		rs.Open SQL, conn
		
		shippingamount = rs("shippingamount")
		
		Response.Write(rs("paymentmode"))
		Response.Write(" (additional PHP ")
		Response.Write(shippingamount)
		Response.Write(")")
		
		rs.Close
  %>
  
  <p class="title">ORDERED ITEMS</p>
  
  <table class="items" border="1">
  <tr class="center title">
	<td>ITEM</td>
	<td>QUANTITY</td>
	<td class="center">PRICE PER UNIT</td>
  </tr>
  
  <%
    totalItems = 0
	totalPrice = 0
	
	If IsObject (Session("shoppingcart"))=True Then
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
		SQL = SQL & " where productname='" & productname & "'"
		
		rsCart.Open SQL, conn
		categoryname = rsCart("categoryname")
		price = rsCart("price")
		
		Response.Write("<tr><td class='center'>")
		Response.Write(categoryname & " " & productname)
		Response.Write("</td>")
		Response.Write("<td class='center'>")
		Response.Write(quantity)
		Response.Write("</td>")
		Response.Write("<td>")
		Response.Write(FormatNumber(price,2))
		Response.Write("</td></tr>")
		
		totalItems = totalItems + quantity
		totalPrice = totalPrice + (quantity * price)
		
		rsCart.Close
		
		'save the information to the PRODUCTORDERS table
		SQL = "insert into productorders(orderid,productname,quantity,"
		SQL = SQL & "price) values(" & orderid & ",'" & productname
		SQL = SQL & "'," & quantity & "," & price & ")"
		conn.Execute SQL
	  Next
	  
	  Set cart = Nothing
	End If
  %>
  
  </table>
  
  <p>
     Total amount: <%=FormatNumber(totalPrice,2)%> PHP<br>
	 Shipping Cost: <%=FormatNumber(shippingamount,2)%> PHP<br>
  </p>
  
  <p class="title">
     TOTAL: <%=FormatNumber(totalPrice + shippingamount,2)%> PHP<br>
  </p>
  
  <p>
   Your order has been recorded in our system.
   Please wait for our call within 24 to 48 hours.<br><br>
   For bank payments, please use the details below:<br><br>
   BANK: Bank of the Philippine Seas<br>
   ACCOUNT NAME: Pedro P. Penduko<br>
   ACCOUNT TYPE: Savings<br>
   ACCOUNT NUMBER: xxxx-xxxx-xxxx-x
   <br><br>
    (scan or fax your deposit slip to pedro@telepinoy.com/Tel. 809-xxxx)
   </p>
   
   <p class="center title">
    YOUR ORDER ID NUMBER IS: <%=orderid%>
   </p>
   
   <p class="center">
    Please print this page and remember your 
	Order ID number for your reference.
   </p>
   
</p>

  <%
    Set conn = Nothing
	
	'destroy the dictionary
	Session.Abandon
  %>
  
</body>
</html>