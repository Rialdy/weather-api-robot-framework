*** Settings ***
Library    RequestsLibrary
Library    Collections 
Library    JSONLibrary
Library    SeleniumLibrary
Resource    ../Resources/ForecastWeather.robot

*** Test Cases ***
User Get Respond with Valid Data
    User Get The Data
    User Validate Status Code    200
    User Validate the Respond Body
