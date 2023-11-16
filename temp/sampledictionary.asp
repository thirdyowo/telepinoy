<% Option Explicit %>
<html>
<head>
  <title>A Sample Scripting Dictionary</title>
</head>
<body>
<p>

<%
  Dim d
  Set d=Server.CreateObject ("Scripting.Dictionary")
  d.Add "1","One"
  d.Add "2","Two"
  d.Add "3","Three"
  d.Add "4","Four"
  d.Add "5","Five"
  d.Add "6","Six"
  d.Add "7","Seven"
  d.Add "8","Eight"
  d.Add "9","Nine"
  d.Add "10","Ten"

  Response.Write("The value of key 5 is: " & d.Item("5"))
  Set d = Nothing
%>

</p>
</body>
</html>