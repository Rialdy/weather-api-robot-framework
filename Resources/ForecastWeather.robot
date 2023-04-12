*** Settings ***
Library    RequestsLibrary
Library    Collections 
Library    JSONLibrary
Library    SeleniumLibrary
Variables    ../Libraries/variable.py

*** Keywords ***
User Get The Data
    [Arguments]    ${X_RapidAPI_Key}    ${country}    ${days}
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
          ${location_region}    Get Value From Json    ${forecast_weather_respond}    $.location.region
          ${location_region}    Get From List    ${location_region}    0
          Should Not Be Empty    ${location_region}
          ${location_country}    Get Value From Json    ${forecast_weather_respond}    $.location.country
          ${location_region}    Get From List    ${location_country}    0
          Should Not Be Empty    ${location_country}
          ${location_lat}    Get Value From Json    ${forecast_weather_respond}    $.location.lat
          ${location_lat}    Get From List    ${location_lat}    0
          ${location_lat}    Convert To String    ${location_lat}
          Should Not Be Empty    ${location_lat}
          ${location_lon}    Get Value From Json    ${forecast_weather_respond}    $.location.lon
          ${location_lon}    Get From List    ${location_lon}    0
          ${location_lon}    Convert To String    ${location_lon}
          Should Not Be Empty    ${location_lon}
          ${location_tz_id}    Get Value From Json    ${forecast_weather_respond}    $.location.tz_id
          ${location_tz_id}    Get From List    ${location_tz_id}    0
          Should Not Be Empty    ${location_tz_id}
          ${location_localtime_epoch}    Get Value From Json    ${forecast_weather_respond}    $.location.localtime_epoch
          ${location_localtime_epoch}    Get From List    ${location_localtime_epoch}    0
          ${location_localtime_epoch}    Convert To String    ${location_localtime_epoch}
          Should Not Be Empty    ${location_localtime_epoch}
          ${location_localtime}    Get Value From Json    ${forecast_weather_respond}    $.location.localtime
          ${location_localtime}    Get From List    ${location_localtime}    0
          Should Not Be Empty    ${location_localtime}

    ELSE
        Log    Error Message is appear on the respond body
    END


