<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
	String username = (String) session.getAttribute("username");

	//There is a username stored in the session
	if(username != null && !username.equals("")){
		out.println("Welcome " + username + "!");
		%>
		<p>
		<a href="<%=response.encodeURL("index.jsp") %>">Click here to continue</a>
		<%
	}
	
	//There isn't a username stored in the session but one was
	//passed through as a parameter so we store it in the session
	else if((username = request.getParameter("username")) != null){
		session.setAttribute("username", username);
		response.sendRedirect(response.encodeRedirectUrl("Login.jsp"));
	}
	
	//There isn't a username stored in the session and no
	//username was passed to the browser as a parameter either
	//so we prompt them to login again.
	else{
		%>
		<form action="<%=response.encodeURL("Login.jsp")%>">
		Please enter your name: <input type="text" name="username">
		<p>
		<input type="submit" value="Login!">
		</form>
		<%
	}
%>
</body>
</html>