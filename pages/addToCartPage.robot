*** Settings ***
Documentation    This Page hold the info about the Add to Cart Page.
Library    Browser

*** Keywords ***
Go to Add to Cart Page and Verify the Products
    Click    [data-test='shopping-cart-link']
    ${cart_title}=    Get Text    [data-test='title']
    Should Be Equal As Strings    ${cart_title}    Your Cart
    ${item_count}=    Get Element Count    [data-test='inventory-item']
    Should Be Equal As Integers    ${item_count}    2
