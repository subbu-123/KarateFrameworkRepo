Feature: Schema validations

  Background: Defining the base url
    Given url 'http://localhost:8080/'
@Smoke @Regression
  Scenario: Usage of JS function, embedded expressions and simple schema validation
    Given path '/normal/webapi/add'
    And headers {'Accept': 'application/json', 'Content-Type' : 'application/json' }
    #javascript (js) methods usage in karate
    * def randomNumber = function() {return Math.floor((Math.random() * 100) + 1)}
    # embedded expressions syntax '#(variable_name)'
    # as the embedded expression used below is a js function so we have used parenthesis at the end
    And request
      """
      {
               "jobId": '#(randomNumber())',
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
    And match response ==
      """
      {
      "jobId": '#number',
      "jobTitle": '#string',
      "jobDescription": '#string',
      "experience": '#[] #string',
      "project": '#[] #object'
      }
      """
@Smoke
  Scenario: Usage of JS function, embedded expressions and complex schema validation
    Given path '/normal/webapi/add'
    And headers {'Accept': 'application/json', 'Content-Type' : 'application/json' }
    #javascript (js) methods usage in karate
    * def randomNumber = function() {return Math.floor((Math.random() * 100) + 1)}
    # embedded expressions syntax '#(variable_name)'
    # as the embedded expression used below is a js function so we have used parenthesis at the end
    And request
      """
      {
               "jobId": '#(randomNumber())',
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
    * def projectSchema =  {"projectName": '#string', "technology": '#[] #string' }
    * def mainSchema =
      """
       {
        "jobId": '#number',
        "jobTitle": '#string',
        "jobDescription": '#string',
        "experience": '#[] #string',
        "project": '#[] ##(projectSchema)'
        }
      """
    And match response == mainSchema
