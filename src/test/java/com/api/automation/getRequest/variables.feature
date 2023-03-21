Feature: Use of variables in karate

  #syntax of declaring variables
  # *def <variable_name> = <value>
  Background: 
    * def var1 = 'Google'
    * def var2 = 20
    Given url 'http://localhost:8080/'

  Scenario: Printing local and Global variables
    Given def var3 = 30
    And def var4 = var3*var2
    * print var1, var2
    * print "local variable 1",var3
    * print "local variable 2",var4

  Scenario: To get the response in JSON format and do assertions
    Given path '/normal/webapi/all'
    And header Accept = 'application/json'
    When method get
    Then status 200
    And match header Content-Type != 'application/xml'
    #read() method in karate is used to read data from another file. Here response is stored in another json file and we will capture the 
    # data in a variable and use that variable to match with our actual response
    * def expectedResponse = read('../Responses/getApiResponse.json')
    * print expectedResponse
    And match response == expectedResponse
    
