*** Settings ***
Resource    ../pages/loginPage.robot
Resource    ../pages/productsPage.robot
Resource    ../pages/addToCartPage.robot
Resource    ../pages/checkoutPage.robot
Library    Browser

*** Test Cases ***
Test Case 3
    New Browser    chromium    headless=false
    New Page       https://www.saucedemo.com/
    loginPage.Login
    productsPage.Sort L2H and Select 2 Products
    addToCartPage.Go to Add to Cart Page and Verify the Products
    checkoutPage.Fill detail on Checkout Page
    checkoutPage.Verify the Price
    checkoutPage.Finish the Order

Test Case 4
    [Documentation]    Bonus: Re-run the flow for problem_user and gracefully handle any broken UI states encountered
    New Browser    chromium    headless=false
    New Page       https://www.saucedemo.com/
    Fill Text    id=user-name    problem_user
    Fill Text    id=password    secret_sauce
    Click    id=login-button
    Run Keyword And Continue On Failure    productsPage.Sort L2H and Select 2 Products
    Run Keyword And Continue On Failure    addToCartPage.Go to Add to Cart Page and Verify the Products
    Run Keyword And Continue On Failure    checkoutPage.Fill detail on Checkout Page
    Run Keyword And Continue On Failure    checkoutPage.Verify the Price
    Run Keyword And Continue On Failure    checkoutPage.Finish the Order