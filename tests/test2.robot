*** Settings ***
Library    Browser
Library    Collections
Library    OperatingSystem

*** Variables ***
${filePath}    ${EXECDIR}${/}resources${/}download.jpg
${CSVFile}    ${EXECDIR}${/}resources${/}test_data.csv

*** Test Cases ***
Test Case 2
    Read Data from CSV

    New Browser    chromium    headless=false
    New Page    https://demoqa.com/automation-practice-form
    Fill Text    id=firstName    ${FIRST_NAME}
    Fill Text    id=lastName    ${LAST_NAME}
    Fill Text    id=userEmail    ${EMAIL}
    Enter DOB
    Check Checkbox    xpath=//input[@value='${GENDER}']
    Fill Text    id=userNumber    ${MOBILE}
    Select Subject from Suggestion
    Check Checkbox    xpath=//label[contains(text(), '${HOBBY}')]
    Upload Profile Pic
    Click    id=submit

*** Keywords ***
Enter DOB
    Click    id=dateOfBirthInput
    Select Options By    xpath=//select[@class='react-datepicker__year-select']    label    ${YEAR}
    Select Options By    xpath=//select[@class='react-datepicker__month-select']    label    ${MONTH}
    Click    xpath=//div[contains(@class,'react-datepicker__day') and text()='${DAY}']

Select Subject from Suggestion
    Fill Text    id=subjectsInput    Chemistry
    Press Keys    id=subjectsInput    Enter

Upload Profile Pic
    Upload File By Selector    id=uploadPicture    ${filePath}

Read Data from CSV
    ${data}=    Evaluate    list(csv.DictReader(open(r'''${CSVFile}''', newline='', encoding='utf-8-sig')))    modules=csv
    Log To Console    ${data}
    ${row}=    Get From List    ${data}    0
    ${first_name}=    Get From Dictionary    ${row}    first_name
    ${last_name}=    Get From Dictionary    ${row}    last_name
    ${email}=    Get From Dictionary    ${row}    email
    ${gender}=    Get From Dictionary    ${row}    gender
    ${mobile}=    Get From Dictionary    ${row}    mobile
    ${hobby}=    Get From Dictionary    ${row}    hobby
    ${year}=    Get From Dictionary    ${row}    year
    ${month}=    Get From Dictionary    ${row}    month
    ${day}=    Get From Dictionary    ${row}    day
    Set Suite Variable    ${FIRST_NAME}    ${first_name}
    Set Suite Variable    ${LAST_NAME}    ${last_name}
    Set Suite Variable    ${EMAIL}    ${email}
    Set Suite Variable    ${GENDER}    ${gender}
    Set Suite Variable    ${MOBILE}    ${mobile}
    Set Suite Variable    ${HOBBY}    ${hobby}
    Set Suite Variable    ${YEAR}    ${year}
    Set Suite Variable    ${MONTH}    ${month}
    Set Suite Variable    ${DAY}    ${day}
