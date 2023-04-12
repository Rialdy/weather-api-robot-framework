*** Settings ***
Library    RequestsLibrary
Library    Collections 
Library    JSONLibrary
Library    SeleniumLibrary
Resource    ../Resources/RealTimeWeather.robot
Variables    ../Libraries/variable.py

*** Test Cases ***
User Get Respond with Valid Data
    User Get The Data    ${X_RapidAPI_Key}    ${long_lat}
    User Validate Status Code    200
    User Validate the Respond Body

User Get Respond with Empty Parameter q
    User Get The Data    ${X_RapidAPI_Key}    ${empty_value}
    User Validate Status Code    400
    User Validate the Respond Body

User Get Respond with Invalid q
    User Get The Data    ${X_RapidAPI_Key}    ${invalid_data}
    User Validate Status Code    400
    User Validate the Respond Body

User Get Respond with Empty X_RapidAPI_Key
    User Get The Data    ${empty_value}    ${long_lat}
    User Validate Status Code    401
    User Validate the Respond Body

User Get Respond with Invalid X_RapidAPI_Key
    User Get The Data    ${invalid_data}    ${long_lat}
    User Validate Status Code    403
    User Validate the Respond Body

