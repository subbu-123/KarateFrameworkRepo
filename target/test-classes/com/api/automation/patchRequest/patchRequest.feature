Feature: Patch HTTP method

  Background: 
    Given url URL
    * def createJob = callonce read('../createJobInApp.feature')

  Scenario: To update a job profile partially with patch http method
    * def jobDesc = 'To manage finances of Accounting firms'
    Given path '/normal/webapi/update/details'
    And params {id: '#(createJob.id)', jobTitle : '#(createJob.response.jobTitle)', jobDescription : '#(jobDesc)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 200
    And match response.jobDescription == jobDesc

  Scenario: To update a job profile partially with patch http method having incorrect query parameter
    * def jobDesc = 'To manage finances of Accounting firms'
    Given path '/normal/webapi/update/details'
    And params {jobTitle : '#(createJob.response.jobTitle)', jobDescription : '#(jobDesc)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 400

  Scenario: To update a job profile partially with patch http method providing incorrect Job ID
    * def jobDesc = 'To manage finances of Accounting firms'
    Given path '/normal/webapi/update/details'
    And params {id: '3452', jobTitle : '#(createJob.response.jobTitle)', jobDescription : '#(jobDesc)'}
    And header Accept = 'application/json'
    And request {}
    When method patch
    Then status 404
