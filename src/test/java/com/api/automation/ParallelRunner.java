package com.api.automation;


import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;


public class ParallelRunner {
	
	@Test
	public void runTestsParallel() {
		
		Results result = Runner.path("classpath:com/api/automation").parallel(5);

		
		/* As we are using junit @Test annotation so even if some of our test scenarios fail the Junit runner 
		always show green. Therefore we need to add assertion to decide our runner is passed or failed
		*/
		
		System.out.println(result.getFeaturesTotal());	
		System.out.println(result.getScenariosTotal());	
		
		Assertions.assertEquals(0, result.getFailCount());
	}

}
