package com.api.automation.postRequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestPostRunner {
	
	@Test
	public Karate runTest() {
		return Karate.run("classpath:com/api/automation/postRequest").tags("~@ignore").tags("@Regression");
	}
	
	
}
