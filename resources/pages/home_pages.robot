*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${IG_LOGO}            //*[@id="root"]/div/div[1]
${PROFILE_ICON}       //*[@id="root"]/div/div[2]/div[1]/div[2]
${PROFILE_BUTTON}     //*[@id="login-button"]
${PRODUCTS_HEADING}   //*[@id="header_container"]/div[2]/span
 
*** Keywords ***
Home Page Opened
  Wait Until Element Is Visible    ${PRODUCTS_HEADING}
  Element Should Be Visible        ${PRODUCTS_HEADING}