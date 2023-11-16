<% Option Explicit %>

<%
'check if a shopping cart exists
If IsObject(Session("shoppingcart"))=False Then
Response.Redirect("index.asp")
End If
%>

<html>
<head>
<title>Checkout: Customer Information</title>
<link rel="stylesheet" href="style.css">

<script type="text/javascript">
function checkcustomerinfo()
{
    if (customer.lastname.value=="")
{
    alert("Please indicate the last name")
    customer.lastname.select ()
    return false
}
if (customer.firstname.value=="")
{
    alert("Please indicate the first name")
    customer.firstname.select ()
    return false
}
if (customer.middlename.value=="")
    {
        alert("Please indicate the middle name")
        customer.middlename.select ()
        return false
    }
if (customer.street.value=="")
    {
        alert("Please indicate the street")
        customer.street.select ()
        return false
    }
if (customer.village.value=="")
    {
        alert("Please indicate the village")
        customer.village.select ()
        return false
    }
if (customer.city.value=="")
    {
        alert("Please indicate the city")
        customer.city.select ()
        return false
    }
if (customer.telephone.value==""&& customer.mobilephone.value=="")
    {
        alert("Please indicate a contact number")
        customer.telephone.select ()
        return false
    }
if (customer.paymentmodeid.value=="")
    {
        alert("Please indicate the paymentmode")
        customer.paymentmode.select ()
        return false
    }

customer.submit()

}
</script>

</head>
<body>

<!--#include file="header.asp"-->
<!--#include file="connect.asp"-->

<h1 class="center">
Order Page
</h1>

<p class="center">

<%
Dim productname, price
Dim c, k, quantity, cart, totalPrice, rsCart
%>


<form name="customer" method="post"
    action="orderconfirmation.asp">

    <p class="title">Customer Information</p>

    Last name: <input type="text" name="lastname" value="">
<br>
    First name: <input type="text" name="firstname" value="">
<br>
    Middle name: <input type="text" name="middlename" value="">
<br>
    Recipient's name: <input type="text" name="recipient" value="">
<br>

<p class="title">Address</p>

Street: <input type="text" name="street" value="">
<br>
Village/Subdivision: <input type="text" name="village" value="">
<br>

Town/City: <select name="city">
    <option value="">Please select a city...</option>
    <option value="Caloocan">Caloocan</option>
    <option value="Las Pinas">Las Pinas</option>
    <option value="Makati">Makati</option>
    <option value="Malabon">Malabon</option>
    <option value="Mandaluyong">Mandaluyong</option>
    <option value="Manila">Manila</option>
    <option value="Marikina">Marikina</option>
    <option value="Muntinlupa">Muntinlupa</option>
    <option value="Paranaque">Paranaque</option>
    <option value="Pasay">Pasay</option>
    <option value="Pasig">Pasig</option>
    <option value="Navotas">Navotas</option>
    <option value="Quezon City">Quezon City</option>
    <option value="San Juan">San Juan</option>
    <option value="Valenzuela">Valenzuela</option>
    </select>
<br>

<p class="title">Contact Information</p>

    Telephone: <input type="text" name="telephone" value="">
<br>
    Mobilephone: <input type="text" name="mobilephone" value="">
<br>
    Email: <input type="text" name="email" value="">
<br>

<%
totalPrice = 0

If IsObject(Session("shoppingcart"))=True Then
Set cart=Session("shoppingcart")
Set rsCart=Server.CreateObject("ADODB.Recordset")

'get the keys from the dictionary
k = cart.keys

'go through each key stored in the array
For c = 0 to cart.Count - 1
productname = k(c)
quantity = cart.Item(productname)

SQL = "select price from products "
SQL = SQL & " inner join category on "
SQL = SQL & " products.categoryid=category.categoryid "
SQL = SQL & " where productname='" & productname & "'"

rsCart.Open SQL, conn
price = rsCart("price")
totalPrice = totalPrice + (quantity * price)
rsCart.close
Next

Set cart = Nothing
End If
%>

<p class="center title">
    Total amount: <%=FormatNumber(totalPrice,2)%> PHP
</p>

<br>
Payment mode:
<select name="paymentmodeid">
<option value="">Please select a payment mode...</option>
<%
SQL = "select * from paymentmode"
rs.Open SQL, conn
While rs.EOF = False
Response.Write("<option value='" & rs("paymentmodeid") & "'>")
Response.Write(rs("paymentmode") & " - additional PHP ")
Response.Write(FormatNumber(rs("shippingamount"),2))
Response.Write("</option>")
rs.MoveNext
Wend
rs.Close
%>
</select>
<br>

<p class="center title">
    Clicking the button below will confirm and finalize your order
    <br>
    <input type="button" onclick="window.location='shoppingcart.asp'"
        value="<<< My Shopping Cart">
    <input type="button" onclick="checkcustomerinfo()"
    value="Continue to Checkout>>>">
</p>

</form>

<%
Set conn = Nothing
%>

</p>
</body>
</html>