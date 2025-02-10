@SET DBNAM=cdms
@SET DBADMCMD=sqlplus %DBNAM%/%DBNAM%
@SET DBADMCMD=sqlplus %DBNAM%/%DBNAM%@192.168.100.105:1521/orcl.corp.abscbn.com

@REM sqlplus cdms/cdms@192.168.100.105:1521/orcl.corp.abscbn.com @01-CreateTable-ORA-CDMS.sql
@REM sqlplus cdms/cdms@192.168.100.105:1521/orcl.corp.abscbn.com @02-InsertData01-ORA-CDMS.sql
@REM sqlplus cdms/cdms@192.168.100.105:1521/orcl.corp.abscbn.com @03-functions-ORA-CDMS.sql

@ECHO 01 Creating Tables...
@%DBADMCMD% @01-CreateTable-ORA-CDMS.sql

@ECHO 02 Inserting data...
@%DBADMCMD% @02-InsertData01-ORA-CDMS.sql

@ECHO 03 Creating Functions...
@%DBADMCMD% @03-functions-ORA-CDMS.sql
