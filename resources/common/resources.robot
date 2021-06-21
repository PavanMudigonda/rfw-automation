*** Settings ***
Library       SeleniumLibrary
Library       BuiltIn
Library       OperatingSystem
Library       Collections
Library       String
Library       robot.api.logger
Library       ExcelRobot
Library       REST  ssl_verify=false


*** Variables ***

# Variables for UI

${MAIN_PAGE}      https://www.saucedemo.com/
${LOGIN_PAGE}     ${MAIN_PAGE}
${url}            ${EMPTY}
${colCount}       ${EMPTY}
${sSheetName}     ${EMPTY}
${y}              ${EMPTY}
${header}         ${EMPTY}
${sColumnName}    ${EMPTY}
${sColNum}        ${EMPTY}
${iTotalRows}     ${EMPTY}
${sSheetName}     ${EMPTY}
${iRowNo}         ${EMPTY}
${iTotalRows}     ${EMPTY}
${TC_Num}         ${EMPTY}
${sSearchedData}   ${EMPTY}
${TC_Num}         ${EMPTY}
${sTestCaseNo}    ${EMPTY}

# Variables for API

${env}
${apiUrl}
${email}
${expected}
${auth}
${serviceName}
${uri}

*** Keywords ***

# UI Keywords

Open Main Page Using Chrome Browser
  Open Browser    ${MAIN_PAGE}    Chrome
  Maximize Browser Window

Open Login Page Using Chrome Browser
  Open Browser    ${LOGIN_PAGE}   Chrome
  Maximize Browser Window

Get Data Path URL and Browser
    [Documentation]  Fetching excel path and setting env variables from excel
    [Arguments] ${Service_Name}
    # Open Env Test data sheet
    Open Excel  ./Resources/devdata/env.xls
    ${url}=   Excelrobot.Read Cell Data  by Name    env    B2 
    Set Global Variable   ${url}


#  Excel Keywords

Get Data from Excel with given column
    [Arguments]  ${sSheetName}  ${sTestCaseNo}  ${sColumnName}
    ${colCount}   Get Column Count    ${sSheetName}
    FOR ${y}   IN RANGE   0   ${colCount}
        ${header}  Read Cell Data  ${sSheetName}   ${y}  0
        #checking header
        Run Keyword If "${header}"=="${sColumnName}"  Set Test Variable  ${sColNum}  ${y}
    END
    # Get total number of rows in sheet
    ${iTotalRows}  ExcelRobot.Get Row Count   ${sSheetName}
    FOR  ${iRowNo}  IN RANGE  1   ${iTotalRows}+1
          ${TC_Num}   Read Cell Data   ${sSheetName}  0  ${iRowNo}
          # In case test case no is same, fetch the data from same row and given column no
          ${sSearchedData}    Run Keyword If    "${sTestCaseNo}"=="${TC_Num}"     ExcelRobot.Read Cell Data   ${sSheetName}  ${colNum}  ${iRowNo}
          RUN Keyword If    "${sTestCaseNo}"=="${TC_Num}"     Exit For Loop
    END
    [Return]   ${sSearchedData}

# API Keywords

Setup REST Parameters
    []
    ${apiUrl}=  Get Data from Excel with given column  ${serviceName}  ${testName}   uri
    Set Global Variable   ${url}
    ${expected}=   Get Data from Excel with given column  ${serviceName}  ${testName}   uri
    Set Global Variable   ${expected}
    ${uri}=   Get Data from Excel with given column   ${serviceName}  ${testName}   uri
    Set Global Variable   ${uri}    
    ${auth}=   Get Data from Excel with given column   ${serviceName}  ${testName}   uri
    Set Global Variable   ${auth}    

Get REST API response
    [Documentation]  Get REST API response
    Set Headers  {"authorization": "${auth}"}
    Set userid   {"userid": "${empId}"}
    Get   ${apiUrl}/api/v1/user-preferences/employees/${EmpId}
    Integer   response status  200
    ${responseBody}=   Output  response  body
    ${tagValue}=   Output  $.tag.tag.tag
    Set Global Variable   ${tagValue}



#  DB Keywords

Connect to DB
    [Documentation]   Connect to mySQL DB
    [Arguments]  ${env}
    Run Keyword If    '${env}'='dev'   Connect Pymssql   server-ip-address-goes-here    userid   password   dbname-goes-here
    Run Keyword If    '${env}'='test'  Connect Pymssql   server-ip-address-goes-here    userid   password   dbname-goes-here

Run Select SQL in mySQL DB
    Connect to DB  ${env}
    ${sqlResults} =   Run Pymssql Query   Select *  FROM DB-NAME  WHERE .......


