Feature: Validations to be performed on response received

  Background: 
    Given url URL

  Scenario: To get the response in JSON format
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And print response

  Scenario: To get the response in XML format
    Given path '/normal/webapi/all'
    And header Accept = 'application/xml'
    When method get
    Then status 200
    And print response

  Scenario: To get the response in JSON format and do assertions
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response ==
      """
      [
       {
           "jobId": 1,
           "jobTitle": "Software Engg",
           "jobDescription": "To develop andriod application",
           "experience": [
               "Google",
               "Apple",
               "Mobile Iron"
           ],
           "project": [
               {
                   "projectName": "Movie App",
                   "technology": [
                       "Kotlin",
                       "SQL Lite",
                       "Gradle"
                   ]
               }
           ]
       }
      ]
      """

  Scenario: To get the response in JSON format and do assertions
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match header Content-Type != 'application/xml'
    And match response !=
      """
      [
       {
           "jobId": 12,
           "jobTitle": "Software Engg",
           "jobDescription": "To develop andriod application",
           "experience": [
               "Google",
               "Apple",
               "Mobile Iron"
           ],
           "project": [
               {
                   "projectName": "Movie App",
                   "technology": [
                       "Kotlin",
                       "SQL Lite",
                       "Gradle"
                   ]
               }
           ]
       }
      ]
      """

  Scenario: To get the response in JSON format and do assertions
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match header Content-Type != 'application/xml'
    And match response contains deep {"jobDescription": "To develop andriod application"}
    And match response contains deep {"project": [{"projectName": "Movie App"}]}
