Feature: Retrieve all the jobs listed on job portal

  Background: 
    Given url 'http://localhost:9090/'
    * def token = callonce read('../getToken.feature') {username:'baba yaga', password:'bhoot_nikal_ke_bhaga'}

  Scenario: GET call to retrieve all the job ID's with token
    Given path '/auth/webapi/all'
    * def authHeader = 'Bearer ' + token.authToken
    And headers {Accept : 'application/json', Authorization : '#(authHeader)'} 
    When method get
    Then status 200

    Scenario: GET call to retrieve all the job ID's without token
    Given path '/auth/webapi/all'
    And headers {Accept : 'application/json'} 
    When method get
    Then status 401
