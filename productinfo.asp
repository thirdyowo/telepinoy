<% Option Explicit %>
<html>
<head>
  <title>Product Description: <%=Request.QueryString("productname")%>
</title>
  <link rel="stylesheet" href="style.css">
</head>

<body>

<!--#include file="header.asp"-->

<p class="center">

<!--#include file="connect.asp"-->

  <%
    Dim categoryname, productname, description, productimage, price
    Dim c, k, quantity, cart, totalItems, totalPrice, rsCart

    productname = Request.QueryString("productname")

    SQL = "select * from products "
    SQL = SQL & " inner join category on "
    SQL = SQL & " products.categoryid=category.categoryid "
    SQL = SQL & " where productname='" & productname & "'"

    rs.Open SQL, conn

    categoryname = rs ("categoryname")
    productname = rs ("productname")
    description=replace (rs ("description"),",","<br>")
    productimage="images/" & categoryname & "/" & rs ("productimage")
    price=rs ("price")

  %>

  <h1 class="center">
    <%=categoryname & " " & productname%>
  </h1>

  <table border="0">
    <tr>
      <td>
        <img src="<%=productimage%>">
      </td>

      <td class="productfeatures">
        <p><%=description%></p>
        <p>
          
             <form name="addtocart" method="post"
              action="addtocart.asp">

              PRICE: <%=FormatNumber(price,2)%> PHP<br>
              <input type="hidden" name="productname"
                     value="<%=productname%>">

              QUANTITY: <select name="quantity">
                         <option value="1">1</option>
                         <option value="2">2</option>
                         <option value="3">3</option>
                         <option value="4">4</option>
                        </select>

                 <input type="submit" value="Add to cart">
             </form>

           </p>
          </td>

        </p>
      </td>

      <td class="cart">
        <form name="cart" method="post" action="shoppingcart.asp">
          <p class="title">YOUR SHOPPING CART</p>

           <table class="items" border="1">
           <tr class="center title">
            <td>ITEM</td>
            <td>QUANTITY</td>
            <td>PRICE</td>
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
              SQL = SQL & " where productname='" & productname & "'"

              rsCart.Open SQL, conn
              categoryname = rsCart("categoryname")
              price = rsCart("price")

              Response.Write("<tr><td>")
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
             Next

              Set cart = Nothing
           End If
           %>

          </table>
          Total Items: <%=totalItems%>
          <p class="title">
           Total amount: <%=FormatNumber(totalPrice,2)%> PHP
          </p>

          <% If totalItems > 0 Then %>
           <input type="submit" value="Check Out">
          <% End If %>

        </form>
      </td>


    </tr>
  </table>


<%
rs.Close
Set conn = Nothing
%>

</p>
</body>
</html>