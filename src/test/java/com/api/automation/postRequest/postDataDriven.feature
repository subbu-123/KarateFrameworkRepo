Feature: Post HTTP method invocation with data driven request payload

  Background: Defining the base url
    Given url URL

  # In karate framework only we can use the column header within scenario outline to distinguish multiple scenarios executed
 @Smoke @Regression
  Scenario Outline: Creating a job with job ID <jobId>
    Given path '/normal/webapi/add'
    And headers {'Accept': 'application/json', 'Content-Type' : 'application/json' }
    # Inside the request body we have to use embedded expressions to pass the data instead of <column_header-name>
    And request
      """
         {
             "jobId": '#(jobId)',
             "jobTitle": '#(jobTitle)',
             "jobDescription": '#(jobDescription)',
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
    # If we have to use the data as number then syntax is <column_header_name>
    # If we have to use the data as string then syntax is '<column_header_name>'
    Then status <status>

    Examples: 
      | jobId | jobTitle               | jobDescription     | status |
      |  9765 | Bachelor in science    | Science student    |    201 |
      |  9778 | Bachelor in metallurgy | metallurgy student |    201 |

 @Regression
  Scenario Outline: Creating a job with job ID <jobId> by reading CSV file
    Given path '/normal/webapi/add'
    And headers {'Accept': 'application/json', 'Content-Type' : 'application/json' }
    And request
      """
         {
             "jobId": '<jobId>',
             "jobTitle": '<jobTitle>',
             "jobDescription": '<jobDescription>',
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
    Then status <status>
    And response.jobTitle == '<jobTitle>'

    Examples: 
      | read('../Test Data/TestData.csv') |
