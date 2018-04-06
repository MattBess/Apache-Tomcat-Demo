<%@page import="com.mbessler.webapp.BindListener"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Survey Servlet Example</title>
<style type="text/css">
h1		{font-size: xx-large;}
p		{font-size: medium;}
td		{font-size: medium;}
option	{font-size: medium;}
input	{font-size: medium;}
</style>
</head>

<body>

<h1>Session Demo</h1>
<p>

<h2>Binding Listeners to Sessions</h2>
<p>

<%-- Set up a static BindListener shared by all instances of this JSP.
	 There is probably only one instance, but just in case the server creates
	 multiple instances, this page can handle it. --%>
<%! 
	private static BindListener listener = new BindListener();
%>

<%
	BindListener localListener = null;
	
	//Allows the browser to pass a "removeListener" parameter to remove
	//a listener from the session
	if(request.getParameter("removeListener") != null){
		session.removeAttribute("listener");
	}
	
	//Allows the browser to pass a "resetSession" parameter to clear out
	//the session
	else if(request.getParameter("resetSession") != null){
		//Checking to see if there is already an existing session
		HttpSession oldSession = request.getSession(false);
		
		//An active session was found so we invalidate there old session
		//and start them fresh with a new session
		if(oldSession != null){
			//Getting the "localListener" this way we can notify the user if
			//their old session had a listener bounded to it or not
			localListener = (BindListener) oldSession.getAttribute("listener");
			oldSession.invalidate();
		}
		
		//Tell the user that the session was reset and show that the
		//bind counts have been updated. Make sure that there was a
		//listener on the old session, too.
		if(localListener != null){
			%>
			Your current session was reset.  The listener now has <%=localListener.getSessionCount()%> active sessions.
			<p>
			<%
		}
		else{
			%>
			Your old session did not have a listener.
			<%
		}
		
		//Resetting the listener
		localListener = null;
	}
	
	//Refreshing the page/no parameter was passed to the browser
	else{
		//Checking to see if the listener is already in the session
		localListener = (BindListener) session.getAttribute("listener");
		
		//If it's not, add the global copy of the listener to the session
		if(localListener == null){
			//Putting the global listener variable into the session
			session.setAttribute("listener", listener);
			localListener = listener;
		}
	}
%>

<%
	if(localListener != null){
		%>
		You have a listener bound to your session.
		<%
	}

	else{
		%>
		You do not have a listener bound to your session.
		<%
	}
%>
There are currently <%=listener.getSessionCount()%> sessions holding onto the bind listener.
<p>

<table>
<tr><td><a href="index.jsp">Refresh Form</a>
<tr><td><a href="index.jsp?removeListener">Remove Listener</a>
<tr><td><a href="index.jsp?resetSession">Reset Session</a>
</table>
<br>

<h2>Passing Session IDs Using "encodeUrl" Method</h2>
<p>

<%-- Encoding the URL so "Login.jsp" can get the current session ID --%>
<form action="<%=response.encodeURL("Login.jsp")%>" method="POST">
<table>
<tr><td>User Name:<td><input type="text" name="username">
<tr><td>Password:<td><input type="password" name="password">
</table>
<p>
<input type="submit" value="Login!">
</form>
<br>

<h2>Storing Application-Wide Data</h2>
<p>

<%
	String globalData = request.getParameter("global");

	if(globalData != null)
		application.setAttribute("global", globalData);
%>

<form action="<%=response.encodeURL("index.jsp")%>">
	<b>Global Data:</b> <%=application.getAttribute("global") %>
	<p>
	Edit the Global Data: <input type="text" name="global">
	
	<input type="submit" value="Edit!">
</form>
</body>

</html>