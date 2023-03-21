
Feature: Post HTTP method invocation

  Background: Defining the base url
    Given url URL

@Regression
  Scenario: sending request in the scenario
    Given path '/normal/webapi/add'
    #headers keyword accept multiple request headers in the form of key value pair
    And headers {Accept: 'application/json', Content-Type : 'application/json' }
    And request
      """
         {
             "jobId": 12,
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
@Smoke @Regression
  Scenario: sending request via external file
    Given path '/normal/webapi/add'
    #headers keyword accept multiple request headers in the form of key value pair
    And headers {'Accept': 'application/json', 'Content-Type' : 'application/json' }
    * def requestBody = read('../Request Payloads/postRequestPayload.json')
    * print requestBody
    And request requestBody
    When method post
    Then status 201
