*** Settings ***
Documentation    This Page Hold the info about the Checkout Page
Library    Browser
Library    String

*** Variables ***
${itemTotal}    [data-test='subtotal-label']
${taxPrice}    [data-test='tax-label']
${totalPrice}    [data-test='total-label']

*** Keywords ***
Fill detail on Checkout Page
    Click    id=checkout
    Fill Text    id=first-name    alex
    Fill Text    id=last-name     joe
    Fill Text    id=postal-code    12345
    Click    id=continue

Verify the Price
    ${itemTotal_text}=    Get Text    ${itemTotal}
    ${itemTotal_amount}=    Fetch From Right    ${itemTotal_text}    $
    ${taxPrice_text}=    Get Text    ${taxPrice}
    ${taxPrice_amount}=    Fetch From Right    ${taxPrice_text}    $
    ${totalPrice_text}=    Get Text    ${totalPrice}
    ${totalPrice_amount}=    Fetch From Right    ${totalPrice_text}    $
    ${calculated_total}=    Evaluate    ${itemTotal_amount} + ${taxPrice_amount}
    Log    Item Total: ${itemTotal_amount}
    Log    Tax Price: ${taxPrice_amount}
    Log    Total Price: ${totalPrice_amount}
    Log    Calculated Total (Item + Tax): ${calculated_total}
    Should Be Equal As Numbers    ${calculated_total}    ${totalPrice_amount}    Item Total + Tax should equal Total Price

Finish the Order
    Click    id=finish
    Get Text    [data-test='complete-header']    ==    Thank you for your order!