@echo off

echo STEP 1 Import all files into SQL Server and clean ...
sqlcmd -S LAPTOP-2K6MH8QU\SQLEXPRESS -d Health_Insurance -E -i "C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation\Data Cleaning.sql"  

echo -----------------------------------

echo STEP 3 Git push changes to GitHub...
cd "C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation"
git init
git branch -M main
git remote add origin https://github.com/JijinaGopal/Health_Insurance_Automation
git add .
git commit -m "Auto update after SQL cleaning - %DATE% %TIME%"
git push origin main

echo -----------------------------------

echo DONE. Streamlit Cloud will reflect the changes shortly.
pause