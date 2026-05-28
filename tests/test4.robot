*** Settings ***
Library    Browser
Library    Collections
Library    BuiltIn

Suite Setup       Open SauceDemo
Suite Teardown    Close Browser


*** Variables ***
${URL}         https://www.saucedemo.com/
${USERNAME}    problem_user
${PASSWORD}    secret_sauce


*** Test Cases ***
Problem User Checkout Flow
    TRY
        Login To SauceDemo
        Sort Products Low To High
        Add Two Cheapest Products
        Checkout Products

        Log To Console
        ...    ✅ Checkout completed successfully

    EXCEPT    AS    ${error}
        Log To Console
        ...    ❌ Test Failed: ${error}

        Take Screenshot

        Fail
        ...    Test failed gracefully: ${error}
    END


*** Keywords ***
Open SauceDemo
    New Browser    chromium    headless=False
    New Context
    New Page    ${URL}


Login To SauceDemo
    Fill Text    id=user-name    ${USERNAME}
    Fill Text    id=password     ${PASSWORD}
    Click        id=login-button

    Wait For Elements State
    ...    css=.inventory_list
    ...    visible

    Log To Console
    ...    ✅ Login successful


Sort Products Low To High
    Select Options By
    ...    css=.product_sort_container
    ...    label
    ...    Price (low to high)

    ${selected}=    Get Property
    ...    css=.product_sort_container
    ...    value

    Log To Console
    ...    Selected Sort: ${selected}

    Should Be Equal
    ...    ${selected}
    ...    lohi

    Log To Console
    ...    ✅ Products sorted Low → High


Add Two Cheapest Products
    FOR    ${i}    IN RANGE    0    2

        ${product_name}=    Get Text
        ...    css=.inventory_item_name >> nth=${i}

        ${product_price}=    Get Text
        ...    css=.inventory_item_price >> nth=${i}

        Click
        ...    css=.inventory_item button >> nth=${i}

        Log To Console
        ...    ✅ Added ${product_name} - ${product_price}

    END


Checkout Products
    Click
    ...    css=.shopping_cart_link

    Wait For Elements State
    ...    css=.cart_item >> nth=0
    ...    visible

    ${cart_count}=    Get Element Count
    ...    css=.cart_item

    Log To Console
    ...    Cart Count: ${cart_count}

    Should Be Equal As Integers
    ...    ${cart_count}
    ...    2

    Click    id=checkout

    Fill Text    id=first-name    Abhishek
    Fill Text    id=last-name     Pandey
    Fill Text    id=postal-code   560001

    Click    id=continue
    Click    id=finish

    Wait For Elements State
    ...    css=.complete-header
    ...    visible

    ${success_message}=    Get Text
    ...    css=.complete-header

    Should Contain
    ...    ${success_message}
    ...    Thank you

    Log To Console
    ...    ✅ Order placed successfully