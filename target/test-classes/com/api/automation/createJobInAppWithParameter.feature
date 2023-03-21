@ignore
Feature: Creation of Jobs in application

  Background: Defining the base url
  # the variable value sent by parent feature file calling this helper feature file can be used like below
  # by using the variable name directly as dcelared in parent feature file
    Given url URL

  Scenario: Creating a job with job ID in application
    Given path PATH
    And headers {'Accept': 'application/json', 'Content-Type' : 'application/json' }
    And request
      """
       {
               "jobId": '#(ID)',
               "jobTitle": "Bachelor in commerce",
               "jobDescription": "To do accounting",
               "experience": [
                   "Google",
                   "Apple",
                   "Sai krupa computer academy"
               ],
               "project": [
                   {
                       "projectName": "Accounts for car dekho",
                       "technology": [
                           "Tally",
                           "PGDCA"
                       ]
                   }
               ]
           }
      """
    When method post
    Then status 201
    And response.jobId == ID
