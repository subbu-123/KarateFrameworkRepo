package com.api.automation.putRequest;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

public class TestPutRunner {
	
	@Test
	public Karate runTest() {
		return Karate.run("putRequest").relativeTo(getClass());
	}
	
	
}
