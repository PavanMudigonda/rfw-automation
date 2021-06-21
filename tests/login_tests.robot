*** Settings ***
Resource          ../resources/resources.robot
Resource          ../resources/pages/login_pages.robot
Resource          ../resources/pages/home_pages.robot
Resource          ../resources/steps/login_steps.robot
Test Setup        Open Login Page Using Chrome Browser
Test Teardown     Close Browser


*** Variables ***
${valid_username}       standard_user
${valid_password}       secret_sauce
${invalid_data}         qwerty

*** Test Cases ***
Valid Login
  GIVEN Login Page Opened
  WHEN Input Username And Password    ${valid_username}    ${valid_password}
  THEN Home Page Opened

Invalid Login
  [Template]    Login with Invalid Credentials
  # username   password
  ${valid_username}   ${invalid_data}
  ${invalid_data}   ${valid_password}
  ${invalid_data}   ${invalid_data}

*** Keywords ***
Login with Invalid Credentials
  [Arguments]   ${username}   ${password}
  GIVEN Login Page Opened
  WHEN Input Username And Password    ${username}    ${password}
  THEN Error Message Displayed