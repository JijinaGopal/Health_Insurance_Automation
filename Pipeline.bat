@echo off

echo STEP 1 Import all files into SQL Server and clean ...
sqlcmd -S LAPTOP-2K6MH8QU\SQLEXPRESS -d Health_Insurance -E -i "C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation\Data Cleaning.sql"  

echo -----------------------------------

echo STEP 2: Rewrite the file with cleaned data 
"C:\Users\Administrator\AppData\Local\Programs\Python\Python39\python.exe" "C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation\cleaned_data_exporting.py"


echo -----------------------------------

echo STEP 3 Git push changes to GitHub...
cd "C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation"
git init
git remote add origin https://github.com/JijinaGopal/Health_Insurance_Automation
git add .
git commit -m "Auto update after SQL cleaning - %DATE% %TIME%"
git push origin main

echo -----------------------------------

@echo off
echo STEP 4: Convert notebook to script
"C:\Users\Administrator\AppData\Local\Programs\Python\Python39\Scripts\jupyter.exe" nbconvert --to script "C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation\Status_prediction.ipynb"

echo -----------------------------------


echo STEP 5: Run the ML model and export the metrics
"C:\Users\Administrator\AppData\Local\Programs\Python\Python39\python.exe" "C:\Users\Administrator\Desktop\Internship\Insurance_Operations\Health Insurance Claims\Automation\Status_prediction.py"


echo DONE.
pause