@REM E: && cd E:\$_Codes\SkelProject\db\Approver
@SET MYSQL=c:\xampp\mysql\bin\mysql --local_infile=1 -u root -p1 -h 192.168.100.105
@SET MYSQL=mysql --local_infile=1 -u root -p5475 -P3307
@SET MYSQL=Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105
@SET DBNAM=ApproverDB

@ECHO Dropping DB %DBNAM%
@%MYSQL% -Q "DROP DATABASE IF EXISTS %DBNAM%;"

@ECHO Creating DB %DBNAM%
@%MYSQL% -Q "CREATE DATABASE %DBNAM%;"



@ECHO 01 Creating Tables...
@%MYSQL% -d %DBNAM% -i 01-CreateTable-MSS.sql
@ECHO 02 Inserting data...
@%MYSQL% -d %DBNAM% -i 02-InsertData01-MSS.sql

@REM @GOTO :END

@ECHO 03 Creating Functions...
@%MYSQL% -d %DBNAM% -i 03-functions-MSS.sql

:END

@REM Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -i 02-InsertData01-MSS.sql
@REM Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -i 03-functions-MSS.sql