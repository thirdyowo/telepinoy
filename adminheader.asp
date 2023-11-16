<%
  If Session("user")=Empty Then
    Response.Redirect("admin.asp")
  End If
%>

<h1 class="header">Telepinoy</h1>
<p>
<a href="adminorders.asp">Orders</a>
<a href="adminproducts.asp">Products</a>
<a href="adminlogout.asp">Logout</a>
</p>