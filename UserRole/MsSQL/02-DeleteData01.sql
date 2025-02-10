delete from APPS_USER_ROLE_REF;
delete from APPS_ROLE_MODULE_REF;
delete from APPS_MODULE_REF;
delete from APPS_ROLE_REF;

delete from APPS_PERSONNEL_MSTR;
delete from APPS_USER_MAPPER;
delete from APPS_USER_REF;

Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -Q "delete from APPS_USER_ROLE_REF;"
Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -Q "delete from APPS_ROLE_MODULE_REF;"

Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -Q "delete from APPS_MODULE_REF;"
Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -Q "delete from APPS_ROLE_REF;"
Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -Q ""
Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -Q ""
Sqlcmd -U sa -P !qazxsW23edc -S 192.168.100.105 -d ApproverDB -Q ""