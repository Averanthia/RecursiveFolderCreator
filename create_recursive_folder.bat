@echo off
title Customizable Increment Recursively folder creator
setlocal enableDelayedExpansion
Rem This program is a customizable Increment Recursively folder creator.
Rem You can choose the folder name.
Rem Either between a range or from 0 to a limit

Rem Function to Ask the user the folder path
:SetFolderPath
set /p FolderPath="What is the folder path ? "
echo:
goto :folderPathChecked

Rem Check if FolderPath is not given empty otherwise call again the prompt
:folderPathChecked
IF NOT [%FolderPath%]==[] (
    echo "Folder path was set to : %FolderPath%"
    echo:
    CALL :FolderNaming
) ELSE (
    echo "A correct answer was not defined for the folder name, please try again."
    echo:
    CALL :SetFolderPath
)

Rem Function to Ask the user to make a folder name
:FolderNaming
set /p FolderName="What is the folder name you want to Recursively create ? "
echo:
goto :folderNamingChecked

Rem Check if FolderName is not given empty otherwise call again the prompt
:folderNamingChecked
IF NOT [%FolderName%]==[] (
    echo "Folder name was set to : %FolderName%"
    echo:
    CALL :FolderRangeOption
) ELSE (
    echo "A correct answer was not defined for the folder name, please try again."
    echo:
    CALL :FolderNaming
)

Rem Function to Ask the user if the creation of folder is between a range
:FolderRangeOption
set /p RangeOption="Does the Increment is between a range ? (y or n) "
echo:
goto :checkFolderRangeOption

Rem Check if FolderIncrementRangeOption is not given empty otherwise call again the prompt
:checkFolderRangeOption
IF NOT [%RangeOption%]==[] (
    echo "Folder range option was set to : %RangeOption%"
    echo:
    goto :folderRangeOptionChecked
) ELSE (
    echo "A correct answer was not defined for the range option, please try again."
    echo:
    CALL :FolderRangeOption
)

:folderRangeOptionChecked
IF /i "%RangeOption%"=="y" (
    CALL :CreateFolderWithRange
) ELSE (
    IF /i "%RangeOption%"=="n" (
        CALL :CreateFolderWithDefinedIncrement
    ) ELSE (
        echo "A correct answer was not defined for the range option, please try again."
        echo:
        CALL :FolderRangeOption
    )
)


Rem Function to Ask the user the range minimum and maximum number
:CreateFolderWithRange
set /p minimumRangeOption="Please input the minimum range : "
set /A minimumRangeOption=%minimumRangeOption%
echo:
set /p maximumRangeOption="Please input the maximum range : "
set /A maximumRangeOption=%maximumRangeOption%
echo:

IF (%minimumRangeOption% GTR 0 AND %maximumRangeOption% GTR 0) (
    goto :creatingFolderWithRange
)

Rem Function to create the folder using the range minimum and maximum number
:creatingFolderWithRange
set loopRangeIncrementCount=%minimumRangeOption%

REM dummy var to reach the maximumRangeOption prompted
set /a tmpMaxRange=%maximumRangeOption%+1

REM Loop to create folder from minimum range to maximum range prompted by user
:loopRangeIncrement
IF %loopRangeIncrementCount%==%tmpMaxRange% (
    echo:
    echo "Recursive Ranged Folder got Created"
    echo:
    goto :cleanExit
) ELSE (
    set "NUM=00%loopRangeIncrementCount%"
    set "%FolderPath%=%FolderName%.!NUM:~-3!"
    md !%FolderPath%!
    set /a loopRangeIncrementCount=%loopRangeIncrementCount%+1
    timeout /t 0
    GOTO :loopRangeIncrement
)


Rem Function to Ask the user the maximum increment possible
:CreateFolderWithDefinedIncrement
set /p maximumFolderIncrement="Please input the number of folder you will want to create : "
set /A maximumFolderIncrement=%maximumFolderIncrement%
echo:

IF %maximumFolderIncrement% GTR 0 (
    goto :creatingFolderWithDefinedIncrement
)

Rem Function to create the folder using the maximum increment possible
:creatingFolderWithDefinedIncrement
set loopDefinedIncrementCount=1

REM dummy var to reach the maximumFolderIncrement prompted
set /a tmpMaxIncrement=%maximumFolderIncrement%+1

REM Loop to create folder from pre-defined minimum 1 to max prompted by user
:loopDefinedIncrement
IF %loopDefinedIncrementCount%==%tmpMaxIncrement% (
    echo:
    echo "Recursive Incremented Folder got Created"
    echo:
    goto :cleanExit
) ELSE (
    set "NUM=00%loopDefinedIncrementCount%"
    set "%FolderPath%=%FolderName%.!NUM:~-3!"
    md !%FolderPath%!
    set /a loopDefinedIncrementCount=%loopDefinedIncrementCount%+1
    timeout /t 0
    GOTO :loopDefinedIncrement
)

:cleanExit
set /p cleanExitOption="Do you want to continue ? (y or n) "
echo:
goto :checkCleanExitOption

Rem Check if cleanExitOption is not given empty otherwise call again the prompt
:checkCleanExitOption
IF NOT [%cleanExitOption%]==[] (
    goto :cleanExitOptionChecked
) ELSE (
    echo "A correct answer was not defined for the clean exit, please try again."
    echo:
    CALL :cleanExit
)

:cleanExitOptionChecked
IF /i "%cleanExitOption%"=="y" (
    CALL :FolderNaming
) ELSE (
    IF /i "%cleanExitOption%"=="n" (
        CALL :CleanExitSucceeded
    ) ELSE (
        echo "A correct answer was not defined for the clean exit, please try again."
        echo:
        CALL :cleanExit
    )
)

:cleanExitSucceeded
EXIT 0
