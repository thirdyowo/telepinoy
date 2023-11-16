<html>
<head>
  <title>Products</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>
<!--#include file="header.asp"-->

<p class="center">
Please select a product model below<br><br>

<!--#include file="connect.asp"-->

  <%
    dim categoryid, categoryname, productname

    SQL = "select * from products "
    SQL = SQL & " inner join category on "
    SQL = SQL & " products.categoryid=category.categoryid "

    categoryid = Request.QueryString("categoryid")

    If categoryid<>"" Then
	SQL = SQL & " where products.categoryid=" & categoryid
    End If

    rs.Open SQL, conn

    While rs.EOF=False
  %>

	    <%=rs("categoryname")%>
	    <a href="productinfo.asp?productname=<%=rs ("productname") %>">
	    <%=rs("productname")%></a><br>

  <%
	rs.MoveNext
    Wend

    rs.Close
    Set conn = Nothing
  %>

</p>	
</body>
</html>