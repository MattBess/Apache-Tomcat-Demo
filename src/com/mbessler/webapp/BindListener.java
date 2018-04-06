package com.mbessler.webapp;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

public class BindListener implements HttpSessionBindingListener{

	private int sessionCount;
	
	public BindListener() {
		sessionCount = 0;
	}
	
	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		HttpSessionBindingListener.super.valueBound(event);
		sessionCount++;
	}
	 
	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		HttpSessionBindingListener.super.valueUnbound(event);
		sessionCount--;
	}
	
	public int getSessionCount() {
		return sessionCount;
	}
}
