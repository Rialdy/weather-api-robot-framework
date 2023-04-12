*** Settings ***
Library    RequestsLibrary
Library    Collections 
Library    JSONLibrary
Library    SeleniumLibrary
Variables    ../Libraries/variable.py

*** Keywords ***
User Get The Data
    [Arguments]    ${X_RapidAPI_Key}    ${long_lat}
    ${header}=    Create Dictionary    X-RapidAPI-Key=${X_RapidAPI_Key}
    ${params}=    Create Dictionary    q=${long_lat}
    Create Session    real_time_weather    ${baseURL}
    ${real_time_weather_request}=    GET On Session    real_time_weather    /current.json    params=${params}    headers=${header}    expected_status=Anything
    ${real_time_weather_respond}=    Set Variable    ${real_time_weather_request.json()}    
    ${real_time_weather_request_status_code}=    Convert To String    ${real_time_weather_request.status_code}
    Set Test Variable    ${real_time_weather_respond}
    Set Test Variable    ${real_time_weather_request_status_code}

User Validate Status Code
    [Arguments]    ${expectedCodeStatus}
    Should Be Equal    ${real_time_weather_request_status_code}    ${expectedCodeStatus}

User Validate the Respond Body
    IF    ${real_time_weather_request_status_code} == 200
          ${location_name}    Get Value From Json    ${real_time_weather_respond}    $.location.name
          ${location_name}    Get From List    ${location_name}    0
          Should Not Be Empty    ${location_name}
    ELSE
        Log    Error Message is appear on the respond body
    END