@REM E: && cd E:\$_Codes\SkelProject\db\Approver
@SET DBACONNECT=sys/newPass@192.168.100.105:1521/orcl.corp.abscbn.com as sysdba
@SET DBNAM=approverDB
@SET DBADMCMD=sqlplus %DBNAM%/%DB%@192.168.100.105:1521/orcl.corp.abscbn.com

@ECHO Dropping DB %DBNAM%
@ECHO DROP USER %DBNAM% CASCADE; > cf.sql
@ECHO exit; >> cf.sql
@sqlplus %DBACONNECT% @cf.sql

@ECHO Creating DB %DBNAM%
@ECHO create user %DBNAM% identified by %DBNAM%; > cf.sql
@ECHO grant connect to %DBNAM%; >> cf.sql
@ECHO grant all privileges to %DBNAM%; >> cf.sql
@ECHO exit; >> cf.sql
@sqlplus %DBACONNECT% @cf.sql


@ECHO 01 Creating Tables...
@%DBADMCMD% @01-CreateTable-ORA.sql

@ECHO 02 Inserting data...
@%DBADMCMD% @02-InsertData01-ORA.sql

@ECHO 03 Creating Functions...
@%DBADMCMD% @03-functions-ORA.sql

:END

@REM sqlplus approverDB/approverDB@192.168.100.105:1521/orcl.corp.abscbn.com @01-CreateTable-ORA.sql
@REM sqlplus approverDB/approverDB@192.168.100.105:1521/orcl.corp.abscbn.com @02-InsertData01-ORA.sql
@REM sqlplus approverDB/approverDB@192.168.100.105:1521/orcl.corp.abscbn.com @03-functions-ORA.sql