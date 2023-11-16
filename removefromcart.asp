<% Option Explicit %>
<html>
<head>
<title>Remove from Cart</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<p class="center">

<%
  Dim productname, cart

  'check if the session variable exists
  If IsObject(Session("shoppingcart"))=True Then
    Set cart = Session("shoppingcart")
  Else
    Response.Redirect("shoppingcart.asp")
  End If

  'retrieve the form data and save them in the variables
  productname = Request.QueryString("productname")

  'check if the form data actually contains something

  'check if the key exists
  If cart.Exists(productname)=True Then
    cart.Remove(productname) 'remove
  End If

  'save the cart
  Set Session("shoppingcart") = cart
  Set cart = Nothing

  Response.Redirect("shoppingcart.asp")
%>

</p>
</body>
</html>