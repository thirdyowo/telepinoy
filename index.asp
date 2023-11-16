<% Option Explicit %>
<html>
<head>
  <title>Home</title>
  <link rel="stylesheet" href="style.css">
</head>

<body>

<!--#include file="header.asp"-->


<table width="100%" border="0">
<tr>

  <td>

    <!--#include file="connect.asp"-->
    <%
      dim categoryid, categoryname

      SQL = "select * from category"

      rs.Open SQL, conn

      Response.Write ("<p class='header'>CATEGORIES</p>")

While rs.EOF=False
        categoryid = rs("categoryid")
        categoryname = rs("categoryname")
    %>

        <a href="products.asp?categoryid=<%=categoryid%>">
          <%=categoryname%></a>
        <br>

    <%
        rs.MoveNext
     Wend

     Response.Write("</p>")

     rs.Close
     Set conn=Nothing
     %>

  </td>

  <td>
    <p class="center">
      Welcome to Telepinoy! Your gateway to quality phones online!
      <br><br>
      Please click <a href="products.asp">Cellphones</a> or 
      select from the categories at the left to start shopping
    </p>
  </td>
</tr>
</table>

</body>