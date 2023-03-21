Feature: Put HTTP method invocation

  Background: Defining the base url
    Given url URL

  Scenario: Updating the existing job on application using PUT by reading variables from helper feature file
    # Here we are using/reading the variables present in helper feature file
    # As a result we defined a variable when we did call read('')
    # To access the variable of helper feature file the syntax as per below example is createJob.id
    # As we are using the createJob.id inside request body in json format we used it in embedded expression format
    # remember whenever use a variable inside json object use it in embedded expression format
    * def createJob = call read('../createJobInApp.feature')
    Given path '/normal/webapi/update'
    And request
      """
       {
                "jobId": '#(createJob.id)',
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
                    },
                    
                    {
                        "projectName": "Accounts for Flipkart",
                        "technology": [
                            "JAVA",
                            "Oracle"
                        ]
                    }
                ]
            }
      """
    When method put
    Then status 200
    Given path '/normal/webapi/all'
    When method get
    Then status 200
    * def projectResponse = karate.jsonPath(response,'$[?(@.jobId =='+ createJob.id +')]')
    # output of karate.jsonPath() is always a json array irrespective of whether our output has only one json object like in below example
    # Therefore we use projectResponse[0] to access our json object and do teh validations
    And match projectResponse[0].project == '#[2]'

  Scenario: Updating the existing job on application using PUT by passing variables to helper feature file
    # Here we are passing the variables to helper feature file from here so that the api call in that file will be executed
    * def randomNumber = function() {return Math.floor((Math.random() * 100) + 1)}
    * def id = randomNumber()
    * call read('../createJobInAppWithParameter.feature') {'URL':'http://localhost:8080/', 'PATH':'/normal/webapi/add', 'ID':'#(id)'}
    Given path '/normal/webapi/update'
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
                    },
                    
                    {
                        "projectName": "Accounts for Flipkart",
                        "technology": [
                            "JAVA",
                            "Oracle"
                        ]
                    }
                ]
            }
      """
    When method put
    Then status 200
    Given path '/normal/webapi/all'
    When method get
    Then status 200
    * def projectResponse = karate.jsonPath(response,'$[?(@.jobId =='+ id +')]')
    And match projectResponse[0].project == '#[2]'
