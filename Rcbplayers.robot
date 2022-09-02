*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary
Library     OperatingSystem
Library     Collections
Library     String
Library     JSONLibrary


*** Test Cases ***
Test to validate that the team has only 4 foreign players

   #${json}=    Load json from file      TestData/rcbdata.json
   ${file}=    get file    TestData/rcbdata.json
   log to console      ${file}
   ${json_data}=   convert string to json      ${file}
   ${country}=   get value from json  ${json_data}    $..country
   ${total_players}=  get length        ${country}
   log to console  there are ${total_players} players in team
   ${size}=   get match count   ${country}  India
   log to console  there are ${size} Indian players in the team
   ${foreign_players}=    evaluate         ${total_players}-${size}
   RUN Keyword If  ${foreign_players}== 4  Test Keyword 1  ELSE IF  ${foreign_players} < 4  Test Keyword 2  ELSE  Test Keyword 3

Test to validate there is atleast one wicket keeper
   ${input_data}=   get file    TestData/rcbdata.json
   ${json}=   convert string to json      ${input_data}
   ${roles}=   get value from json      ${json}    $..role
   ${wicket_keeper}=   get match count   ${roles}  Wicket-keeper

   RUN Keyword If  ${wicket_keeper}== 1  Test Keyword 4  ELSE IF  ${wicket_keeper} < 1  Test Keyword 5  ELSE  Test Keyword 6

*** Keywords ***
Test Keyword 1
    Log To Console  Found 4 foreign players as expected
Test Keyword 2
    Log To Console  Found less foreign players than expected
Test Keyword 3
    Log To Console  Found more foreign players than expected
Test Keyword 4
    Log To Console  Found one wicket keeper as expected
Test Keyword 5
    Log To Console  No wicket keeper found
Test Keyword 6
    Log To Console  Found more Wicket keepers  than expected


