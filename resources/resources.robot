*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${MAIN_PAGE}      https://www.saucedemo.com/
${LOGIN_PAGE}     ${MAIN_PAGE}

*** Keywords ***
Open Main Page Using Chrome Browser
  Open Browser    ${MAIN_PAGE}    Chrome
  Maximize Browser Window

Open Login Page Using Chrome Browser
  Open Browser    ${LOGIN_PAGE}   Chrome
  Maximize Browser Window