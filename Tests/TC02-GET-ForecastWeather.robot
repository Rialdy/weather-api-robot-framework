*** Settings ***
Library    RequestsLibrary
Library    Collections 
Library    JSONLibrary
Library    SeleniumLibrary
Resource    ../Resources/ForecastWeather.robot
Variables    ../Libraries/variable.py

*** Test Cases ***
User Get Respond with Valid Data
    User Get The Data    ${X_RapidAPI_Key}    ${country}    ${days}
    User Validate Status Code    200
    User Validate the Respond Body

User Get Respond with Empty q
    User Get The Data    ${X_RapidAPI_Key}    ${empty_value}    ${days}
    User Validate Status Code    400
    User Validate the Respond Body

User Get Respond with Invalid q
    User Get The Data    ${X_RapidAPI_Key}    ${invalid_data}    ${days}
    User Validate Status Code    400
    User Validate the Respond Body

User Get Respond with Empty Days
    User Get The Data    ${X_RapidAPI_Key}    ${invalid_data}    ${empty_value}
    User Validate Status Code    400
    User Validate the Respond Body

User Get Respond with Invalid Days
    User Get The Data    ${X_RapidAPI_Key}    ${invalid_data}    ${invalid_data}
    User Validate Status Code    400
    User Validate the Respond Body

User Get Respond with Empty X_RapidAPI_Key
    User Get The Data    ${empty_value}    ${invalid_data}    ${days}
    User Validate Status Code    401
    User Validate the Respond Body

User Get Respond with Invalid X_RapidAPI_Key
    User Get The Data    ${invalid_data}    ${invalid_data}    ${days}
    User Validate Status Code    403
    User Validate the Respond Body