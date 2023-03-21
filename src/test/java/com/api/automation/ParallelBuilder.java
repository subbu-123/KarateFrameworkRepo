package com.api.automation;

import org.junit.jupiter.api.Test;

import com.intuit.karate.Runner.Builder;


public class ParallelBuilder {

	@Test
	public void runTestsParallel() {
		Builder aRunner = new Builder();
		aRunner.path("classpath:com/api/automation/getRequest");
		aRunner.parallel(5); // 5 is the thread count
	}
}
