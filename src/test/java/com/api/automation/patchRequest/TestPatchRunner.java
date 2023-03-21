package com.api.automation.patchRequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestPatchRunner {
	
	@Test
	public Karate runTest() {
		return Karate.run("classpath:com/api/automation/patchRequest");
	}
	
	
}
