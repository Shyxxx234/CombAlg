@echo off
echo ==============================
echo Traveling Salesman Tests with Expected Results
echo ==============================

echo Compiling program...
g++ -std=c++11 -o salesman.exe ../lab1_Salesman.cpp

if errorlevel 1 (
    echo Compilation error!
    pause
    exit /b 1
)

set TEST_COUNT=0
set FAIL_COUNT=0

echo.
echo ==============================
echo TEST 1: 3 cities
echo ================
echo Expected: 
echo - Minimal distance: 45
echo - Path: 0 1 2
echo.
(
echo 3
echo 0 10 15
echo 10 0 20
echo 15 20 0
) > input.txt
salesman.exe
del input.txt
set /a TEST_COUNT+=1

echo.
echo ==============================
echo TEST 2: 10 cities from assignment
echo ==============================
echo Expected from brute force:
echo - Minimal distance: 160
echo - Path: 0 5 8 4 1 2 9 6 3 7
echo.
(
echo 10
echo 61 18 31 51 80 13 85 76 59 65
echo 85 18 25 13 74 36 88 21 65 51
echo 5 86 31 96 64 79 44 41 28 7
echo 15 37 85 88 93 76 81 23 54 88
echo 2 2 91 34 31 63 49 60 13 3
echo 75 87 92 18 92 32 53 28 3 51
echo 3 85 75 8 56 7 65 47 25 68
echo 9 60 55 28 15 60 72 46 43 84
echo 67 79 80 95 25 83 90 97 31 45
echo 66 50 22 68 39 44 45 35 55 58
) > input.txt
salesman.exe
del input.txt
set /a TEST_COUNT+=1

echo.
echo ==============================
echo TEST 3: 4 cities
echo ==============================
echo Expected:
echo - Minimal distance: 14
echo - Path: 0 1 2 3
echo.
(
echo 4
echo 0 1 2 3
echo 1 0 4 5
echo 2 4 0 6
echo 3 5 6 0
) > input.txt
salesman.exe
del input.txt
set /a TEST_COUNT+=1

echo.
echo ==============================
echo TEST 4: 5 cities
echo ==============================
echo Expected: 
echo - Minimal distance: 28
echo - Path: 0 1 2 3 4
echo.
(
echo 5
echo 0 2 9 10 7
echo 2 0 6 4 8
echo 9 6 0 8 10
echo 10 4 8 0 5
echo 7 8 10 5 0
) > input.txt
salesman.exe
del input.txt
set /a TEST_COUNT+=1

echo.
echo ==============================
echo TEST 5: Error test - 1 city
echo ==============================
echo Expected: 
echo - Error message: "Enter a number greater than 2"
echo - Program should terminate with non-zero exit code
echo.
(
echo 1
echo 0
) > input.txt
salesman.exe 2>error.log
if errorlevel 1 (
    echo PASS: Program correctly terminated with error
    type error.log
) else (
    echo FAIL: Program should have failed for 1 city
    set /a FAIL_COUNT+=1
)
del input.txt error.log 2>nul
set /a TEST_COUNT+=1

echo.
echo ==============================
echo TEST 6: Error test - insufficient data
echo ==============================
echo Expected:
echo - Error message: "Insufficient number of arguments"
echo - Program should terminate with error
echo.
(
echo 3
echo 0 1
echo 2 0
) > input.txt
salesman.exe 2>error.log
if errorlevel 1 (
    echo PASS: Program handled insufficient data correctly
    type error.log
) else (
    echo FAIL: Should have detected insufficient data
    set /a FAIL_COUNT+=1
)
del input.txt error.log 2>nul
set /a TEST_COUNT+=1

echo.
echo ==============================
echo TEST 7: Small test
echo ==============================
echo Expected:
echo - Minimal distance: 55
echo - Path: 0 1 3 2
echo.
(
echo 4
echo 0 10 25 30
echo 10 0 20 5
echo 25 20 0 15
echo 30 5 15 0
) > input.txt
salesman.exe
del input.txt
set /a TEST_COUNT+=1

echo.
echo ==============================
echo TEST SUMMARY
echo ==============================
echo Total tests run: %TEST_COUNT%
echo Tests failed: %FAIL_COUNT%

del salesman.exe
pause