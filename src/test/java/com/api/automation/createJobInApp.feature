@ignore
Feature: Creation of Jobs in application

  Background: Defining the base url
    Given url 'http://localhost:8080/'

  Scenario: Creating a job with job ID in application
    Given path '/normal/webapi/add'
    * def randomNumber = function() {return Math.floor((Math.random() * 100) + 1)}
    * def id = randomNumber()
    And headers {'Accept': 'application/json', 'Content-Type' : 'application/json' }
    And request
      """
       {
               "jobId": '#(id)',
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
