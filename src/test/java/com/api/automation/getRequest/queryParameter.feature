Feature: Usage of query parameter

  Background: 
    Given url 'http://localhost:8080/'
    * def createJob = callonce read('../createJobInApp.feature')

  Scenario: Filter out data received from GET call as per our search criteria using query parameter
    Given path '/normal/webapi/find'
    #And param id = createJob.id
    #And param jobTitle = createJob.response.jobTitle
    And params {id: '#(createJob.id)', jobTitle : '#(createJob.response.jobTitle)'}
    When method get
    Then status 200
    And match response.jobId == createJob.id
