*** Settings ***
Library    Browser

*** Test Cases ***
Example Test
    New Browser    chromium    headless=False
    New Page       https://playwright.dev

    ${text}=    Get Text    h1
    Should Contain    ${text}    Playwright enables reliable web automation

    Close Browser