@REM E: && cd E:\$_Codes\SkelProject\db\Approver
@SET MYSQL=c:\xampp\mysql\bin\mysql --local_infile=1 -u root -p1 -h 192.168.100.105
@SET MYSQL=mysql --local_infile=1 -u root -p5475 -P3307
@SET MYSQL=mysql --local_infile=1 -u root -p1 -h 192.168.100.105
@SET MYSQL=mysql --local_infile=1 -u root -p1
@SET DBNAM=ApproverDB

@ECHO Dropping DB %DBNAM%
@%MYSQL% -e "DROP DATABASE IF EXISTS %DBNAM%;"
@REM @IF errorlevel != 0 GOTO :END
@ECHO Creating DB %DBNAM%
@%MYSQL% -e "CREATE DATABASE %DBNAM%;"
@REM @IF errorlevel != 0 GOTO :END
@REM GOTO :END

@ECHO 01 Creating Tables...
@%MYSQL% %DBNAM% < 01-CreateTable-MYS.sql

@ECHO 02 Inserting data...
@%MYSQL% %DBNAM% < 02-InsertData01-MYS.sql
@ECHO 03 Creating Functions...
@%MYSQL% %DBNAM% < 03-functions-MYS.sql

:END

@REM mysql --local_infile=1 -u root -p1 -h 192.168.100.105 ApproverDB
@REM mysql --local_infile=1 -u root -p1 -h 192.168.100.105 ApproverDB < 01-CreateTable-MYS.sql
@REM mysql --local_infile=1 -u root -p1 -h 192.168.100.105 ApproverDB < 02-InsertData01-MYS.sql
@REM mysql --local_infile=1 -u root -p1 -h 192.168.100.105 ApproverDB < 03-functions-MYS.sql