<% Option Explicit %>
<html>
<head>
  <title>A Sample Scripting Dictionary</title>
</head>
<body>
<p>

<%
  Dim d, k, i, a, c
  
  If IsObject(Session("publicDictionary")) = True Then
    Set d = Session("publicDictionary")
  Else
    Set d=Server.CreateObject("Scripting.Dictionary")
  End If

  'retrieve the form data and save them in variables k and i
  k = Request.Form("key")
  i = Request.Form("item")

  'check if the key exists
  If d.Exists(k) = True Then
    d.Item(k) = 1  'replace the item with the new one
  Else
    d.Add k,i      'add the key/item pair to the dictionary
  End If

  'get all keys in the dictionary as an array
  a = d.Keys

  'display all the keys and items using the array
  For c = 0 to d.Count - 1
    Response.Write("Key: " & a(c) & "<br>")
    Response.Write("Item: " & d.Item(a(c)) & "<br><br>")
  Next

  'save dictionary to a session variable
  Set Session("publicDictionary") = d

  Set d = Nothing
%>

</p>
</body>
</html>