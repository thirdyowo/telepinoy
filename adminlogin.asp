<% Option Explicit %>
<html>
<head>
  <title>Admin System: Login</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>

  <!--#include file="connect.asp"-->
  <%
    Dim username, password

    username=Request.Form("username")
    password=Request.Form("password")

    SQL="select * from users where username='"
    SQL=SQL & username & "' and password='" & password & "'"

    rs.Open SQL, conn

    if rs.EOF=True Then
      Response.Write("<h1 align='center'>ACCESS DENIED</h1>")
      rs.Close
      set conn=Nothing
    Else
      rs.Close
      set conn=Nothing
      Session("user")=username
      Response.Redirect("adminorders.asp")
    End if
  %>

</body>
</html>