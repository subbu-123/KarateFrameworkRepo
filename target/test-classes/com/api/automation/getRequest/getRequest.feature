Feature: Test the GET method for application

  #keeping base url under background keyword
  Background: 
    Given url 'http://localhost:8080/'
    And print '------------Base URL----------'
 #this works like system.out.println
 
 
  Scenario: To test the GET HTTP method is returning all the values from our application
    #Given url 'http://localhost:8080/normal/webapi/all'
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200

  Scenario: To test the GET HTTP method is returning all the values from our application
    #Given url 'http://localhost:8080'
    And path '/normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
