package com.api.automation;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import org.apache.commons.io.FileUtils;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;

import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class ParallelRunnerWithCucumberReport {

	@Test
	public void runTestsParallel() {
		File file = new File("target/cucumber-html-reports/");
		String[] myFiles;
		if (file.isDirectory()) {
			myFiles = file.list();
			for (int i = 0; i < myFiles.length; i++) {
				File myFile = new File(file, myFiles[i]);
				System.out.println("Deleteing files: " + myFile);
				myFile.delete();
			}
		}

		Results result = Runner.path(getLocation()).tags(getTags()).outputCucumberJson(true).parallel(5);
		generateReport(result.getReportDir());
		System.out.println(result.getReportDir());
		Assertions.assertEquals(0, result.getFailCount());
	}

	public static void generateReport(String karateOutputPath) {
		Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] { "json" }, true);
		List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
		jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
		Configuration config = new Configuration(new File("target"), "Karate Cucumber Report");
		ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
		reportBuilder.generateReports();
	}

	
	private List<String> getLocation()
	{
		String aLocation = System.getProperty("location");
		List<String> locationList = Collections.emptyList();
		// Here we are checking if the string aLocations contains delimiter ","
		if(aLocation.contains(","))
		{
			// Splitting the string with comma(,) delimiter to get all the locations path
			String[] locationArray = aLocation.split(",");
			locationList = Arrays.asList(locationArray);
			// Adding every location path with a prefix of classpath:
			locationList.replaceAll(e -> {
				return "classpath:" + e;
				});
			return locationList;
		}
		
		locationList = Arrays.asList("classpath:" + aLocation);
		return locationList; 
	}
	
	private List<String> getTags()
	{
		String aTags = System.getProperty("tags");
		List<String> tagList = Collections.emptyList();
		// Here we are checking if the string aTags contains delimiter ","
		if(aTags.contains(","))
		{
			// Splitting the string with comma(,) delimiter to get all the tags path
			String[] tagArray = aTags.split(",");
			tagList = Arrays.asList(tagArray);
			return tagList;
		}
		
		tagList = Arrays.asList(aTags);
		return tagList; 
	}
	
}
