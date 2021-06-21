*** Settings ***
Resource          ../pages/login_pages.robot

*** Keywords ***
Input Username And Password
  [Arguments]   ${username}   ${password}
  Input Username                              ${username}
  Login Button Should Be Enabled
  Input Pass                                  ${password}
  Click Login Button
