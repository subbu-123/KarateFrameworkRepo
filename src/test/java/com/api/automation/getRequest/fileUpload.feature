Feature: Uploading of file using karate

  Background: Defining the base url
    Given url 'http://localhost:8080/'

  Scenario: To upload a file using karate framework
    Given path '/normal/webapi/upload'
    # 'multipart file' is the keyword provided by karate 
    # Here another file used is the parameter name provided by api developer
    And multipart file file = { read:'garbage.txt', filename:'garbage.txt', contentType: 'multipart/form-data' }
    When method post
    Then status 200
    And match response.message contains 'garbage.txt'
 