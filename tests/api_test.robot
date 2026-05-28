*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com


*** Test Cases ***
Test GET API
    [Documentation]    This test case demonstrates how to use the RequestsLibrary to make an API call and log the response.
    Create Session    session    ${BASE_URL}

    ${response}=    GET On Session
    ...    session
    ...    /posts/1

    Log To Console
    ...    Status Code: ${response.status_code}

    Log To Console
    ...    Response Body: ${response.text}

    Delete All Sessions

Test POST API
    [Documentation]    This test case demonstrates how to make a POST request using the RequestsLibrary and log the response.
    Create Session    session    ${BASE_URL}

    ${payload}=    Create Dictionary
    ...    title=foo
    ...    body=bar
    ...    userId=1

    ${response}=    POST On Session
    ...    session
    ...    /posts
    ...    json=${payload}

    Log To Console
    ...    Status Code: ${response.status_code}

    Log To Console
    ...    Response Body: ${response.text}

    Delete All Sessions