*** Settings ***
Resource    ../pages/loginPage.robot
Resource    ../pages/productsPage.robot
Resource    ../pages/addToCartPage.robot
Resource    ../pages/checkoutPage.robot
Library    Browser
Suite Setup    New Browser    ${BROWSER}    headless=false
Test Setup    New Context
Test Teardown    Close Context
Suite Teardown    Close Browser

*** Variables ***
${BROWSER}    chromium
${URL}        https://www.saucedemo.com/

*** Test Cases ***
Test Case 3
    New Page       ${URL}
    loginPage.Login
    productsPage.Sort L2H and Select 2 Products
    addToCartPage.Go to Add to Cart Page and Verify the Products
    checkoutPage.Fill detail on Checkout Page
    checkoutPage.Verify the Price
    checkoutPage.Finish the Order