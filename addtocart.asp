<% Option Explicit %>
<html>
<head>
   <title>Add to Cart</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<p class="center">

<%
  Dim productname, quantity, cart

  'check if the session variable exists
  If IsObject(Session("shoppingcart"))=True Then
       Set cart = Session("shoppingcart")
  Else
      Set cart=Server.CreateObject("Scripting.Dictionary")
  End If

  'retrieve the form data and save them in the variables
  productname =  Request.Form("productname")
  quantity = Request.Form("quantity")

  'check if the form data actually contains something
  If productname<>""and quantity<>""Then

  'check if the key exists
      If cart.Exists(productname)=True Then
           cart.Item(productname) = quantity 'replace
      Else
          cart.Add productname,quantity 'add
      End If

      Set Session("shoppingcart") = cart
      Set cart = Nothing
  Else
      'insert Javascript code to go back to the previous page
      Response.Write("<script='text/javascript'>")
      Response.Write("history.back()")
      Response.Write("</script>")
      Response.End
  End If

  Response.Redirect("productinfo.asp?productname=" & productname)
%>

</p>
</body>
</html>