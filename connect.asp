<%
  dim SQL, conn, rs
  set conn=Server.CreateObject ("ADODB.Connection")
  conn.Provider="Microsoft.Jet.OLEDB.4.0"
  conn.Open Server.MapPath ("db/products.mdb")

  set rs=Server.CreateObject ("ADODB.Recordset")
%>