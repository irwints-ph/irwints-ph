/* mysql version 1.1 */

\! echo Starting Script...

/* Workflow Type Table */\! echo Workflow Type Table 01-apps_wf_rultb
create table apps_wf_rultb (           
      RLNAM      varchar(2)            /* WFType */
     ,RLDSC      varchar(20)           /* Description */
);
alter table apps_wf_rultb add constraint pk_apps_wf_rultb primary key (RLNAM);

/* Rules Table */\! echo Rules Table 02-apps_wf_elmtb
create table apps_wf_elmtb (
      ETYPE      varchar(2)            /* ElementType */
     ,RLNAM      varchar(2)            /* WFType */
     ,ELMNT      varchar(32)           /* FieldDef */
     ,DSCRP      varchar(32)           /* FieldDefDesc */
     ,DLTYP      varchar(1)            /* DataType */
     ,ANZST      numeric (3)           /* Size */
     ,REFTB      varchar(14)           /* TableName */
     ,REFLD      varchar(20)           /* TableField */
);

alter table apps_wf_elmtb add constraint pk_apps_wf_elmtb primary key (ETYPE, RLNAM, ELMNT);
alter table apps_wf_elmtb add constraint fk_apps_wf_elmtb01 foreign key (RLNAM) references apps_wf_rultb (RLNAM);

/* Responsibility Table */\! echo Responsibility Table 03-apps_wf_pfact
create table apps_wf_pfact (           
      RSPNM      varchar(8)            /* Responsibility Code */
     ,ELMNT      varchar(32)           /* Element */
     ,UNDEX      numeric(3)            /* Index */
     ,EXPLW      varchar(40)           /* Low  Value */
     ,EXPHG      varchar(40)           /* High Value */
     ,RLNAM      varchar(2)            /* Workflow Type */
);

alter table apps_wf_pfact add constraint pk_apps_wf_pfact primary key (RSPNM, ELMNT, UNDEX, RLNAM);
alter table apps_wf_pfact add constraint fk_apps_wf_pfact01 foreign key (RLNAM) references apps_wf_rultb (RLNAM);
/* alter table apps_wf_pfact add constraint fk_apps_wf_pfact02 foreign key (ELMNT) references apps_wf_elmtb (ELMNT); */

/* Rule Grouping Table */\! echo Rule Grouping Table 04-apps_wf_cl24n
create table apps_wf_cl24n ( 
      OBJEK      varchar(10)           /* Rule Code Group */
     ,ELMNT      varchar(32)           /* Element */
     ,ATZHL      numeric(3)            /* Index */
     ,ATWRT      varchar(32)           /* Characteristic Value */
     ,ATFLV      numeric (16,2)        /* Numeric Low */
     ,ATFLB      numeric (16,2)        /* Numeric High */
     ,RLNAM      varchar(2)            /* Workflow Type */
);
alter table apps_wf_cl24n add constraint pk_apps_wf_cl24n primary key (OBJEK, ELMNT, ATZHL);
alter table apps_wf_cl24n add constraint fk_apps_wf_cl24n01 foreign key (RLNAM) references apps_wf_rultb (RLNAM);
/* alter table apps_wf_cl24n add constraint fk_apps_wf_cl24n02 foreign key (ELMNT) references apps_wf_elmtb (ELMNT); */


/* Resposibility Master Table */\! echo Resposibility Master Table 05-apps_wf_rsptb
create table apps_wf_rsptb ( 
      RSPNM      varchar(8)            /* Responsibility Code */
     ,RSPDC      varchar(50)           /* Responsibility Desciption */
     ,RLNAM      varchar(2)            /* WFType */
     ,RSPST      varchar(12)           /* Object Abbreviation */
     ,PRITY      numeric(2)            /* Priority */
);

alter table apps_wf_rsptb add constraint pk_apps_wf_rsptb primary key (RSPNM, RLNAM);
alter table apps_wf_rsptb add constraint fk_apps_wf_rsptb01 foreign key (RLNAM) references apps_wf_rultb (RLNAM);

/* Release Group Master Table */\! echo Release Group Master Table 06-apps_wf_rgptb
create table apps_wf_rgptb ( 
      FRGGR      varchar(2)          /* Release group */
     ,FRGGT      varchar(32)          /* Release Desciption */
);

alter table apps_wf_rgptb add constraint pk_apps_wf_rgptb primary key (FRGGR);

