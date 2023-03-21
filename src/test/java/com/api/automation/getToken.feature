@ignore
Feature: Generate JWT token

  Background: 
    Given url 'http://localhost:9090/'

  Scenario: Register a new user and generate token
    Given path '/users/sign-up'
    And header Accept = 'application/json'
    And request
      """
      {
        "password": "#(password)",
        "username": "#(username)"
      }
      """
    When method post
    Then status 200
    
    #Generate token for registered user
    Given path '/users/authenticate'
    And headers {Accept : 'application/json', Content-Type : 'application/json'}
    And request
      """
      {
        "password": "#(password)",
        "username": "#(username)"
      }
      """
    When method post
    Then status 200
    * def authToken = response.token
