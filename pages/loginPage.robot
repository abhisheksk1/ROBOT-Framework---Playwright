*** Settings ***
Documentation    This page hold the info about Login Page
Library    Browser

*** Variables ***
${txtUsername}    id=user-name
${txtPassword}    id=password
${btnLogin}    id=login-button

*** Keywords ***
Login
    Fill Text      ${txtUsername}    standard_user
    Fill Text      ${txtPassword}    secret_sauce
    Click          ${btnLogin}
    Get Text    //span[@data-test='title']    ==    Products