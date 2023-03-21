Feature: Use of json path in karate framework

  Background: Defining the base url
    Given url 'http://localhost:8080/'

  Scenario: To understand the use of Json path expressions
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    #Below expression evaluates the response and filters out those objects in the response array which have
    # jobId greater than 10 and stores the jobTitle values in a variable
    * def jobTitles = karate.jsonPath(response,"$[?(@.jobId > 10)].jobTitle")
    #Below we are validating that jobTitles array received in the previous step has size more than 1
    And match jobTitles == '#?_.length > 1'
