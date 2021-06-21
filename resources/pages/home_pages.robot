*** Settings ***
Library       SeleniumLibrary

*** Variables ***
${IG_LOGO}            //*[@id="root"]/div/div[1]
${PROFILE_ICON}       //*[@id="root"]/div/div[2]/div[1]/div[2]
${PROFILE_BUTTON}     //*[@id="login-button"]

*** Keywords ***
Home Page Opened
  Wait Until Element Is Visible    ${IG_LOGO}
  Element Should Be Visible        ${IG_LOGO}
  Wait Until Element Is Visible    ${PROFILE_ICON}
  Element Should Be Visible        ${PROFILE_ICON}
  Wait Until Element Is Visible    ${PROFILE_BUTTON}
  Element Should Be Visible        ${PROFILE_BUTTON}