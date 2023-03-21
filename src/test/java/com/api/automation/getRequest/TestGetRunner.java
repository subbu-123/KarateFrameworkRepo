package com.api.automation.getRequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestGetRunner {
	
	@Test
	public Karate runTest() {
		return Karate.run("getRequest","responseMatcher").relativeTo(getClass());
	}

	//@Test
	public Karate runTestWithClassPath() {
		return Karate.run("classpath:com/api/automation/getRequest");
	}
	
	
}
