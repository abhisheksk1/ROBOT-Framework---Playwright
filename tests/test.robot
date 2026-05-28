*** Settings ***
Library    Browser
Library    Collections
Library    OperatingSystem

*** Variables ***
${BASE_URL}      http://books.toscrape.com/
${OUTPUT_FILE}   ${EXECDIR}${/}mystery_books.csv


*** Test Cases ***
Scrape Mystery Books
    New Browser    chromium    headless=False
    Set Browser Timeout    30s
    New Context
    New Page    ${BASE_URL}    wait_until=domcontentloaded

    Click    text=Mystery

    Wait For Elements State
    ...    xpath=(//article[contains(@class,'product_pod')])[1]
    ...    visible

    ${all_books}=    Create List

    WHILE    True

        ${count}=    Get Element Count
        ...    xpath=//article[contains(@class,'product_pod')]

        Log To Console
        ...    Found ${count} books on page

        FOR    ${i}    IN RANGE    1    ${count + 1}

            ${title}=    Get Attribute
            ...    xpath=(//article[contains(@class,'product_pod')])[${i}]//h3/a
            ...    title

            ${price}=    Get Text
            ...    xpath=(//article[contains(@class,'product_pod')])[${i}]//*[contains(@class,'price_color')]

            ${rating_class}=    Get Attribute
            ...    xpath=(//article[contains(@class,'product_pod')])[${i}]//*[contains(@class,'star-rating')]
            ...    class

            ${availability}=    Get Text
            ...    xpath=(//article[contains(@class,'product_pod')])[${i}]//*[contains(@class,'instock')]

            ${availability}=    Evaluate    '${availability}'.strip()

            ${has_good_rating}=    Evaluate
            ...    'Four' in """${rating_class}""" or 'Five' in """${rating_class}"""

            ${in_stock}=    Evaluate
            ...    'In stock' in """${availability}"""

            IF    ${has_good_rating} and ${in_stock}

                ${rating}=    Evaluate
                ...    'Five' if 'Five' in """${rating_class}""" else 'Four'

                ${row}=    Set Variable
                ...    ${title},${price},${rating},${availability}

                Append To List
                ...    ${all_books}
                ...    ${row}

                Log To Console
                ...    Added Book: ${row}
            END
        END

        ${next_exists}=    Get Element Count
        ...    xpath=//li[@class='next']/a

        IF    ${next_exists} == 0
            BREAK
        END

        Click
        ...    xpath=//li[@class='next']/a

        Wait For Elements State
        ...    xpath=(//article[contains(@class,'product_pod')])[1]
        ...    visible
    END

    ${csv_content}=    Set Variable
    ...    Title,Price,Rating,Availability\n

    FOR    ${book}    IN    @{all_books}
        ${csv_content}=    Set Variable
        ...    ${csv_content}${book}\n
    END

    Create File
    ...    ${OUTPUT_FILE}
    ...    ${csv_content}
    ...    encoding=utf-8

    Log To Console
    ...    CSV Saved Successfully: ${OUTPUT_FILE}

    Close Browser