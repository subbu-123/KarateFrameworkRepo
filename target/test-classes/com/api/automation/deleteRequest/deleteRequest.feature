Feature: Delete HTTP method

  Background: 
    Given url URL
    * def createJob = callonce read('../createJobInApp.feature')

  Scenario: To delete a job profile by Delete HTTP method
    Given path '/normal/webapi/remove/' + createJob.id
    And header Accept = 'application/json'
    When method delete
    Then status 200
    
    Given path '/normal/webapi/find'
    And params {id: '#(createJob.id)', jobTitle: '#(createJob.response.jobTitle)'}
    When method get
    Then status 404
