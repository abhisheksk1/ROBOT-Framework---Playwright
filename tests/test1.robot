*** Settings ***
Library    Browser
Library    OperatingSystem
Library    Collections

*** Variables ***
${BASE_URL}    http://books.toscrape.com/
${OUTPUT_CSV}    ${EXECDIR}${/}mystery_books.csv

*** Test Cases ***
Task 01 Scrape Mystery Books
    New Browser    chromium    headless=false
    New Page    ${BASE_URL}
    Click    xpath=//div[contains(@class,'side_categories')]//a[normalize-space(text())='Mystery']
    Wait For Elements State    xpath=(//article[contains(@class,'product_pod')])[1]    visible
    ${mystery_books}=    Scrape Mystery Books
    Log Many    ${mystery_books}
    Save Mystery Books To CSV    @{mystery_books}
    Close Browser

*** Keywords ***
Scrape Mystery Books
    ${all_rows}=    Create List
    FOR    ${page}    IN RANGE    1    100
        ${page_rows}=    Scrape Mystery Page
        FOR    ${row}    IN    @{page_rows}
            Append To List    ${all_rows}    ${row}
        END
        ${next_count}=    Get Element Count    xpath=//li[@class='next']/a
        Run Keyword If    ${next_count} == 0    Exit For Loop
        Click    xpath=//li[@class='next']/a
        Wait For Elements State    xpath=(//article[contains(@class,'product_pod')])[1]    visible
    END
    ${count_all}=    Evaluate    len($all_rows)
    Log    Scraped total ${count_all} rows
    RETURN    ${all_rows}

Scrape Mystery Page
    ${count}=    Get Element Count    css=ol.row li
    Log    Found ${count} items on page
    ${page_rows}=    Create List
    FOR    ${index}    IN RANGE    1    ${count + 1}
        ${base}=    Set Variable    css=ol.row li:nth-of-type(${index}) article.product_pod
        ${title}=    Get Attribute    ${base} h3 a    title
        ${price}=    Get Text    ${base} .price_color
        ${rating_class}=    Get Attribute    ${base} .star-rating    class
        ${rating}=    Get Book Rating    ${rating_class}
        ${availability}=    Get Text    ${base} .instock.availability
        ${availability}=    Evaluate    '${availability}'.strip()
        ${is_good}=    Run Keyword If    '${rating}' == 'Four' or '${rating}' == 'Five'    Set Variable    True    ELSE    Set Variable    False
        ${row}=    Set Variable    ${title},${price},${rating},${availability}
        Run Keyword If    ('${rating}' == 'Four' or '${rating}' == 'Five') and 'In stock' in '${availability}'    Log    Appending page row: ${row}
        Run Keyword If    ('${rating}' == 'Four' or '${rating}' == 'Five') and 'In stock' in '${availability}'    Append To List    ${page_rows}    ${row}
    END
    RETURN    ${page_rows}

Get Book Rating
    [Arguments]    ${rating_class}
    ${rating}=    Run Keyword If    'Five' in '${rating_class}'    Set Variable    Five    ELSE IF    'Four' in '${rating_class}'    Set Variable    Four    ELSE    Set Variable    Unknown
    RETURN    ${rating}

Save Mystery Books To CSV
    [Arguments]    @{rows}
    ${count}=    Evaluate    len($rows)
    Log    Saving ${count} rows to CSV
    ${csv_rows}=    Create List    Title,Price,Rating,Availability
    FOR    ${row}    IN    @{rows}
        Log    Adding row: ${row}
        Append To List    ${csv_rows}    ${row}
    END
    ${csv_content}=    Evaluate    '\\n'.join($csv_rows) + '\\n'
    Create File    ${OUTPUT_CSV}    ${csv_content}    encoding=utf-8
