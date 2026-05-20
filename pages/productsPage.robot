*** Settings ***
Documentation    This page hold the info about Product Page
Library    Browser

*** Variables ***


*** Keywords ***
Sort L2H and Select 2 Products
    Select Options By    [data-test='product-sort-container']    value    lohi
    Click    (//button[contains(text(), 'Add to cart')])[1]
    Click    (//button[contains(text(), 'Add to cart')])[2]