/* Release Strategy Master Table */\! echo Release Strategy Master Table 07-apps_wf_t16fc
create table apps_wf_t16fc ( 
      FRGGR      varchar(2)            /* Release group */
     ,FRGSX      varchar(2)            /* Release Strategy */
     ,DSCRP      varchar(20)           /* Release Strategy Desciption */
     ,RLNAM      varchar(2)            /* WFType */
);

alter table apps_wf_t16fc add constraint pk_apps_wf_t16fc primary key (FRGGR,FRGSX,RLNAM);
alter table apps_wf_t16fc add constraint fk_apps_wf_t16fc01 foreign key (RLNAM) references apps_wf_rultb (RLNAM);

/* Release Strategy Table */\! echo Release Strategy Table 08-apps_wf_t16fs
create table apps_wf_t16fs ( 
      FRGGR      varchar(2)            /* Release group */
     ,FRGSX      varchar(2)            /* Release Strategy */
     ,APR01      varchar(2)            /* Release Code Approver for 1 */
     ,APR02      varchar(2)            /* Release Code Approver for 2 */
     ,APR03      varchar(2)            /* Release Code Approver for 3 */
     ,APR04      varchar(2)            /* Release Code Approver for 4 */
     ,APR05      varchar(2)            /* Release Code Approver for 5 */
     ,APR06      varchar(2)            /* Release Code Approver for 6 */
     ,APR07      varchar(2)            /* Release Code Approver for 7 */
     ,APR08      varchar(2)            /* Release Code Approver for 9 */
     ,APR09      varchar(2)            /* Release Code Approver for 9 */
     ,APR10      varchar(2)            /* Release Code Approver for 10 */
);

alter table apps_wf_t16fs add constraint pk_apps_wf_t16fs primary key (FRGGR,FRGSX);

/* Position Master */\! echo Position Master 09-apps_wf_omt00
create table apps_wf_omt00 ( 
      OMNAM      varchar(8)            /* Position Code */
     ,STEXT      varchar(50)           /* Positiom Text */
     ,ORGCD      varchar(8)            /* Organization Code */
);

alter table apps_wf_omt00 add constraint pk_apps_wf_omt00 primary key (OMNAM);

/* Responsibility Table */\! echo Responsibility Table 10-apps_wf_omrsp
create table apps_wf_omrsp ( 
      RLNAM      varchar(2)            /* WFType */
     ,OMNAM      varchar(8)            /* Position Code */
     ,RSPNM      varchar(8)            /* Responsibility Code */
);

alter table apps_wf_omrsp add constraint pk_apps_wf_omrsp primary key (RLNAM, OMNAM, RSPNM);
alter table apps_wf_omrsp add constraint fk_apps_wf_omrsp01 foreign key (RLNAM) references apps_wf_rultb (RLNAM);
alter table apps_wf_omrsp add constraint fk_apps_wf_omrsp02 foreign key (OMNAM) references apps_wf_omt00 (OMNAM);
alter table apps_wf_omrsp add constraint fk_apps_wf_omrsp03 foreign key (RSPNM) references apps_wf_rsptb (RSPNM);

/* Release Strategy Master */\! echo Release Strategy Master 11-apps_wf_t16fd
create table apps_wf_t16fd ( 
      FRGGR      varchar(2)            /* Release group */
     ,FRGCO      varchar(2)            /* Release code */
     ,FRGCT      varchar(20)           /* Description of release code */
);

alter table apps_wf_t16fd add constraint pk_apps_wf_t16fd primary key (FRGGR, FRGCO);

/* Personel Master */\! echo Personel Master 12-apps_wf_xeusr
create table apps_wf_xeusr ( 
      USRID      varchar(5)            /* User ID */
     ,UNAME      varchar(14)           /* User Name */
     ,EMAIL      varchar(150)          /* Email Address */
     ,FNAME      varchar(100)          /* First Name */
     ,LNAME      varchar(100)          /* Lastname */
);

alter table apps_wf_xeusr add constraint pk_apps_wf_xeusr primary key (USRID);

/* Position Personel Master */\! echo Position Personel Master 13-apps_wf_omt01
create table apps_wf_omt01 ( 
      OMNAM      varchar(8)            /* Position Code */
     ,UNAME      varchar(14)           /* User Name */
     ,BEGDA      varchar(10)           /* Start Date */
     ,ENDDA      varchar(10)           /* End Date */
);

alter table apps_wf_omt01 add constraint pk_apps_wf_omt01 primary key (OMNAM, UNAME);
/* alter table apps_wf_omt01 add constraint fk_apps_wf_omt0101 foreign key (UNAME) references apps_wf_xeusr (UNAME); */

