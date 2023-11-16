<% Option Explicit %>
<!DOCTYPE html>
<head>
  <title>Admin: Orders</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>

<!--#include file="adminheader.asp"-->
<!--#include file="connect.asp"-->

<h1 class="center">List of Orders</h1>

<p class="center">

  <%
    Dim orderid, orderdate, fullname, lastname, firstname, middlename, status
    Dim totalrecords

    status = Request.Form("orderstatus")
    If status = "" Then
      status = "PENDING"
    End If
  %>

  <form align="center" "name="statusfilter" method="post" action="adminorders.asp">
    Currently viewing <%=status%> orders<br>
    Change view to
      <select name="orderstatus">
	<option value="PENDING">PENDING</option>
	<option value="APPROVED">APPROVED</option>
	<option value="DELIVERED">DELIVERED</option>
        <option value="CANCELLED">CANCELLED</option>
      </select>
      <input type="submit" value="Go">
  </form>

  <table border="1" align="center">
	
  <tr class="center">
    <td class="title">ORDER DATE</td>
    <td class="title">ORDER ID</td>
    <td class="title">NAME</td>
    <td class="title">STATUS</td>
  </tr>

  <%
    SQL = "select * from orders"
    SQL = SQL & " where status='" & status & "'"
    SQL = SQL & " order by orderdate desc"
    rs.Open SQL, conn

    totalrecords = 0
    While rs.EOF = False
      orderdate = rs("orderdate")
      orderid = rs("orderid")
      lastname = rs("lastname")
      firstname = rs("firstname")
      middlename = rs("middlename")
      status = rs("status")
      fullname = Trim(firstname) & " " & Trim(middlename) & " " & Trim(lastname)

      Response.Write("<tr>")
      Response.Write("<td>" & orderdate & "</td>")
      Response.Write("<td><a href='adminorderdetails.asp?orderid=")
      Response.Write(orderid & "'>")
      Response.Write(orderid & "</a>")
      Response.Write("</td>")
      Response.Write("<td>" & fullname & "</td>")
      Response.Write("<td>" & status & "</td>")
      Response.Write("</tr>")

      totalrecords = totalrecords + 1
      rs.MoveNext
    Wend
  %>

</table

  Total records found: <%=totalrecords%>

</p>

  <%
    rs.Close
    Set conn=Nothing
  %>

</body>
</html>