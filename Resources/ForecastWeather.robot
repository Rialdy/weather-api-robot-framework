*** Settings ***
Library    RequestsLibrary
Library    Collections 
Library    JSONLibrary
Library    SeleniumLibrary
Variables    ../Libraries/variable.py

*** Keywords ***
User Get The Data
    ${header}=    Create Dictionary    X-RapidAPI-Key=${X_RapidAPI_Key}
    ${params}=    Create Dictionary    q=${country}    days=${days}
    Create Session    forecast_weather    ${baseURL}
    ${forecast_weather_request}=    GET On Session    forecast_weather    /forecast.json    params=${params}    headers=${header}    expected_status=Anything
    ${forecast_weather_respond}=    Set Variable    ${forecast_weather_request.json()}    
    ${forecast_weather_request_status_code}=    Convert To String    ${forecast_weather_request.status_code}
    Set Test Variable    ${forecast_weather_respond}
    Set Test Variable    ${forecast_weather_request_status_code}

User Validate Status Code
    [Arguments]    ${expectedCodeStatus}
    Should Be Equal    ${forecast_weather_request_status_code}    ${expectedCodeStatus}

User Validate the Respond Body
    IF    ${forecast_weather_request_status_code} == 200
          ${location_name}    Get Value From Json    ${forecast_weather_respond}    $.location.name
          ${location_name}    Get From List    ${location_name}    0
          Should Not Be Empty    ${location_name}
    ELSE
        Log    Error Message is appear on the respond body
    END