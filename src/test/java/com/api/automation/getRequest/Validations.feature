Feature: Validations to be performed on response received

  Background: 
    Given url 'http://localhost:8080/'

  Scenario: To get the response in JSON format and do assertions via navigating to the path in JSON response
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response[0].jobTitle == 'Software Engg'
    And match response[0].jobId != 12
    And match response[0].project[0].projectName !contains 'Movie App1'
    And match response[0].project[0].technology contains 'SQL Lite'
    #Below code is used to validate the size of an array
    And match response[0].project[0].technology == '#[3]'

  Scenario: To get the response in JSON format and do assertions using wildcards
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response[*].jobTitle contains 'Software Engg'
    #using wildcard(*) we can validate exact response by using == operator or can use contains to validate any one item in response
    #Note the order will remain the same as that of the response received otherwise our assertion will fail
    And match response[0].project[*].technology[*] == ["Kotlin","SQL Lite","Gradle"]
    And match response[*].experience[*] !contains 'Samsung'

  Scenario: To get the response in JSON format and do assertions via fuzzy matchers
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match response[0].jobTitle == '#present'
    And match response[0].jobTitle == '#string'
    And match response[0].jobId != '#null'
    And match response[0].jobId == '#number'
    And match response[*].experience == '#notnull'
    And match response[0].project[0].projectName == '#ignore'
    And match response[0].project[0].technology == '#array'
    #each keyword validates each element of an array is string or not
    And match each response[0].project[0].technology == '#string'
    #complex fuzzy matchers
    #'#[]' -> used to validate if that json object is an array or not
    And match response[0].project[0].technology == '#?_.includes("Kotlin")'
    #below expression validates that jobID obj is a number greater than equal to zero
    And match response[0].jobId == '#number?_ >= 0'
    #below expression validates that technology obj is an array of size 3,every element inside it is a string and every string length is greater than 2
    And match response[0].project[0].technology == '#[3] #string?_.length >=2'
    #Below expression uses regular expression to match the characters present in jobDescription field
    #And match response[0].jobDescription == '#regex \.*'
    And match response[0].jobDescription == '#regex [A-Za-z\\s]+'
