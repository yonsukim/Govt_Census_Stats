libname library ' C:\Users\yonsuk\Documents\Dissertation\Exp\format'; /*location of formats*/
libname Exp ' C:\Users\yonsuk\Documents\Dissertation\Exp\working'; /*location of working data*/
libname output ' C:\Users\yonsuk\Documents\Dissertation\Exp\output'; /*location of output*/ 

Proc import out = Exp.exp_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\IndFin12_Exp.xlsx"
DBMS = xlsx replace;
Sheet = "IndFin12";
Getnames =yes;
Run;



data exp_12_01 (keep=Year4 ID IDChanged State_Code County Type_code name census_region FIPS_Code_State Population Total_Expenditure Total_IG_Expenditure Direct_Expenditure Total_Current_Expend 
Air_Trans_Total_Expend Misc_Com_Activ_Tot_Exp Correct_Total_Exp Total_Educ_Total_Exp Elem_Educ_Total_Exp Higher_Ed_Total_Exp Educ_NEC_Total_Expend 
Emp_Sec_Adm_Direct_Exp Fin_Admin_Total_Exp Fire_Prot_Total_Expend Judicial_Total_Expend Cen_Staff_Total_Expend Gen_Pub_Bldg_Total_Exp 
Health_Total_Expend Total_Hospital_Total_Exp Own_Hospital_Total_Exp Hosp_Other_Total_Exp 
Total_Highways_Tot_Exp Regular_Hwy_Total_Exp Toll_Hwy_Total_Expend Transit_Sub_Total_Exp Hous___Com_Total_Exp Libraries_Total_Expend 
Natural_Res_Total_Exp Parking_Total_Expend Parks___Rec_Total_Exp Police_Prot_Total_Exp Prot_Insp_Total_Exp 
Public_Welf_Total_Exp Welf_Categ_Total_Exp Welf_NEC_Total_Expend 
Sewerage_Total_Expend SW_Mgmt_Total_Expend Water_Trans_Total_Exp General_NEC_Total_Exp 
Liquor_Stores_Tot_Exp Total_Util_Total_Exp Water_Util_Total_Exp Elec_Util_Total_Exp Gas_Util_Total_Exp Trans_Util_Total_Exp
Emp_Ret_Total_Expend Unemp_Comp_Total_Exp); 
set exp.exp_12; run;

Proc import out = Exp.cross_gov_FIPS datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\crosswalk_GovID_FIPS.xlsx"
DBMS = xlsx replace;
Sheet = "GOV_FIPS";
Getnames =yes;
Run;

/** create GOVIDN **/
data exp_12_01; set exp_12_01; rename state_code=st; rename county=ct; run;
data exp_12_01; set exp_12_01; govidn=(st*1000)+ct; run;


proc sql;
create table expsum_01 as 
select govidn, sum(total_expenditure), sum(total_ig_expenditure), sum(Direct_Expenditure), sum(Total_Current_Expend), 
sum(Air_Trans_Total_Expend), sum(Misc_Com_Activ_Tot_Exp), sum(Correct_Total_Exp), sum(Total_Educ_Total_Exp), sum(Elem_Educ_Total_Exp), sum(Higher_Ed_Total_Exp), sum(Educ_NEC_Total_Expend), 
sum(Emp_Sec_Adm_Direct_Exp), sum(Fin_Admin_Total_Exp), sum(Fire_Prot_Total_Expend), sum(Judicial_Total_Expend), sum(Cen_Staff_Total_Expend), sum(Gen_Pub_Bldg_Total_Exp), 
sum(Health_Total_Expend), sum(Total_Hospital_Total_Exp), sum(Own_Hospital_Total_Exp), sum(Hosp_Other_Total_Exp), 
sum(Total_Highways_Tot_Exp), sum(Regular_Hwy_Total_Exp), sum(Toll_Hwy_Total_Expend), sum(Transit_Sub_Total_Exp), sum(Hous___Com_Total_Exp), sum(Libraries_Total_Expend), 
sum(Natural_Res_Total_Exp), sum(Parking_Total_Expend), sum(Parks___Rec_Total_Exp), sum(Police_Prot_Total_Exp), sum(Prot_Insp_Total_Exp), 
sum(Public_Welf_Total_Exp), sum(Welf_Categ_Total_Exp), sum(Welf_NEC_Total_Expend), 
sum(Sewerage_Total_Expend), sum(SW_Mgmt_Total_Expend), sum(Water_Trans_Total_Exp), sum(General_NEC_Total_Exp), 
sum(Liquor_Stores_Tot_Exp), sum(Total_Util_Total_Exp), sum(Water_Util_Total_Exp), sum(Elec_Util_Total_Exp), sum(Gas_Util_Total_Exp), sum(Trans_Util_Total_Exp), 
sum(Emp_Ret_Total_Expend), sum(Unemp_Comp_Total_Exp)
from exp_12_01
group by govidn
order by govidn;
quit; 

data Expsum_12; set Expsum_01; 
rename _TEMG001=Stotal_expenditure; 
rename _TEMG002=Stotal_ig_expenditure;
rename _TEMG003=SDirect_Expenditure; 
rename _TEMG004=STotal_Current_Expend;
rename _TEMG005=SAir_Trans_Total_Expend;
rename _TEMG006=SMisc_Com_Activ_Tot_Exp;
rename _TEMG007=SCorrect_Total_Exp;
rename _TEMG008=STotal_Educ_Total_Exp;
rename _TEMG009=SElem_Educ_Total_Exp;
rename _TEMG010=SHigher_Ed_Total_Exp;
rename _TEMG011=SEduc_NEC_Total_Expend;
rename _TEMG012=SEmp_Sec_Adm_Direct_Exp;
rename _TEMG013=SFin_Admin_Total_Exp;
rename _TEMG014=SFire_Prot_Total_Expend;
rename _TEMG015=SJudicial_Total_Expend;
rename _TEMG016=SCen_Staff_Total_Expend;
rename _TEMG017=SGen_Pub_Bldg_Total_Exp;
rename _TEMG018=SHealth_Total_Expend;
rename _TEMG019=STotal_Hospital_Total_Exp;
rename _TEMG020=SOwn_Hospital_Total_Exp;
rename _TEMG021=SHosp_Other_Total_Exp;
rename _TEMG022=STotal_Highways_Tot_Exp;
rename _TEMG023=SRegular_Hwy_Total_Exp;
rename _TEMG024=SToll_Hwy_Total_Expend;
rename _TEMG025=STransit_Sub_Total_Exp;
rename _TEMG026=SHous___Com_Total_Exp;
rename _TEMG027=SLibraries_Total_Expend;
rename _TEMG028=SNatural_Res_Total_Exp;
rename _TEMG029=SParking_Total_Expend;
rename _TEMG030=SParks___Rec_Total_Exp;
rename _TEMG031=SPolice_Prot_Total_Exp;
rename _TEMG032=SProt_Insp_Total_Exp;
rename _TEMG033=SPublic_Welf_Total_Exp;
rename _TEMG034=SWelf_Categ_Total_Exp;
rename _TEMG035=SWelf_NEC_Total_Expend;
rename _TEMG036=SSewerage_Total_Expend;
rename _TEMG037=SSW_Mgmt_Total_Expend;
rename _TEMG038=SWater_Trans_Total_Exp;
rename _TEMG039=SGeneral_NEC_Total_Exp;
rename _TEMG040=SLiquor_Stores_Tot_Exp;
rename _TEMG041=STotal_Util_Total_Exp;
rename _TEMG042=SWater_Util_Total_Exp;
rename _TEMG043=SElec_Util_Total_Exp;
rename _TEMG044=SGas_Util_Total_Exp;
rename _TEMG045=STrans_Util_Total_Exp;
rename _TEMG046=SEmp_Ret_Total_Expend;
rename _TEMG047=SUnemp_Comp_Total_Exp; run;



/* CREATE # OF GOVERNMENT (EACH TYPE) */

data type1; set exp_12_01; where type_code=1; run;
data type2; set exp_12_01; where type_code=2; run;
data type3; set exp_12_01; where type_code=3; run;
data type4; set exp_12_01; where type_code=4; run;
data type5; set exp_12_01; where type_code=5; run;


/** type 1 **/
proc sort data=type1; by st ct; run;

proc freq data=type1;
   by st ct govidn;
   tables st ct govidn type_code/out = ngov_11;
run;

proc transpose data=ngov_11 
out=ngov_12
prefix=Count;
var Count;
by st ct govidn;
run;

/** type 2 **/
proc sort data=type2; by st ct; run;

proc freq data=type2;
   by st ct govidn;
   tables st ct govidn type_code/out = ngov_21;
run;

proc transpose data=ngov_21 
out=ngov_22
prefix=Count;
var Count;
by st ct govidn;
run;

/** type 3 **/
proc sort data=type3; by st ct; run;

proc freq data=type3;
   by st ct govidn;
   tables st ct govidn type_code/out = ngov_31;
run;

proc transpose data=ngov_31 
out=ngov_32
prefix=Count;
var Count;
by st ct govidn;
run;

/** type 4 **/
proc sort data=type1; by st ct; run;

proc freq data=type4;
   by st ct govidn;
   tables st ct govidn type_code/out = ngov_41;
run;

proc transpose data=ngov_41 
out=ngov_42
prefix=Count;
var Count;
by st ct govidn;
run;

/** type 5 **/
proc sort data=type5; by st ct; run;

proc freq data=type5;
   by st ct govidn;
   tables st ct govidn type_code/out = ngov_51;
run;

proc transpose data=ngov_51 
out=ngov_52
prefix=Count;
var Count;
by st ct govidn;
run;

/*** Count1 name changed as # gov has variable name "count1" ***/ 
data ngov_22; set ngov_22; rename count1=count2; run;
data ngov_32; set ngov_32; rename count1=count3; run;
data ngov_42; set ngov_42; rename count1=count4; run;
data ngov_52; set ngov_52; rename count1=count5; run;

proc sort data=ngov_12; by govidn; run;
proc sort data=ngov_22; by govidn; run;
proc sort data=ngov_32; by govidn; run;
proc sort data=ngov_42; by govidn; run;
proc sort data=ngov_52; by govidn; run;

data exp.ngov_12; 
merge ngov_12 ngov_22 ngov_32 ngov_42 ngov_52; by govidn; run; /** # gov completed **/

data exp.ngov_12; set exp.ngov_12; 
rename count1=type1; rename count2=type2; rename count3=type3; rename count4=type4; rename count5=type5;
rename st=stc; rename ct=ctc; run; /* As it's merged with cross_gov_FIPS_12 data, ct and st are not compatible because it has numeric st and ct while other has character variables */

 
/* IMPORT GOV-FIPS-CROSSWALK */

Proc import out = Exp.cross_gov_FIPS_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\crosswalk_GovID_FIPS_2012.xlsx"
DBMS = xlsx replace;
Sheet = "sheet1";
Getnames =yes;
Run;


/* MERGE Ngov_12 (# of govt) and CROSS_GOV_FIPS_12 DATA */
data exp.cross_gov_FIPS_12; set exp.cross_gov_FIPS_12; govidn=id*1; run;
 
proc sort data=exp.ngov_12; by govidn; run;
proc sort data=exp.cross_gov_FIPS_12; by govidn; run;

data exp.ngov_12_01; 
merge exp.ngov_12 exp.cross_gov_FIPS_12; by govidn; run;


/* MERGE Ngov_12 (# of gov, gov fips codes) WITH EXP_SUM DATA */
proc sort data= exp.ngov_12_01; by govidn; run;
proc sort data= expsum_12; by govidn; run;

data exp.expsum_20; 
merge exp.ngov_12_01 expsum_12; by govidn; run;


/* POPULATION DATA FROM EXP_12 */

data pop_01; set exp.exp_12; where type_code=1; run;

data pop_02 (keep=Year4 State_Code County Type_code name FIPS_Code_State Population); 
set pop_01; run;


/** create GOVIDN **/
data pop_03; set pop_02; rename state_code=st; rename county=ct; run;
data pop_04; set pop_03; govidn=(st*1000)+ct; run;



/* MERGE POP DATA INTO EXPSUM_20(GOVID+#GOV+EXPSUM) - 100615 */
data exp.pop_05; set pop_04; 
rename st=stc; rename ct=ctc; rename id=idc; run; /* As it's merged, ct and st are not compatible because it has numeric st and ct while other has character variables */


proc sort data=exp.expsum_20; by govidn; run;
proc sort data=exp.pop_05; by govidn; run;

data exp.expsum_30; 
merge exp.expsum_20 exp.pop_05; by govidn; run;



/* POP DENSITY - 100715 */
Proc import out = Exp.density_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\density_12.xlsx"
DBMS = xlsx replace;
Sheet = "sheet1";
Getnames =yes;
Run;

data exp.expsum_30; set exp.expsum_30; /* fips codes converted to numeric as density data inludes only fips codes */
fipsstrn=fipsstr*1000; fipsctyrn=fipsctyr12*1;
fipsn=fipsstrn+fipsctyrn; run;

proc sort data=exp.expsum_30; by fipsn; run;
proc sort data=exp.density_12; by fipsn; run;

data exp.expsum_40; /** merging by fips codes unlike other merging process with govidn as density has only fips codes **/
merge exp.expsum_30 exp.density_12; by fipsn; run;


/* IMPORT INCOME DATA */
Proc import out = Exp.MHI_97 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_1997";
Getnames =yes;
Run;

Proc import out = Exp.MHI_02 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_2002";
Getnames =yes;
Run;

Proc import out = Exp.MHI_07 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_2007";
Getnames =yes;
Run;

Proc import out = Exp.MHI_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_2012";
Getnames =yes;
Run;


/** converts numeric var(st and ct) to character var (fipsstr and fipsctyr) */

data exp.MHI_97; 
set exp.MHI_97;
fipsstr=put(st, best12.);
fipsctyr=put(ct, best12.);
run ; 

data exp.MHI_02; 
set exp.MHI_02;
fipsstr=put(st, best12.);
fipsctyr=put(ct, best12.);
run ; 

data exp.MHI_07; /* fipsstr is already character*/
set exp.MHI_07;
fipsctyr=put(ct, best12.);
run ; 


data mhi_97; set exp.mhi_97; fips=fipsstr*1000+fipsctyr*1;run;
data mhi_02; set exp.mhi_02; fips=fipsstr*1000+fipsctyr*1;run;
data mhi_07; set exp.mhi_07; fips=fipsstr*1000+fipsctyr*1;run;
data mhi_12; set exp.mhi_12; fips=fipsstr*1000+fipsctyr*1;run;
 
proc sort data=MHI_97; by fips; run;
proc sort data=MHI_02; by fips; run;
proc sort data=MHI_07; by fips; run;
proc sort data=MHI_12; by fips; run;

data exp.MHI_9712; 
merge mhi_97 mhi_02 mhi_07 mhi_12;
by fips; 
run;

/* INCOME (1997-2012) COMPLETED */


/* MERGER INCOME(2012) INTO exp_40 */

/** add fips var to cross_gov_fips_12 **/
data exp.cross_gov_fips_12; set exp.cross_gov_fips_12; fips=fipsstr*1000+fipsctyr12*1;run; 
data exp.expsum_40; set exp.expsum_40; fips=fipsstr*1000+fipsctyr12*1;run; 

proc sort data=exp.expsum_40; by fips; run;
proc sort data=mhi_12; by fips; run;
 
data exp.expsum_41; 
merge exp.expsum_40 mhi_12; by fips; run;


/**********************************************************************************************************************************************************************/
/****************************************** 2012 DATA *****************************************************************************************************************/

Proc import out = Exp.exp_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\IndFin12_Exp.xlsx"
DBMS = xlsx replace;
Sheet = "IndFin12a";
Getnames =yes;
Run;

data exp.exp_12_01 
(keep=Year4	ID IDChanged State_Code Type_Code County Census_Region FIPS_Code_State	Population 
Total_Expenditure Total_IG_Expenditure Direct_Expenditure Total_Current_Expend Total_Current_Oper Total_Capital_Outlays	Total_Construction 
General_Expenditure	IG_Exp_To_State_Govt IG_Exp_To_Local_Govts IG_Exp_To_Federal_Govt Direct_General_Expend	
Air_Trans_Total_Expend Air_Trans_Direct_Expend Air_Trans_IG_To_State Air_Trans_IG_Local_Govts 
Misc_Com_Activ_Tot_Exp
Correct_Total_Exp Correct_Direct_Exp Correct_IG_To_St Correct_IG_Loc_Govts 
Total_Educ_Total_Exp Total_Educ_Direct_Exp Elem_Educ_Total_Exp Elem_Educ_Direct_Exp Elem_Educ_IG_To_State Elem_Educ_IG_Local_Govts Elem_Educ_IG_Sch_to_Sch
Higher_Ed_Total_Exp	Higher_Ed_Direct_Exp Higher_Ed_IG_To_St	Higher_Ed_IG_Loc_Govts Educ_NEC_Total_Expend Educ_NEC_Direct_Expend Educ_NEC_IG_To_State var92 /*var91*/
Emp_Sec_Adm_Direct_Exp Fin_Admin_Total_Exp Fin_Admin_Direct_Exp Fin_Admin_IG_To_State Fin_Admin_IG_Local_Govts 
Fire_Prot_Total_Expend Fire_Prot_Direct_Exp Fire_Prot_IG_To_State Fire_Prot_IG_Local_Govts 
Judicial_Total_Expend Judicial_Direct_Expend Judicial_IG_To_State Judicial_IG_Local_Govts 
Cen_Staff_Total_Expend Cen_Staff_Direct_Exp Cen_Staff_IG_To_State Cen_Staff_IG_Local_Govts Gen_Pub_Bldg_Total_Exp
Health_Total_Expend	Health_Direct_Expend Health_IG_To_State	Health_IG_Local_Govts
Total_Hospital_Total_Exp Total_Hospital_Dir_Exp Total_Hospital_IG_To_State Total_Hospital_IG_Loc_Govts  
Own_Hospital_Total_Exp Hosp_Other_Total_Exp Hosp_Other_Direct_Exp Hosp_Other_IG_To_State var143 /*var142*/
Total_Highways_Tot_Exp Total_Highways_Dir_Exp Regular_Hwy_Total_Exp Regular_Hwy_Direct_Exp Regular_Hwy_IG_To_Sta Regular_Hwy_IG_Loc_Govts 
Toll_Hwy_Total_Expend Transit_Sub_Total_Exp Transit_Sub_Direct_Sub Transit_Sub_IG_To_Sta Transit_Sub_IG_Loc_Govts 
Hous___Com_Total_Exp Hous___Com_Direct_Exp Hous___Com_IG_To_State var167 /*var166*/
Libraries_Total_Expend Libraries_Direct_Exp	Libraries_IG_To_State Libraries_IG_Local_Govts
Natural_Res_Total_Exp Natural_Res_Direct_Exp Natural_Res_IG_To_Sta Natural_Res_IG_Loc_Govts 
Parking_Total_Expend Parking_Direct_Expend Parking_IG_To_State Parking_IG_Local_Govts
Parks___Rec_Total_Exp Parks___Rec_Direct_Exp Parks___Rec_IG_To_Sta var191 /*var190*/	
Police_Prot_Total_Exp Police_Prot_Direct_Exp Police_Prot_IG_To_Sta Police_Prot_IG_Loc_Govts 
Prot_Insp_Total_Exp Prot_Insp_Direct_Exp Prot_Insp_IG_To_State Prot_Insp_IG_Local_Govts 
Public_Welf_Total_Exp Public_Welf_Direct_Exp Public_Welf_Cash_Asst 
Welf_Categ_Total_Exp Welf_Categ_Cash_Assist Welf_Categ_IG_To_State var212 /*var211*/
Welf_Cash_Total_Exp Welf_Cash_Cash_Assist var215 /*var214*/ 
Welf_Vend_Pmts_Medical Welf_Vend_Pmts_NEC Welf_State_Share_Part_D Welf_Ins_Total_Exp 
Welf_NEC_Total_Expend Welf_NEC_Direct_Expend Welf_NEC_IG_To_State var227 /*var226*/
Sewerage_Total_Expend Sewerage_Direct_Expend Sewerage_IG_To_State Sewerage_IG_Local_Govts 
SW_Mgmt_Total_Expend SW_Mgmt_Direct_Expend SW_Mgmt_IG_To_State SW_Mgmt_IG_Local_Govts 
Water_Trans_Total_Exp Water_Trans_Direct_Exp Water_Trans_IG_To_Sta Water_Trans_IG_Loc_Govts);	
Set exp.exp_12; run;

/* Create Govid */
data exp.exp_12_01; set exp.exp_12_01; rename state_code=stn; rename county=ctn; run;
data exp.exp_12_01; set exp.exp_12_01; govidn=(stn*1000)+ctn; run;


/*SUM OF SPENDING BY CATEGORY*/
proc sql;
create table expsum_12 as 
select govidn, sum(Total_Expenditure), sum(Total_IG_Expenditure), sum(Direct_Expenditure), sum(Total_Current_Expend), sum(Total_Current_Oper), sum(Total_Capital_Outlays), sum(Total_Construction),
sum(General_Expenditure), sum(IG_Exp_To_State_Govt), sum(IG_Exp_To_Local_Govts), sum(IG_Exp_To_Federal_Govt), sum(Direct_General_Expend), 
sum(Air_Trans_Total_Expend), sum(Air_Trans_Direct_Expend), sum(Air_Trans_IG_To_State), sum(Air_Trans_IG_Local_Govts), 
sum(Misc_Com_Activ_Tot_Exp), 
sum(Correct_Total_Exp), sum(Correct_Direct_Exp), sum(Correct_IG_To_St), sum(Correct_IG_Loc_Govts), 
sum(Total_Educ_Total_Exp), sum(Total_Educ_Direct_Exp), 
sum(Elem_Educ_Total_Exp), sum(Elem_Educ_Direct_Exp), sum(Elem_Educ_IG_To_State), sum(Elem_Educ_IG_Local_Govts), sum(Elem_Educ_IG_Sch_to_Sch), 
sum(Higher_Ed_Total_Exp), sum(Higher_Ed_Direct_Exp), sum(Higher_Ed_IG_To_St), sum(Higher_Ed_IG_Loc_Govts), 
sum(Educ_NEC_Total_Expend), sum(Educ_NEC_Direct_Expend), sum(Educ_NEC_IG_To_State), sum(var92), 
sum(Emp_Sec_Adm_Direct_Exp), sum(Fin_Admin_Total_Exp), sum(Fin_Admin_Direct_Exp), sum(Fin_Admin_IG_To_State), sum(Fin_Admin_IG_Local_Govts), 
sum(Fire_Prot_Total_Expend), sum(Fire_Prot_Direct_Exp), sum(Fire_Prot_IG_To_State), sum(Fire_Prot_IG_Local_Govts), 
sum(Judicial_Total_Expend), sum(Judicial_Direct_Expend), sum(Judicial_IG_To_State), sum(Judicial_IG_Local_Govts), 
sum(Cen_Staff_Total_Expend), sum(Cen_Staff_Direct_Exp), sum(Cen_Staff_IG_To_State), sum(Cen_Staff_IG_Local_Govts), sum(Gen_Pub_Bldg_Total_Exp), 
sum(Health_Total_Expend), sum(Health_Direct_Expend), sum(Health_IG_To_State), sum(Health_IG_Local_Govts), 
sum(Total_Hospital_Total_Exp), sum(Total_Hospital_Dir_Exp), sum(Total_Hospital_IG_To_State), sum(Total_Hospital_IG_Loc_Govts), 
sum(Own_Hospital_Total_Exp), sum(Hosp_Other_Total_Exp), sum(Hosp_Other_Direct_Exp), sum(Hosp_Other_IG_To_State), sum(var143), 
sum(Total_Highways_Tot_Exp), sum(Total_Highways_Dir_Exp), sum(Regular_Hwy_Total_Exp), sum(Regular_Hwy_Direct_Exp), sum(Regular_Hwy_IG_To_Sta), sum(Regular_Hwy_IG_Loc_Govts), 
sum(Toll_Hwy_Total_Expend), sum(Transit_Sub_Total_Exp), sum(Transit_Sub_Direct_Sub), sum(Transit_Sub_IG_To_Sta), sum(Transit_Sub_IG_Loc_Govts), 
sum(Hous___Com_Total_Exp), sum(Hous___Com_Direct_Exp), sum(Hous___Com_IG_To_State), sum(var167), 
sum(Libraries_Total_Expend), sum(Libraries_Direct_Exp), sum(Libraries_IG_To_State), sum(Libraries_IG_Local_Govts), 
sum(Natural_Res_Total_Exp), sum(Natural_Res_Direct_Exp), sum(Natural_Res_IG_To_Sta), sum(Natural_Res_IG_Loc_Govts), 
sum(Parking_Total_Expend), sum(Parking_Direct_Expend), sum(Parking_IG_To_State), sum(Parking_IG_Local_Govts), 
sum(Parks___Rec_Total_Exp), sum(Parks___Rec_Direct_Exp), sum(Parks___Rec_IG_To_Sta), sum(var191), 
sum(Police_Prot_Total_Exp), sum(Police_Prot_Direct_Exp), sum(Police_Prot_IG_To_Sta), sum(Police_Prot_IG_Loc_Govts), 
sum(Prot_Insp_Total_Exp), sum(Prot_Insp_Direct_Exp), sum(Prot_Insp_IG_To_State), sum(Prot_Insp_IG_Local_Govts), 
sum(Public_Welf_Total_Exp), sum(Public_Welf_Direct_Exp), sum(Public_Welf_Cash_Asst), 
sum(Welf_Categ_Total_Exp), sum(Welf_Categ_Cash_Assist), sum(Welf_Categ_IG_To_State), sum(var212), 
sum(Welf_Cash_Total_Exp), sum(Welf_Cash_Cash_Assist), sum(var215), sum(Welf_Vend_Pmts_Medical), sum(Welf_Vend_Pmts_NEC), sum(Welf_State_Share_Part_D), sum(Welf_Ins_Total_Exp), 
sum(Welf_NEC_Total_Expend), sum(Welf_NEC_Direct_Expend), sum(Welf_NEC_IG_To_State), sum(var227), 
sum(Sewerage_Total_Expend), sum(Sewerage_Direct_Expend), sum(Sewerage_IG_To_State), sum(Sewerage_IG_Local_Govts), sum(SW_Mgmt_Total_Expend), sum(SW_Mgmt_Direct_Expend), sum(SW_Mgmt_IG_To_State), sum(SW_Mgmt_IG_Local_Govts), 
sum(Water_Trans_Total_Exp), sum(Water_Trans_Direct_Exp), sum(Water_Trans_IG_To_Sta), sum(Water_Trans_IG_Loc_Govts)
from exp.exp_12_01
group by govidn
order by govidn;
quit;


data expsum_1201; set expsum_12;
rename _TEMG001=TExp;
rename _TEMG002=TIGExp;
rename _TEMG003=DExp;	
rename _TEMG004=TCurrent_Exp;	
rename _TEMG005=TCurrent_Oper;	
rename _TEMG006=TCapital_Outlays;	
rename _TEMG007=TConstruction;		
rename _TEMG008=GeneralExp;	
rename _TEMG009=IG_Exp_St;	
rename _TEMG010=IG_Exp_Local;	
rename _TEMG011=IG_Exp_Fed;	
rename _TEMG012=DGeneral_Exp;	
rename _TEMG013=TAir_Trans;	
rename _TEMG014=DAir_Trans;	
rename _TEMG015=IGAir_Trans_St;
rename _TEMG016=IGAir_Trans_Local;	
rename _TEMG017=TMisc_Com;	
rename _TEMG018=TCorrect;	
rename _TEMG019=DCorrect;	
rename _TEMG020=IGCorrect_St;	
rename _TEMG021=IGCorrect_Loc;	
rename _TEMG022=TEduc;	
rename _TEMG023=DEduc;	
rename _TEMG024=TElem;	
rename _TEMG025=DElem;	
rename _TEMG026=IGElem_St;	
rename _TEMG027=IGElemLoc;	
rename _TEMG028=IGElem_Sch; 
rename _TEMG029=THigherEd;	
rename _TEMG030=DHigherEd;	
rename _TEMG031=IGHigherEd_St;	
rename _TEMG032=IGHigherEd_Loc;	
rename _TEMG033=TEduc_NEC;	
rename _TEMG034=DEduc_NEC;	
rename _TEMG035=IGEduc_NEC_St;	
rename _TEMG036=IGEduc_NEC_Loc;	
rename _TEMG037=DEmp_Sec_Adm;	
rename _TEMG038=TFin_Admin;	
rename _TEMG039=DFin_Admin;	
rename _TEMG040=IGFin_Admin_St;	
rename _TEMG041=IGFin_Admin_Loc;	
rename _TEMG042=TFire;	
rename _TEMG043=DFire;	
rename _TEMG044=IGFire_St;	
rename _TEMG045=IGFire_Loc;	
rename _TEMG046=TJudicial;	
rename _TEMG047=DJudicial;	
rename _TEMG048=IGJudicial_St;	
rename _TEMG049=IGJudicial_Loc;	
rename _TEMG050=TStaff;	
rename _TEMG051=DStaff;	
rename _TEMG052=IGStaff_St;	
rename _TEMG053=IGStaff_Loc;	
rename _TEMG054=TBldg;	
rename _TEMG055=THealth;	
rename _TEMG056=DHealth;	
rename _TEMG057=IGHealth_St;	
rename _TEMG058=IGHealth_Loc;	
rename _TEMG059=THospital;	
rename _TEMG060=DHospital;	
rename _TEMG061=IGHospital_St;	
rename _TEMG062=IGHospital_Loc;	
rename _TEMG063=TOwn_Hospital;	
rename _TEMG064=THosp_Other;	
rename _TEMG065=DHosp_Other;	
rename _TEMG066=IGHosp_Other_St;	
rename _TEMG067=IGHosp_Other_Loc;	
rename _TEMG068=THighways;	
rename _TEMG069=DHighways;	
rename _TEMG070=TRegular_Hwy;	
rename _TEMG071=DRegular_Hwy;	
rename _TEMG072=IGRegular_Hwy_St;	
rename _TEMG073=IGRegular_Hwy_Loc;	
rename _TEMG074=TToll_Hwy; 
rename _TEMG075=TTransit_Sub;	
rename _TEMG076=DTransit_Sub;	
rename _TEMG077=IGTransit_Sub_St;	
rename _TEMG078=IGTransit_Sub_Loc;	
rename _TEMG079=THousCom;	
rename _TEMG080=DHousCom;	
rename _TEMG081=IGHousCom_St;	
rename _TEMG082=IGHousCom_Loc;	
rename _TEMG083=TLib;	
rename _TEMG084=DLib;	
rename _TEMG085=IGLib_St;	
rename _TEMG086=IGLib_Loc;	
rename _TEMG087=TNatural_Res;	
rename _TEMG088=DNatural_Res;	
rename _TEMG089=IGNatural_Res_St;	
rename _TEMG090=IGNatural_Res_Loc;	
rename _TEMG091=TParking;	
rename _TEMG092=DParking;	
rename _TEMG093=IGParking_St;	
rename _TEMG094=IGParking_Loc;	
rename _TEMG095=TParks;	
rename _TEMG096=DParks;	
rename _TEMG097=IGParks_St;	
rename _TEMG098=IGParks_Loc;	
rename _TEMG099=TPolice;	
rename _TEMG100=DPolice;	
rename _TEMG101=IGPolice_St;	
rename _TEMG102=IGPolice_Loc;	
rename _TEMG103=TProt_Insp;	
rename _TEMG104=DProt_Insp;	
rename _TEMG105=IGProt_Insp_St;	
rename _TEMG106=IGProt_Insp_Loc;	
rename _TEMG107=TPublic_Welf;	
rename _TEMG108=DPublic_Welf;	
rename _TEMG109=Public_Welf_Cash_Asst;	
rename _TEMG110=TWelf_Categ;	
rename _TEMG111=Welf_Categ_Cash_Assist;	
rename _TEMG112=IGWelf_Categ_St;	
rename _TEMG113=IGWelf_Categ_Loc;	
rename _TEMG114=TWelf_Cash;	
rename _TEMG115=Welf_Cash_Cash_Assist;	
rename _TEMG116=IGWelf_Cash_Loc;	
rename _TEMG117=Welf_Vend_Pmts_Medical;	
rename _TEMG118=Welf_Vend_Pmts_NEC;	
rename _TEMG119=Welf_State_Share_Part_D;	
rename _TEMG120=TWelf_Ins;	
rename _TEMG121=TWelf_NEC;	
rename _TEMG122=DWelf_NEC;	
rename _TEMG123=IGWelf_NEC_St;	
rename _TEMG124=IGWelf_NEC_Loc; 
rename _TEMG125=TSewerage;	
rename _TEMG126=DSewerage;	
rename _TEMG127=IGSewerage_St;	
rename _TEMG128=IGSewerage_Loc;	
rename _TEMG129=TSW_Mgmt;	
rename _TEMG130=DSW_Mgmt;	
rename _TEMG131=IGSW_Mgmt_St;	
rename _TEMG132=IGSW_Mgmt_Loc;	
rename _TEMG133=TWater_Trans;	
rename _TEMG134=DWater_Trans;	
rename _TEMG135=IGWater_Trans_St;	
rename _TEMG136=IGWater_Trans_Loc;	
Run;

Proc import out = Exp.govid_fips datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\crosswalk_govid_fips_name.xlsx"
DBMS = xlsx replace;
Sheet = "sheet1";
Getnames =yes;
Run;

proc sort data=expsum_1201; by govidn; run;
proc sort data=exp.govid_fips; by govidn; run;

data exp.expsum_1210; 
merge expsum_1201 exp.govid_fips; by govidn; run;



/* FRAGMENTATION DATA - GOV FREQUENCY - 2012 */
/**CREATE # OF GOVERNMENT (EACH TYPE) **/

data type1_12; set exp.exp_12_01; where type_code=1; run;
data type2_12; set exp.exp_12_01; where type_code=2; run;
data type3_12; set exp.exp_12_01; where type_code=3; run;
data type4_12; set exp.exp_12_01; where type_code=4; run;
data type5_12; set exp.exp_12_01; where type_code=5; run;


/** type 1 **/
proc sort data=type1_12; by stn ctn; run;

proc freq data=type1_12;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_11_12;
run;

proc transpose data=ngov_11_12 
out=ngov_12_12
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 2 **/
proc sort data=type2_12; by stn ctn; run;

proc freq data=type2_12;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_21_12;
run;

proc transpose data=ngov_21_12 
out=ngov_22_12
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 3 **/
proc sort data=type3_12; by stn ctn; run;

proc freq data=type3_12;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_31_12;
run;

proc transpose data=ngov_31_12 
out=ngov_32_12
prefix=Count;
var Count;
by stn ctn govidn;
run;


/** type 4 **/
proc sort data=type4_12; by stn ctn; run;

proc freq data=type4_12;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_41_12;
run;

proc transpose data=ngov_41_12 
out=ngov_42_12
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 5 **/
proc sort data=type5_12; by stn ctn; run;

proc freq data=type5_12;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_51_12;
run;

proc transpose data=ngov_51_12 
out=ngov_52_12
prefix=Count;
var Count;
by stn ctn govidn;
run;



/*** Count1 name changed as # gov has variable name "count1" ***/ 
data ngov_22_12; set ngov_22_12; rename count1=count2; run;
data ngov_32_12; set ngov_32_12; rename count1=count3; run;
data ngov_42_12; set ngov_42_12; rename count1=count4; run;
data ngov_52_12; set ngov_52_12; rename count1=count5; run;

proc sort data=ngov_12_12; by govidn; run;
proc sort data=ngov_22_12; by govidn; run;
proc sort data=ngov_32_12; by govidn; run;
proc sort data=ngov_42_12; by govidn; run;
proc sort data=ngov_52_12; by govidn; run;

data exp.ngov_12; 
merge ngov_12_12 ngov_22_12 ngov_32_12 ngov_42_12 ngov_52_12; by govidn; run; /** # gov completed **/

data exp.ngov_12; set exp.ngov_12; 
rename count1=type1; rename count2=type2; rename count3=type3; rename count4=type4; rename count5=type5;
/*rename st=stc; rename ct=ctc;*/ run; /* As it's merged with cross_gov_FIPS_12 data, ct and st are not compatible because it has numeric st and ct while other has character variables */




/* MERGE Ngov_12 (# of gov, gov fips codes) WITH EXP_SUM DATA */
proc sort data= exp.ngov_12; by govidn; run;
proc sort data= exp.expsum_1210; by govidn; run;

data exp.expsum_1211; 
merge exp.ngov_12 exp.expsum_1210; by govidn; run;





/**********************************************************************************************************************************************************************/
/****************************************** 2007 DATA *****************************************************************************************************************/

Proc import out = Exp.exp_07 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\IndFin07_Exp.xlsx"
DBMS = xlsx replace;
Sheet = "IndFin07a";
Getnames =yes;
Run;

data exp.exp_07_01 
(keep=Year4	ID IDChanged State_Code Type_Code County Census_Region FIPS_Code_State	Population 
Total_Expenditure Total_IG_Expenditure Direct_Expenditure Total_Current_Expend Total_Current_Oper Total_Capital_Outlays	Total_Construction 
General_Expenditure	IG_Exp_To_State_Govt IG_Exp_To_Local_Govts IG_Exp_To_Federal_Govt Direct_General_Expend	
Air_Trans_Total_Expend Air_Trans_Direct_Expend Air_Trans_IG_To_State Air_Trans_IG_Local_Govts 
Misc_Com_Activ_Tot_Exp
Correct_Total_Exp Correct_Direct_Exp Correct_IG_To_St Correct_IG_Loc_Govts 
Total_Educ_Total_Exp Total_Educ_Direct_Exp Elem_Educ_Total_Exp Elem_Educ_Direct_Exp Elem_Educ_IG_To_State Elem_Educ_IG_Local_Govts Elem_Educ_IG_Sch_to_Sch
Higher_Ed_Total_Exp	Higher_Ed_Direct_Exp Higher_Ed_IG_To_St	Higher_Ed_IG_Loc_Govts Educ_NEC_Total_Expend Educ_NEC_Direct_Expend Educ_NEC_IG_To_State var91
Emp_Sec_Adm_Direct_Exp Fin_Admin_Total_Exp Fin_Admin_Direct_Exp Fin_Admin_IG_To_State Fin_Admin_IG_Local_Govts 
Fire_Prot_Total_Expend Fire_Prot_Direct_Exp Fire_Prot_IG_To_State Fire_Prot_IG_Local_Govts 
Judicial_Total_Expend Judicial_Direct_Expend Judicial_IG_To_State Judicial_IG_Local_Govts 
Cen_Staff_Total_Expend Cen_Staff_Direct_Exp Cen_Staff_IG_To_State Cen_Staff_IG_Local_Govts Gen_Pub_Bldg_Total_Exp
Health_Total_Expend	Health_Direct_Expend Health_IG_To_State	Health_IG_Local_Govts
Total_Hospital_Total_Exp Total_Hospital_Dir_Exp Total_Hospital_IG_To_State Total_Hospital_IG_Loc_Govts  
Own_Hospital_Total_Exp Hosp_Other_Total_Exp Hosp_Other_Direct_Exp Hosp_Other_IG_To_State var142
Total_Highways_Tot_Exp Total_Highways_Dir_Exp Regular_Hwy_Total_Exp Regular_Hwy_Direct_Exp Regular_Hwy_IG_To_Sta Regular_Hwy_IG_Loc_Govts 
Toll_Hwy_Total_Expend Transit_Sub_Total_Exp Transit_Sub_Direct_Sub Transit_Sub_IG_To_Sta Transit_Sub_IG_Loc_Govts 
Hous___Com_Total_Exp Hous___Com_Direct_Exp Hous___Com_IG_To_State var166
Libraries_Total_Expend Libraries_Direct_Exp	Libraries_IG_To_State Libraries_IG_Local_Govts
Natural_Res_Total_Exp Natural_Res_Direct_Exp Natural_Res_IG_To_Sta Natural_Res_IG_Loc_Govts 
Parking_Total_Expend Parking_Direct_Expend Parking_IG_To_State Parking_IG_Local_Govts
Parks___Rec_Total_Exp Parks___Rec_Direct_Exp Parks___Rec_IG_To_Sta var190	
Police_Prot_Total_Exp Police_Prot_Direct_Exp Police_Prot_IG_To_Sta Police_Prot_IG_Loc_Govts 
Prot_Insp_Total_Exp Prot_Insp_Direct_Exp Prot_Insp_IG_To_State Prot_Insp_IG_Local_Govts 
Public_Welf_Total_Exp Public_Welf_Direct_Exp Public_Welf_Cash_Asst 
Welf_Categ_Total_Exp Welf_Categ_Cash_Assist Welf_Categ_IG_To_State var211 
Welf_Cash_Total_Exp Welf_Cash_Cash_Assist var214 
Welf_Vend_Pmts_Medical Welf_Vend_Pmts_NEC Welf_State_Share_Part_D Welf_Ins_Total_Exp 
Welf_NEC_Total_Expend Welf_NEC_Direct_Expend Welf_NEC_IG_To_State var226 
Sewerage_Total_Expend Sewerage_Direct_Expend Sewerage_IG_To_State Sewerage_IG_Local_Govts 
SW_Mgmt_Total_Expend SW_Mgmt_Direct_Expend SW_Mgmt_IG_To_State SW_Mgmt_IG_Local_Govts 
Water_Trans_Total_Exp Water_Trans_Direct_Exp Water_Trans_IG_To_Sta Water_Trans_IG_Loc_Govts);	
Set exp.exp_07; run;

/* Create Govid */
data exp.exp_07_01; set exp.exp_07_01; rename state_code=stn; rename county=ctn; run;
data exp.exp_07_01; set exp.exp_07_01; govidn=(stn*1000)+ctn; run;


/*SUM OF SPENDING BY CATEGORY*/
proc sql;
create table expsum_07 as 
select govidn, sum(Total_Expenditure), sum(Total_IG_Expenditure), sum(Direct_Expenditure), sum(Total_Current_Expend), sum(Total_Current_Oper), sum(Total_Capital_Outlays), sum(Total_Construction),
sum(General_Expenditure), sum(IG_Exp_To_State_Govt), sum(IG_Exp_To_Local_Govts), sum(IG_Exp_To_Federal_Govt), sum(Direct_General_Expend), 
sum(Air_Trans_Total_Expend), sum(Air_Trans_Direct_Expend), sum(Air_Trans_IG_To_State), sum(Air_Trans_IG_Local_Govts), 
sum(Misc_Com_Activ_Tot_Exp), 
sum(Correct_Total_Exp), sum(Correct_Direct_Exp), sum(Correct_IG_To_St), sum(Correct_IG_Loc_Govts), 
sum(Total_Educ_Total_Exp), sum(Total_Educ_Direct_Exp), 
sum(Elem_Educ_Total_Exp), sum(Elem_Educ_Direct_Exp), sum(Elem_Educ_IG_To_State), sum(Elem_Educ_IG_Local_Govts), sum(Elem_Educ_IG_Sch_to_Sch), 
sum(Higher_Ed_Total_Exp), sum(Higher_Ed_Direct_Exp), sum(Higher_Ed_IG_To_St), sum(Higher_Ed_IG_Loc_Govts), 
sum(Educ_NEC_Total_Expend), sum(Educ_NEC_Direct_Expend), sum(Educ_NEC_IG_To_State), sum(var91), 
sum(Emp_Sec_Adm_Direct_Exp), sum(Fin_Admin_Total_Exp), sum(Fin_Admin_Direct_Exp), sum(Fin_Admin_IG_To_State), sum(Fin_Admin_IG_Local_Govts), 
sum(Fire_Prot_Total_Expend), sum(Fire_Prot_Direct_Exp), sum(Fire_Prot_IG_To_State), sum(Fire_Prot_IG_Local_Govts), 
sum(Judicial_Total_Expend), sum(Judicial_Direct_Expend), sum(Judicial_IG_To_State), sum(Judicial_IG_Local_Govts), 
sum(Cen_Staff_Total_Expend), sum(Cen_Staff_Direct_Exp), sum(Cen_Staff_IG_To_State), sum(Cen_Staff_IG_Local_Govts), sum(Gen_Pub_Bldg_Total_Exp), 
sum(Health_Total_Expend), sum(Health_Direct_Expend), sum(Health_IG_To_State), sum(Health_IG_Local_Govts), 
sum(Total_Hospital_Total_Exp), sum(Total_Hospital_Dir_Exp), sum(Total_Hospital_IG_To_State), sum(Total_Hospital_IG_Loc_Govts), 
sum(Own_Hospital_Total_Exp), sum(Hosp_Other_Total_Exp), sum(Hosp_Other_Direct_Exp), sum(Hosp_Other_IG_To_State), sum(var142), 
sum(Total_Highways_Tot_Exp), sum(Total_Highways_Dir_Exp), sum(Regular_Hwy_Total_Exp), sum(Regular_Hwy_Direct_Exp), sum(Regular_Hwy_IG_To_Sta), sum(Regular_Hwy_IG_Loc_Govts), 
sum(Toll_Hwy_Total_Expend), sum(Transit_Sub_Total_Exp), sum(Transit_Sub_Direct_Sub), sum(Transit_Sub_IG_To_Sta), sum(Transit_Sub_IG_Loc_Govts), 
sum(Hous___Com_Total_Exp), sum(Hous___Com_Direct_Exp), sum(Hous___Com_IG_To_State), sum(var166), 
sum(Libraries_Total_Expend), sum(Libraries_Direct_Exp), sum(Libraries_IG_To_State), sum(Libraries_IG_Local_Govts), 
sum(Natural_Res_Total_Exp), sum(Natural_Res_Direct_Exp), sum(Natural_Res_IG_To_Sta), sum(Natural_Res_IG_Loc_Govts), 
sum(Parking_Total_Expend), sum(Parking_Direct_Expend), sum(Parking_IG_To_State), sum(Parking_IG_Local_Govts), 
sum(Parks___Rec_Total_Exp), sum(Parks___Rec_Direct_Exp), sum(Parks___Rec_IG_To_Sta), sum(var190), 
sum(Police_Prot_Total_Exp), sum(Police_Prot_Direct_Exp), sum(Police_Prot_IG_To_Sta), sum(Police_Prot_IG_Loc_Govts), 
sum(Prot_Insp_Total_Exp), sum(Prot_Insp_Direct_Exp), sum(Prot_Insp_IG_To_State), sum(Prot_Insp_IG_Local_Govts), 
sum(Public_Welf_Total_Exp), sum(Public_Welf_Direct_Exp), sum(Public_Welf_Cash_Asst), 
sum(Welf_Categ_Total_Exp), sum(Welf_Categ_Cash_Assist), sum(Welf_Categ_IG_To_State), sum(var211), 
sum(Welf_Cash_Total_Exp), sum(Welf_Cash_Cash_Assist), sum(var214), sum(Welf_Vend_Pmts_Medical), sum(Welf_Vend_Pmts_NEC), sum(Welf_State_Share_Part_D), sum(Welf_Ins_Total_Exp), 
sum(Welf_NEC_Total_Expend), sum(Welf_NEC_Direct_Expend), sum(Welf_NEC_IG_To_State), sum(var226), 
sum(Sewerage_Total_Expend), sum(Sewerage_Direct_Expend), sum(Sewerage_IG_To_State), sum(Sewerage_IG_Local_Govts), sum(SW_Mgmt_Total_Expend), sum(SW_Mgmt_Direct_Expend), sum(SW_Mgmt_IG_To_State), sum(SW_Mgmt_IG_Local_Govts), 
sum(Water_Trans_Total_Exp), sum(Water_Trans_Direct_Exp), sum(Water_Trans_IG_To_Sta), sum(Water_Trans_IG_Loc_Govts)
from exp.exp_07_01
group by govidn
order by govidn;
quit;


data expsum_0701; set expsum_07;
rename _TEMG001=TExp;
rename _TEMG002=TIGExp;
rename _TEMG003=DExp;	
rename _TEMG004=TCurrent_Exp;	
rename _TEMG005=TCurrent_Oper;	
rename _TEMG006=TCapital_Outlays;	
rename _TEMG007=TConstruction;		
rename _TEMG008=GeneralExp;	
rename _TEMG009=IG_Exp_St;	
rename _TEMG010=IG_Exp_Local;	
rename _TEMG011=IG_Exp_Fed;	
rename _TEMG012=DGeneral_Exp;	
rename _TEMG013=TAir_Trans;	
rename _TEMG014=DAir_Trans;	
rename _TEMG015=IGAir_Trans_St;
rename _TEMG016=IGAir_Trans_Local;	
rename _TEMG017=TMisc_Com;	
rename _TEMG018=TCorrect;	
rename _TEMG019=DCorrect;	
rename _TEMG020=IGCorrect_St;	
rename _TEMG021=IGCorrect_Loc;	
rename _TEMG022=TEduc;	
rename _TEMG023=DEduc;	
rename _TEMG024=TElem;	
rename _TEMG025=DElem;	
rename _TEMG026=IGElem_St;	
rename _TEMG027=IGElemLoc;	
rename _TEMG028=IGElem_Sch; 
rename _TEMG029=THigherEd;	
rename _TEMG030=DHigherEd;	
rename _TEMG031=IGHigherEd_St;	
rename _TEMG032=IGHigherEd_Loc;	
rename _TEMG033=TEduc_NEC;	
rename _TEMG034=DEduc_NEC;	
rename _TEMG035=IGEduc_NEC_St;	
rename _TEMG036=IGEduc_NEC_Loc;	
rename _TEMG037=DEmp_Sec_Adm;	
rename _TEMG038=TFin_Admin;	
rename _TEMG039=DFin_Admin;	
rename _TEMG040=IGFin_Admin_St;	
rename _TEMG041=IGFin_Admin_Loc;	
rename _TEMG042=TFire;	
rename _TEMG043=DFire;	
rename _TEMG044=IGFire_St;	
rename _TEMG045=IGFire_Loc;	
rename _TEMG046=TJudicial;	
rename _TEMG047=DJudicial;	
rename _TEMG048=IGJudicial_St;	
rename _TEMG049=IGJudicial_Loc;	
rename _TEMG050=TStaff;	
rename _TEMG051=DStaff;	
rename _TEMG052=IGStaff_St;	
rename _TEMG053=IGStaff_Loc;	
rename _TEMG054=TBldg;	
rename _TEMG055=THealth;	
rename _TEMG056=DHealth;	
rename _TEMG057=IGHealth_St;	
rename _TEMG058=IGHealth_Loc;	
rename _TEMG059=THospital;	
rename _TEMG060=DHospital;	
rename _TEMG061=IGHospital_St;	
rename _TEMG062=IGHospital_Loc;	
rename _TEMG063=TOwn_Hospital;	
rename _TEMG064=THosp_Other;	
rename _TEMG065=DHosp_Other;	
rename _TEMG066=IGHosp_Other_St;	
rename _TEMG067=IGHosp_Other_Loc;	
rename _TEMG068=THighways;	
rename _TEMG069=DHighways;	
rename _TEMG070=TRegular_Hwy;	
rename _TEMG071=DRegular_Hwy;	
rename _TEMG072=IGRegular_Hwy_St;	
rename _TEMG073=IGRegular_Hwy_Loc;	
rename _TEMG074=TToll_Hwy; 
rename _TEMG075=TTransit_Sub;	
rename _TEMG076=DTransit_Sub;	
rename _TEMG077=IGTransit_Sub_St;	
rename _TEMG078=IGTransit_Sub_Loc;	
rename _TEMG079=THousCom;	
rename _TEMG080=DHousCom;	
rename _TEMG081=IGHousCom_St;	
rename _TEMG082=IGHousCom_Loc;	
rename _TEMG083=TLib;	
rename _TEMG084=DLib;	
rename _TEMG085=IGLib_St;	
rename _TEMG086=IGLib_Loc;	
rename _TEMG087=TNatural_Res;	
rename _TEMG088=DNatural_Res;	
rename _TEMG089=IGNatural_Res_St;	
rename _TEMG090=IGNatural_Res_Loc;	
rename _TEMG091=TParking;	
rename _TEMG092=DParking;	
rename _TEMG093=IGParking_St;	
rename _TEMG094=IGParking_Loc;	
rename _TEMG095=TParks;	
rename _TEMG096=DParks;	
rename _TEMG097=IGParks_St;	
rename _TEMG098=IGParks_Loc;	
rename _TEMG099=TPolice;	
rename _TEMG100=DPolice;	
rename _TEMG101=IGPolice_St;	
rename _TEMG102=IGPolice_Loc;	
rename _TEMG103=TProt_Insp;	
rename _TEMG104=DProt_Insp;	
rename _TEMG105=IGProt_Insp_St;	
rename _TEMG106=IGProt_Insp_Loc;	
rename _TEMG107=TPublic_Welf;	
rename _TEMG108=DPublic_Welf;	
rename _TEMG109=Public_Welf_Cash_Asst;	
rename _TEMG110=TWelf_Categ;	
rename _TEMG111=Welf_Categ_Cash_Assist;	
rename _TEMG112=IGWelf_Categ_St;	
rename _TEMG113=IGWelf_Categ_Loc;	
rename _TEMG114=TWelf_Cash;	
rename _TEMG115=Welf_Cash_Cash_Assist;	
rename _TEMG116=IGWelf_Cash_Loc;	
rename _TEMG117=Welf_Vend_Pmts_Medical;	
rename _TEMG118=Welf_Vend_Pmts_NEC;	
rename _TEMG119=Welf_State_Share_Part_D;	
rename _TEMG120=TWelf_Ins;	
rename _TEMG121=TWelf_NEC;	
rename _TEMG122=DWelf_NEC;	
rename _TEMG123=IGWelf_NEC_St;	
rename _TEMG124=IGWelf_NEC_Loc; 
rename _TEMG125=TSewerage;	
rename _TEMG126=DSewerage;	
rename _TEMG127=IGSewerage_St;	
rename _TEMG128=IGSewerage_Loc;	
rename _TEMG129=TSW_Mgmt;	
rename _TEMG130=DSW_Mgmt;	
rename _TEMG131=IGSW_Mgmt_St;	
rename _TEMG132=IGSW_Mgmt_Loc;	
rename _TEMG133=TWater_Trans;	
rename _TEMG134=DWater_Trans;	
rename _TEMG135=IGWater_Trans_St;	
rename _TEMG136=IGWater_Trans_Loc;	
Run;

Proc import out = Exp.govid_fips datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\crosswalk_govid_fips_name.xlsx"
DBMS = xlsx replace;
Sheet = "sheet1";
Getnames =yes;
Run;

proc sort data=expsum_0701; by govidn; run;
proc sort data=exp.govid_fips; by govidn; run;

data exp.expsum_0710; 
merge expsum_0701 exp.govid_fips; by govidn; run;



/* FRAGMENTATION DATA - GOV FREQUENCY - 2007 */
/**CREATE # OF GOVERNMENT (EACH TYPE) **/

data type1_07; set exp.exp_07_01; where type_code=1; run;
data type2_07; set exp.exp_07_01; where type_code=2; run;
data type3_07; set exp.exp_07_01; where type_code=3; run;
data type4_07; set exp.exp_07_01; where type_code=4; run;
data type5_07; set exp.exp_07_01; where type_code=5; run;


/** type 1 **/
proc sort data=type1_07; by stn ctn; run;

proc freq data=type1_07;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_11_07;
run;

proc transpose data=ngov_11_07 
out=ngov_12_07
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 2 **/
proc sort data=type2_07; by stn ctn; run;

proc freq data=type2_07;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_21_07;
run;

proc transpose data=ngov_21_07 
out=ngov_22_07
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 3 **/
proc sort data=type3_07; by stn ctn; run;

proc freq data=type3_07;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_31_07;
run;

proc transpose data=ngov_31_07 
out=ngov_32_07
prefix=Count;
var Count;
by stn ctn govidn;
run;


/** type 4 **/
proc sort data=type4_07; by stn ctn; run;

proc freq data=type4_07;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_41_07;
run;

proc transpose data=ngov_41_07 
out=ngov_42_07
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 5 **/
proc sort data=type5_07; by stn ctn; run;

proc freq data=type5_07;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_51_07;
run;

proc transpose data=ngov_51_07 
out=ngov_52_07
prefix=Count;
var Count;
by stn ctn govidn;
run;



/*** Count1 name changed as # gov has variable name "count1" ***/ 
data ngov_22_07; set ngov_22_07; rename count1=count2; run;
data ngov_32_07; set ngov_32_07; rename count1=count3; run;
data ngov_42_07; set ngov_42_07; rename count1=count4; run;
data ngov_52_07; set ngov_52_07; rename count1=count5; run;

proc sort data=ngov_12_07; by govidn; run;
proc sort data=ngov_22_07; by govidn; run;
proc sort data=ngov_32_07; by govidn; run;
proc sort data=ngov_42_07; by govidn; run;
proc sort data=ngov_52_07; by govidn; run;

data exp.ngov_07; 
merge ngov_12_07 ngov_22_07 ngov_32_07 ngov_42_07 ngov_52_07; by govidn; run; /** # gov completed **/

data exp.ngov_07; set exp.ngov_07; 
rename count1=type1; rename count2=type2; rename count3=type3; rename count4=type4; rename count5=type5;
/*rename st=stc; rename ct=ctc;*/ run; /* As it's merged with cross_gov_FIPS_12 data, ct and st are not compatible because it has numeric st and ct while other has character variables */




/* MERGE Ngov_07 (# of gov, gov fips codes) WITH EXP_SUM DATA */
proc sort data= exp.ngov_07; by govidn; run;
proc sort data= exp.expsum_0710; by govidn; run;

data exp.expsum_0711; 
merge exp.ngov_07 exp.expsum_0710; by govidn; run;



/* TO HERE 111715 */


/**********************************************************************************************************************************************************************/
/****************************************** 2002 DATA *****************************************************************************************************************/

Proc import out = Exp.exp_02 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\IndFin02_Exp.xlsx"
DBMS = xlsx replace;
Sheet = "IndFin02a";
Getnames =yes;
Run;

data exp.exp_02_01 
(keep=Year4	ID IDChanged State_Code Type_Code County Census_Region FIPS_Code_State	Population 
Total_Expenditure Total_IG_Expenditure Direct_Expenditure Total_Current_Expend Total_Current_Oper Total_Capital_Outlays	Total_Construction 
General_Expenditure	IG_Exp_To_State_Govt IG_Exp_To_Local_Govts IG_Exp_To_Federal_Govt Direct_General_Expend	
Air_Trans_Total_Expend Air_Trans_Direct_Expend Air_Trans_IG_To_State Air_Trans_IG_Local_Govts 
Misc_Com_Activ_Tot_Exp
Correct_Total_Exp Correct_Direct_Exp Correct_IG_To_St Correct_IG_Loc_Govts 
Total_Educ_Total_Exp Total_Educ_Direct_Exp Elem_Educ_Total_Exp Elem_Educ_Direct_Exp Elem_Educ_IG_To_State Elem_Educ_IG_Local_Govts Elem_Educ_IG_Sch_to_Sch
Higher_Ed_Total_Exp	Higher_Ed_Direct_Exp Higher_Ed_IG_To_St	Higher_Ed_IG_Loc_Govts Educ_NEC_Total_Expend Educ_NEC_Direct_Expend Educ_NEC_IG_To_State var91
Emp_Sec_Adm_Direct_Exp Fin_Admin_Total_Exp Fin_Admin_Direct_Exp Fin_Admin_IG_To_State Fin_Admin_IG_Local_Govts 
Fire_Prot_Total_Expend Fire_Prot_Direct_Exp Fire_Prot_IG_To_State Fire_Prot_IG_Local_Govts 
Judicial_Total_Expend Judicial_Direct_Expend Judicial_IG_To_State Judicial_IG_Local_Govts 
Cen_Staff_Total_Expend Cen_Staff_Direct_Exp Cen_Staff_IG_To_State Cen_Staff_IG_Local_Govts Gen_Pub_Bldg_Total_Exp
Health_Total_Expend	Health_Direct_Expend Health_IG_To_State	Health_IG_Local_Govts
Total_Hospital_Total_Exp Total_Hospital_Dir_Exp Total_Hospital_IG_To_State Total_Hospital_IG_Loc_Govts  
Own_Hospital_Total_Exp Hosp_Other_Total_Exp Hosp_Other_Direct_Exp Hosp_Other_IG_To_State var142
Total_Highways_Tot_Exp Total_Highways_Dir_Exp Regular_Hwy_Total_Exp Regular_Hwy_Direct_Exp Regular_Hwy_IG_To_Sta Regular_Hwy_IG_Loc_Govts 
Toll_Hwy_Total_Expend Transit_Sub_Total_Exp Transit_Sub_Direct_Sub Transit_Sub_IG_To_Sta Transit_Sub_IG_Loc_Govts 
Hous___Com_Total_Exp Hous___Com_Direct_Exp Hous___Com_IG_To_State var166
Libraries_Total_Expend Libraries_Direct_Exp	Libraries_IG_To_State Libraries_IG_Local_Govts
Natural_Res_Total_Exp Natural_Res_Direct_Exp Natural_Res_IG_To_Sta Natural_Res_IG_Loc_Govts 
Parking_Total_Expend Parking_Direct_Expend Parking_IG_To_State Parking_IG_Local_Govts
Parks___Rec_Total_Exp Parks___Rec_Direct_Exp Parks___Rec_IG_To_Sta var190	
Police_Prot_Total_Exp Police_Prot_Direct_Exp Police_Prot_IG_To_Sta Police_Prot_IG_Loc_Govts 
Prot_Insp_Total_Exp Prot_Insp_Direct_Exp Prot_Insp_IG_To_State Prot_Insp_IG_Local_Govts 
Public_Welf_Total_Exp Public_Welf_Direct_Exp Public_Welf_Cash_Asst 
Welf_Categ_Total_Exp Welf_Categ_Cash_Assist Welf_Categ_IG_To_State var211 
Welf_Cash_Total_Exp Welf_Cash_Cash_Assist var214 
Welf_Vend_Pmts_Medical Welf_Vend_Pmts_NEC Welf_State_Share_Part_D Welf_Ins_Total_Exp 
Welf_NEC_Total_Expend Welf_NEC_Direct_Expend Welf_NEC_IG_To_State var226 
Sewerage_Total_Expend Sewerage_Direct_Expend Sewerage_IG_To_State Sewerage_IG_Local_Govts 
SW_Mgmt_Total_Expend SW_Mgmt_Direct_Expend SW_Mgmt_IG_To_State SW_Mgmt_IG_Local_Govts 
Water_Trans_Total_Exp Water_Trans_Direct_Exp Water_Trans_IG_To_Sta Water_Trans_IG_Loc_Govts);	
Set exp.exp_02; run;

/* Create Govid */
data exp.exp_02_01; set exp.exp_02_01; rename state_code=stn; rename county=ctn; run;
data exp.exp_02_01; set exp.exp_02_01; govidn=(stn*1000)+ctn; run;


/*SUM OF SPENDING BY CATEGORY*/
proc sql;
create table expsum_02 as 
select govidn, sum(Total_Expenditure), sum(Total_IG_Expenditure), sum(Direct_Expenditure), sum(Total_Current_Expend), sum(Total_Current_Oper), sum(Total_Capital_Outlays), sum(Total_Construction),
sum(General_Expenditure), sum(IG_Exp_To_State_Govt), sum(IG_Exp_To_Local_Govts), sum(IG_Exp_To_Federal_Govt), sum(Direct_General_Expend), 
sum(Air_Trans_Total_Expend), sum(Air_Trans_Direct_Expend), sum(Air_Trans_IG_To_State), sum(Air_Trans_IG_Local_Govts), 
sum(Misc_Com_Activ_Tot_Exp), 
sum(Correct_Total_Exp), sum(Correct_Direct_Exp), sum(Correct_IG_To_St), sum(Correct_IG_Loc_Govts), 
sum(Total_Educ_Total_Exp), sum(Total_Educ_Direct_Exp), 
sum(Elem_Educ_Total_Exp), sum(Elem_Educ_Direct_Exp), sum(Elem_Educ_IG_To_State), sum(Elem_Educ_IG_Local_Govts), sum(Elem_Educ_IG_Sch_to_Sch), 
sum(Higher_Ed_Total_Exp), sum(Higher_Ed_Direct_Exp), sum(Higher_Ed_IG_To_St), sum(Higher_Ed_IG_Loc_Govts), 
sum(Educ_NEC_Total_Expend), sum(Educ_NEC_Direct_Expend), sum(Educ_NEC_IG_To_State), sum(var91), 
sum(Emp_Sec_Adm_Direct_Exp), sum(Fin_Admin_Total_Exp), sum(Fin_Admin_Direct_Exp), sum(Fin_Admin_IG_To_State), sum(Fin_Admin_IG_Local_Govts), 
sum(Fire_Prot_Total_Expend), sum(Fire_Prot_Direct_Exp), sum(Fire_Prot_IG_To_State), sum(Fire_Prot_IG_Local_Govts), 
sum(Judicial_Total_Expend), sum(Judicial_Direct_Expend), sum(Judicial_IG_To_State), sum(Judicial_IG_Local_Govts), 
sum(Cen_Staff_Total_Expend), sum(Cen_Staff_Direct_Exp), sum(Cen_Staff_IG_To_State), sum(Cen_Staff_IG_Local_Govts), sum(Gen_Pub_Bldg_Total_Exp), 
sum(Health_Total_Expend), sum(Health_Direct_Expend), sum(Health_IG_To_State), sum(Health_IG_Local_Govts), 
sum(Total_Hospital_Total_Exp), sum(Total_Hospital_Dir_Exp), sum(Total_Hospital_IG_To_State), sum(Total_Hospital_IG_Loc_Govts), 
sum(Own_Hospital_Total_Exp), sum(Hosp_Other_Total_Exp), sum(Hosp_Other_Direct_Exp), sum(Hosp_Other_IG_To_State), sum(var142), 
sum(Total_Highways_Tot_Exp), sum(Total_Highways_Dir_Exp), sum(Regular_Hwy_Total_Exp), sum(Regular_Hwy_Direct_Exp), sum(Regular_Hwy_IG_To_Sta), sum(Regular_Hwy_IG_Loc_Govts), 
sum(Toll_Hwy_Total_Expend), sum(Transit_Sub_Total_Exp), sum(Transit_Sub_Direct_Sub), sum(Transit_Sub_IG_To_Sta), sum(Transit_Sub_IG_Loc_Govts), 
sum(Hous___Com_Total_Exp), sum(Hous___Com_Direct_Exp), sum(Hous___Com_IG_To_State), sum(var166), 
sum(Libraries_Total_Expend), sum(Libraries_Direct_Exp), sum(Libraries_IG_To_State), sum(Libraries_IG_Local_Govts), 
sum(Natural_Res_Total_Exp), sum(Natural_Res_Direct_Exp), sum(Natural_Res_IG_To_Sta), sum(Natural_Res_IG_Loc_Govts), 
sum(Parking_Total_Expend), sum(Parking_Direct_Expend), sum(Parking_IG_To_State), sum(Parking_IG_Local_Govts), 
sum(Parks___Rec_Total_Exp), sum(Parks___Rec_Direct_Exp), sum(Parks___Rec_IG_To_Sta), sum(var190), 
sum(Police_Prot_Total_Exp), sum(Police_Prot_Direct_Exp), sum(Police_Prot_IG_To_Sta), sum(Police_Prot_IG_Loc_Govts), 
sum(Prot_Insp_Total_Exp), sum(Prot_Insp_Direct_Exp), sum(Prot_Insp_IG_To_State), sum(Prot_Insp_IG_Local_Govts), 
sum(Public_Welf_Total_Exp), sum(Public_Welf_Direct_Exp), sum(Public_Welf_Cash_Asst), 
sum(Welf_Categ_Total_Exp), sum(Welf_Categ_Cash_Assist), sum(Welf_Categ_IG_To_State), sum(var211), 
sum(Welf_Cash_Total_Exp), sum(Welf_Cash_Cash_Assist), sum(var214), sum(Welf_Vend_Pmts_Medical), sum(Welf_Vend_Pmts_NEC), sum(Welf_State_Share_Part_D), sum(Welf_Ins_Total_Exp), 
sum(Welf_NEC_Total_Expend), sum(Welf_NEC_Direct_Expend), sum(Welf_NEC_IG_To_State), sum(var226), 
sum(Sewerage_Total_Expend), sum(Sewerage_Direct_Expend), sum(Sewerage_IG_To_State), sum(Sewerage_IG_Local_Govts), sum(SW_Mgmt_Total_Expend), sum(SW_Mgmt_Direct_Expend), sum(SW_Mgmt_IG_To_State), sum(SW_Mgmt_IG_Local_Govts), 
sum(Water_Trans_Total_Exp), sum(Water_Trans_Direct_Exp), sum(Water_Trans_IG_To_Sta), sum(Water_Trans_IG_Loc_Govts)
from exp.exp_02_01
group by govidn
order by govidn;
quit;


data expsum_0201; set expsum_02;
rename _TEMG001=TExp;
rename _TEMG002=TIGExp;
rename _TEMG003=DExp;	
rename _TEMG004=TCurrent_Exp;	
rename _TEMG005=TCurrent_Oper;	
rename _TEMG006=TCapital_Outlays;	
rename _TEMG007=TConstruction;		
rename _TEMG008=GeneralExp;	
rename _TEMG009=IG_Exp_St;	
rename _TEMG010=IG_Exp_Local;	
rename _TEMG011=IG_Exp_Fed;	
rename _TEMG012=DGeneral_Exp;	
rename _TEMG013=TAir_Trans;	
rename _TEMG014=DAir_Trans;	
rename _TEMG015=IGAir_Trans_St;
rename _TEMG016=IGAir_Trans_Local;	
rename _TEMG017=TMisc_Com;	
rename _TEMG018=TCorrect;	
rename _TEMG019=DCorrect;	
rename _TEMG020=IGCorrect_St;	
rename _TEMG021=IGCorrect_Loc;	
rename _TEMG022=TEduc;	
rename _TEMG023=DEduc;	
rename _TEMG024=TElem;	
rename _TEMG025=DElem;	
rename _TEMG026=IGElem_St;	
rename _TEMG027=IGElemLoc;	
rename _TEMG028=IGElem_Sch; 
rename _TEMG029=THigherEd;	
rename _TEMG030=DHigherEd;	
rename _TEMG031=IGHigherEd_St;	
rename _TEMG032=IGHigherEd_Loc;	
rename _TEMG033=TEduc_NEC;	
rename _TEMG034=DEduc_NEC;	
rename _TEMG035=IGEduc_NEC_St;	
rename _TEMG036=IGEduc_NEC_Loc;	
rename _TEMG037=DEmp_Sec_Adm;	
rename _TEMG038=TFin_Admin;	
rename _TEMG039=DFin_Admin;	
rename _TEMG040=IGFin_Admin_St;	
rename _TEMG041=IGFin_Admin_Loc;	
rename _TEMG042=TFire;	
rename _TEMG043=DFire;	
rename _TEMG044=IGFire_St;	
rename _TEMG045=IGFire_Loc;	
rename _TEMG046=TJudicial;	
rename _TEMG047=DJudicial;	
rename _TEMG048=IGJudicial_St;	
rename _TEMG049=IGJudicial_Loc;	
rename _TEMG050=TStaff;	
rename _TEMG051=DStaff;	
rename _TEMG052=IGStaff_St;	
rename _TEMG053=IGStaff_Loc;	
rename _TEMG054=TBldg;	
rename _TEMG055=THealth;	
rename _TEMG056=DHealth;	
rename _TEMG057=IGHealth_St;	
rename _TEMG058=IGHealth_Loc;	
rename _TEMG059=THospital;	
rename _TEMG060=DHospital;	
rename _TEMG061=IGHospital_St;	
rename _TEMG062=IGHospital_Loc;	
rename _TEMG063=TOwn_Hospital;	
rename _TEMG064=THosp_Other;	
rename _TEMG065=DHosp_Other;	
rename _TEMG066=IGHosp_Other_St;	
rename _TEMG067=IGHosp_Other_Loc;	
rename _TEMG068=THighways;	
rename _TEMG069=DHighways;	
rename _TEMG070=TRegular_Hwy;	
rename _TEMG071=DRegular_Hwy;	
rename _TEMG072=IGRegular_Hwy_St;	
rename _TEMG073=IGRegular_Hwy_Loc;	
rename _TEMG074=TToll_Hwy; 
rename _TEMG075=TTransit_Sub;	
rename _TEMG076=DTransit_Sub;	
rename _TEMG077=IGTransit_Sub_St;	
rename _TEMG078=IGTransit_Sub_Loc;	
rename _TEMG079=THousCom;	
rename _TEMG080=DHousCom;	
rename _TEMG081=IGHousCom_St;	
rename _TEMG082=IGHousCom_Loc;	
rename _TEMG083=TLib;	
rename _TEMG084=DLib;	
rename _TEMG085=IGLib_St;	
rename _TEMG086=IGLib_Loc;	
rename _TEMG087=TNatural_Res;	
rename _TEMG088=DNatural_Res;	
rename _TEMG089=IGNatural_Res_St;	
rename _TEMG090=IGNatural_Res_Loc;	
rename _TEMG091=TParking;	
rename _TEMG092=DParking;	
rename _TEMG093=IGParking_St;	
rename _TEMG094=IGParking_Loc;	
rename _TEMG095=TParks;	
rename _TEMG096=DParks;	
rename _TEMG097=IGParks_St;	
rename _TEMG098=IGParks_Loc;	
rename _TEMG099=TPolice;	
rename _TEMG100=DPolice;	
rename _TEMG101=IGPolice_St;	
rename _TEMG102=IGPolice_Loc;	
rename _TEMG103=TProt_Insp;	
rename _TEMG104=DProt_Insp;	
rename _TEMG105=IGProt_Insp_St;	
rename _TEMG106=IGProt_Insp_Loc;	
rename _TEMG107=TPublic_Welf;	
rename _TEMG108=DPublic_Welf;	
rename _TEMG109=Public_Welf_Cash_Asst;	
rename _TEMG110=TWelf_Categ;	
rename _TEMG111=Welf_Categ_Cash_Assist;	
rename _TEMG112=IGWelf_Categ_St;	
rename _TEMG113=IGWelf_Categ_Loc;	
rename _TEMG114=TWelf_Cash;	
rename _TEMG115=Welf_Cash_Cash_Assist;	
rename _TEMG116=IGWelf_Cash_Loc;	
rename _TEMG117=Welf_Vend_Pmts_Medical;	
rename _TEMG118=Welf_Vend_Pmts_NEC;	
rename _TEMG119=Welf_State_Share_Part_D;	
rename _TEMG120=TWelf_Ins;	
rename _TEMG121=TWelf_NEC;	
rename _TEMG122=DWelf_NEC;	
rename _TEMG123=IGWelf_NEC_St;	
rename _TEMG124=IGWelf_NEC_Loc; 
rename _TEMG125=TSewerage;	
rename _TEMG126=DSewerage;	
rename _TEMG127=IGSewerage_St;	
rename _TEMG128=IGSewerage_Loc;	
rename _TEMG129=TSW_Mgmt;	
rename _TEMG130=DSW_Mgmt;	
rename _TEMG131=IGSW_Mgmt_St;	
rename _TEMG132=IGSW_Mgmt_Loc;	
rename _TEMG133=TWater_Trans;	
rename _TEMG134=DWater_Trans;	
rename _TEMG135=IGWater_Trans_St;	
rename _TEMG136=IGWater_Trans_Loc;	
Run;

Proc import out = Exp.govid_fips datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\crosswalk_govid_fips_name.xlsx"
DBMS = xlsx replace;
Sheet = "sheet1";
Getnames =yes;
Run;

proc sort data=expsum_0201; by govidn; run;
proc sort data=exp.govid_fips; by govidn; run;

data exp.expsum_0210; 
merge expsum_0201 exp.govid_fips; by govidn; run;



/* FRAGMENTATION DATA - GOV FREQUENCY - 2002 */
/**CREATE # OF GOVERNMENT (EACH TYPE) **/

data type1_02; set exp.exp_02_01; where type_code=1; run;
data type2_02; set exp.exp_02_01; where type_code=2; run;
data type3_02; set exp.exp_02_01; where type_code=3; run;
data type4_02; set exp.exp_02_01; where type_code=4; run;
data type5_02; set exp.exp_02_01; where type_code=5; run;


/** type 1 **/
proc sort data=type1_02; by stn ctn; run;

proc freq data=type1_02;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_11_02;
run;

proc transpose data=ngov_11_02 
out=ngov_12_02
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 2 **/
proc sort data=type2_02; by stn ctn; run;

proc freq data=type2_02;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_21_02;
run;

proc transpose data=ngov_21_02 
out=ngov_22_02
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 3 **/
proc sort data=type3_02; by stn ctn; run;

proc freq data=type3_02;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_31_02;
run;

proc transpose data=ngov_31_02 
out=ngov_32_02
prefix=Count;
var Count;
by stn ctn govidn;
run;


/** type 4 **/
proc sort data=type4_02; by stn ctn; run;

proc freq data=type4_02;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_41_02;
run;

proc transpose data=ngov_41_02 
out=ngov_42_02
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 5 **/
proc sort data=type5_02; by stn ctn; run;

proc freq data=type5_02;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_51_02;
run;

proc transpose data=ngov_51_02 
out=ngov_52_02
prefix=Count;
var Count;
by stn ctn govidn;
run;



/*** Count1 name changed as # gov has variable name "count1" ***/ 
data ngov_22_02; set ngov_22_02; rename count1=count2; run;
data ngov_32_02; set ngov_32_02; rename count1=count3; run;
data ngov_42_02; set ngov_42_02; rename count1=count4; run;
data ngov_52_02; set ngov_52_02; rename count1=count5; run;

proc sort data=ngov_12_02; by govidn; run;
proc sort data=ngov_22_02; by govidn; run;
proc sort data=ngov_32_02; by govidn; run;
proc sort data=ngov_42_02; by govidn; run;
proc sort data=ngov_52_02; by govidn; run;

data exp.ngov_02; 
merge ngov_12_02 ngov_22_02 ngov_32_02 ngov_42_02 ngov_52_02; by govidn; run; /** # gov completed **/

data exp.ngov_02; set exp.ngov_02; 
rename count1=type1; rename count2=type2; rename count3=type3; rename count4=type4; rename count5=type5;
/*rename st=stc; rename ct=ctc;*/ run; /* As it's merged with cross_gov_FIPS_12 data, ct and st are not compatible because it has numeric st and ct while other has character variables */



/* MERGE Ngov_02 (# of gov, gov fips codes) WITH EXP_SUM DATA */
proc sort data= exp.ngov_02; by govidn; run;
proc sort data= exp.expsum_0210; by govidn; run;

data exp.expsum_0211; 
merge exp.ngov_02 exp.expsum_0210; by govidn; run;






/**********************************************************************************************************************************************************************/
/****************************************** 1997 DATA *****************************************************************************************************************/

Proc import out = Exp.exp_97 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\IndFin97_Exp.xlsx"
DBMS = xlsx replace;
Sheet = "IndFin97a";
Getnames =yes;
Run;

data exp.exp_97_01 
(keep=Year4	ID IDChanged State_Code Type_Code County Census_Region FIPS_Code_State	Population 
Total_Expenditure Total_IG_Expenditure Direct_Expenditure Total_Current_Expend Total_Current_Oper Total_Capital_Outlays	Total_Construction 
General_Expenditure	IG_Exp_To_State_Govt IG_Exp_To_Local_Govts IG_Exp_To_Federal_Govt Direct_General_Expend	
Air_Trans_Total_Expend Air_Trans_Direct_Expend Air_Trans_IG_To_State Air_Trans_IG_Local_Govts 
Misc_Com_Activ_Tot_Exp
Correct_Total_Exp Correct_Direct_Exp Correct_IG_To_St Correct_IG_Loc_Govts 
Total_Educ_Total_Exp Total_Educ_Direct_Exp Elem_Educ_Total_Exp Elem_Educ_Direct_Exp Elem_Educ_IG_To_State Elem_Educ_IG_Local_Govts Elem_Educ_IG_Sch_to_Sch
Higher_Ed_Total_Exp	Higher_Ed_Direct_Exp Higher_Ed_IG_To_St	Higher_Ed_IG_Loc_Govts Educ_NEC_Total_Expend Educ_NEC_Direct_Expend Educ_NEC_IG_To_State var91
Emp_Sec_Adm_Direct_Exp Fin_Admin_Total_Exp Fin_Admin_Direct_Exp Fin_Admin_IG_To_State Fin_Admin_IG_Local_Govts 
Fire_Prot_Total_Expend Fire_Prot_Direct_Exp Fire_Prot_IG_To_State Fire_Prot_IG_Local_Govts 
Judicial_Total_Expend Judicial_Direct_Expend Judicial_IG_To_State Judicial_IG_Local_Govts 
Cen_Staff_Total_Expend Cen_Staff_Direct_Exp Cen_Staff_IG_To_State Cen_Staff_IG_Local_Govts Gen_Pub_Bldg_Total_Exp
Health_Total_Expend	Health_Direct_Expend Health_IG_To_State	Health_IG_Local_Govts
Total_Hospital_Total_Exp Total_Hospital_Dir_Exp Total_Hospital_IG_To_State Total_Hospital_IG_Loc_Govts  
Own_Hospital_Total_Exp Hosp_Other_Total_Exp Hosp_Other_Direct_Exp Hosp_Other_IG_To_State var142
Total_Highways_Tot_Exp Total_Highways_Dir_Exp Regular_Hwy_Total_Exp Regular_Hwy_Direct_Exp Regular_Hwy_IG_To_Sta Regular_Hwy_IG_Loc_Govts 
Toll_Hwy_Total_Expend Transit_Sub_Total_Exp Transit_Sub_Direct_Sub Transit_Sub_IG_To_Sta Transit_Sub_IG_Loc_Govts 
Hous___Com_Total_Exp Hous___Com_Direct_Exp Hous___Com_IG_To_State var166
Libraries_Total_Expend Libraries_Direct_Exp	Libraries_IG_To_State Libraries_IG_Local_Govts
Natural_Res_Total_Exp Natural_Res_Direct_Exp Natural_Res_IG_To_Sta Natural_Res_IG_Loc_Govts 
Parking_Total_Expend Parking_Direct_Expend Parking_IG_To_State Parking_IG_Local_Govts
Parks___Rec_Total_Exp Parks___Rec_Direct_Exp Parks___Rec_IG_To_Sta var190	
Police_Prot_Total_Exp Police_Prot_Direct_Exp Police_Prot_IG_To_Sta Police_Prot_IG_Loc_Govts 
Prot_Insp_Total_Exp Prot_Insp_Direct_Exp Prot_Insp_IG_To_State Prot_Insp_IG_Local_Govts 
Public_Welf_Total_Exp Public_Welf_Direct_Exp Public_Welf_Cash_Asst 
Welf_Categ_Total_Exp Welf_Categ_Cash_Assist Welf_Categ_IG_To_State var211 
Welf_Cash_Total_Exp Welf_Cash_Cash_Assist var214 
Welf_Vend_Pmts_Medical Welf_Vend_Pmts_NEC Welf_State_Share_Part_D Welf_Ins_Total_Exp 
Welf_NEC_Total_Expend Welf_NEC_Direct_Expend Welf_NEC_IG_To_State var226 
Sewerage_Total_Expend Sewerage_Direct_Expend Sewerage_IG_To_State Sewerage_IG_Local_Govts 
SW_Mgmt_Total_Expend SW_Mgmt_Direct_Expend SW_Mgmt_IG_To_State SW_Mgmt_IG_Local_Govts 
Water_Trans_Total_Exp Water_Trans_Direct_Exp Water_Trans_IG_To_Sta Water_Trans_IG_Loc_Govts);	
Set exp.exp_97; run;

/* Create Govid */
data exp.exp_97_01; set exp.exp_97_01; rename state_code=stn; rename county=ctn; run;
data exp.exp_97_01; set exp.exp_97_01; govidn=(stn*1000)+ctn; run;


/*SUM OF SPENDING BY CATEGORY*/
proc sql;
create table expsum_97 as 
select govidn, sum(Total_Expenditure), sum(Total_IG_Expenditure), sum(Direct_Expenditure), sum(Total_Current_Expend), sum(Total_Current_Oper), sum(Total_Capital_Outlays), sum(Total_Construction),
sum(General_Expenditure), sum(IG_Exp_To_State_Govt), sum(IG_Exp_To_Local_Govts), sum(IG_Exp_To_Federal_Govt), sum(Direct_General_Expend), 
sum(Air_Trans_Total_Expend), sum(Air_Trans_Direct_Expend), sum(Air_Trans_IG_To_State), sum(Air_Trans_IG_Local_Govts), 
sum(Misc_Com_Activ_Tot_Exp), 
sum(Correct_Total_Exp), sum(Correct_Direct_Exp), sum(Correct_IG_To_St), sum(Correct_IG_Loc_Govts), 
sum(Total_Educ_Total_Exp), sum(Total_Educ_Direct_Exp), 
sum(Elem_Educ_Total_Exp), sum(Elem_Educ_Direct_Exp), sum(Elem_Educ_IG_To_State), sum(Elem_Educ_IG_Local_Govts), sum(Elem_Educ_IG_Sch_to_Sch), 
sum(Higher_Ed_Total_Exp), sum(Higher_Ed_Direct_Exp), sum(Higher_Ed_IG_To_St), sum(Higher_Ed_IG_Loc_Govts), 
sum(Educ_NEC_Total_Expend), sum(Educ_NEC_Direct_Expend), sum(Educ_NEC_IG_To_State), sum(var91), 
sum(Emp_Sec_Adm_Direct_Exp), sum(Fin_Admin_Total_Exp), sum(Fin_Admin_Direct_Exp), sum(Fin_Admin_IG_To_State), sum(Fin_Admin_IG_Local_Govts), 
sum(Fire_Prot_Total_Expend), sum(Fire_Prot_Direct_Exp), sum(Fire_Prot_IG_To_State), sum(Fire_Prot_IG_Local_Govts), 
sum(Judicial_Total_Expend), sum(Judicial_Direct_Expend), sum(Judicial_IG_To_State), sum(Judicial_IG_Local_Govts), 
sum(Cen_Staff_Total_Expend), sum(Cen_Staff_Direct_Exp), sum(Cen_Staff_IG_To_State), sum(Cen_Staff_IG_Local_Govts), sum(Gen_Pub_Bldg_Total_Exp), 
sum(Health_Total_Expend), sum(Health_Direct_Expend), sum(Health_IG_To_State), sum(Health_IG_Local_Govts), 
sum(Total_Hospital_Total_Exp), sum(Total_Hospital_Dir_Exp), sum(Total_Hospital_IG_To_State), sum(Total_Hospital_IG_Loc_Govts), 
sum(Own_Hospital_Total_Exp), sum(Hosp_Other_Total_Exp), sum(Hosp_Other_Direct_Exp), sum(Hosp_Other_IG_To_State), sum(var142), 
sum(Total_Highways_Tot_Exp), sum(Total_Highways_Dir_Exp), sum(Regular_Hwy_Total_Exp), sum(Regular_Hwy_Direct_Exp), sum(Regular_Hwy_IG_To_Sta), sum(Regular_Hwy_IG_Loc_Govts), 
sum(Toll_Hwy_Total_Expend), sum(Transit_Sub_Total_Exp), sum(Transit_Sub_Direct_Sub), sum(Transit_Sub_IG_To_Sta), sum(Transit_Sub_IG_Loc_Govts), 
sum(Hous___Com_Total_Exp), sum(Hous___Com_Direct_Exp), sum(Hous___Com_IG_To_State), sum(var166), 
sum(Libraries_Total_Expend), sum(Libraries_Direct_Exp), sum(Libraries_IG_To_State), sum(Libraries_IG_Local_Govts), 
sum(Natural_Res_Total_Exp), sum(Natural_Res_Direct_Exp), sum(Natural_Res_IG_To_Sta), sum(Natural_Res_IG_Loc_Govts), 
sum(Parking_Total_Expend), sum(Parking_Direct_Expend), sum(Parking_IG_To_State), sum(Parking_IG_Local_Govts), 
sum(Parks___Rec_Total_Exp), sum(Parks___Rec_Direct_Exp), sum(Parks___Rec_IG_To_Sta), sum(var190), 
sum(Police_Prot_Total_Exp), sum(Police_Prot_Direct_Exp), sum(Police_Prot_IG_To_Sta), sum(Police_Prot_IG_Loc_Govts), 
sum(Prot_Insp_Total_Exp), sum(Prot_Insp_Direct_Exp), sum(Prot_Insp_IG_To_State), sum(Prot_Insp_IG_Local_Govts), 
sum(Public_Welf_Total_Exp), sum(Public_Welf_Direct_Exp), sum(Public_Welf_Cash_Asst), 
sum(Welf_Categ_Total_Exp), sum(Welf_Categ_Cash_Assist), sum(Welf_Categ_IG_To_State), sum(var211), 
sum(Welf_Cash_Total_Exp), sum(Welf_Cash_Cash_Assist), sum(var214), sum(Welf_Vend_Pmts_Medical), sum(Welf_Vend_Pmts_NEC), sum(Welf_State_Share_Part_D), sum(Welf_Ins_Total_Exp), 
sum(Welf_NEC_Total_Expend), sum(Welf_NEC_Direct_Expend), sum(Welf_NEC_IG_To_State), sum(var226), 
sum(Sewerage_Total_Expend), sum(Sewerage_Direct_Expend), sum(Sewerage_IG_To_State), sum(Sewerage_IG_Local_Govts), sum(SW_Mgmt_Total_Expend), sum(SW_Mgmt_Direct_Expend), sum(SW_Mgmt_IG_To_State), sum(SW_Mgmt_IG_Local_Govts), 
sum(Water_Trans_Total_Exp), sum(Water_Trans_Direct_Exp), sum(Water_Trans_IG_To_Sta), sum(Water_Trans_IG_Loc_Govts)
from exp.exp_97_01
group by govidn
order by govidn;
quit;


data expsum_9701; set expsum_97;
rename _TEMG001=TExp;
rename _TEMG002=TIGExp;
rename _TEMG003=DExp;	
rename _TEMG004=TCurrent_Exp;	
rename _TEMG005=TCurrent_Oper;	
rename _TEMG006=TCapital_Outlays;	
rename _TEMG007=TConstruction;		
rename _TEMG008=GeneralExp;	
rename _TEMG009=IG_Exp_St;	
rename _TEMG010=IG_Exp_Local;	
rename _TEMG011=IG_Exp_Fed;	
rename _TEMG012=DGeneral_Exp;	
rename _TEMG013=TAir_Trans;	
rename _TEMG014=DAir_Trans;	
rename _TEMG015=IGAir_Trans_St;
rename _TEMG016=IGAir_Trans_Local;	
rename _TEMG017=TMisc_Com;	
rename _TEMG018=TCorrect;	
rename _TEMG019=DCorrect;	
rename _TEMG020=IGCorrect_St;	
rename _TEMG021=IGCorrect_Loc;	
rename _TEMG022=TEduc;	
rename _TEMG023=DEduc;	
rename _TEMG024=TElem;	
rename _TEMG025=DElem;	
rename _TEMG026=IGElem_St;	
rename _TEMG027=IGElemLoc;	
rename _TEMG028=IGElem_Sch; 
rename _TEMG029=THigherEd;	
rename _TEMG030=DHigherEd;	
rename _TEMG031=IGHigherEd_St;	
rename _TEMG032=IGHigherEd_Loc;	
rename _TEMG033=TEduc_NEC;	
rename _TEMG034=DEduc_NEC;	
rename _TEMG035=IGEduc_NEC_St;	
rename _TEMG036=IGEduc_NEC_Loc;	
rename _TEMG037=DEmp_Sec_Adm;	
rename _TEMG038=TFin_Admin;	
rename _TEMG039=DFin_Admin;	
rename _TEMG040=IGFin_Admin_St;	
rename _TEMG041=IGFin_Admin_Loc;	
rename _TEMG042=TFire;	
rename _TEMG043=DFire;	
rename _TEMG044=IGFire_St;	
rename _TEMG045=IGFire_Loc;	
rename _TEMG046=TJudicial;	
rename _TEMG047=DJudicial;	
rename _TEMG048=IGJudicial_St;	
rename _TEMG049=IGJudicial_Loc;	
rename _TEMG050=TStaff;	
rename _TEMG051=DStaff;	
rename _TEMG052=IGStaff_St;	
rename _TEMG053=IGStaff_Loc;	
rename _TEMG054=TBldg;	
rename _TEMG055=THealth;	
rename _TEMG056=DHealth;	
rename _TEMG057=IGHealth_St;	
rename _TEMG058=IGHealth_Loc;	
rename _TEMG059=THospital;	
rename _TEMG060=DHospital;	
rename _TEMG061=IGHospital_St;	
rename _TEMG062=IGHospital_Loc;	
rename _TEMG063=TOwn_Hospital;	
rename _TEMG064=THosp_Other;	
rename _TEMG065=DHosp_Other;	
rename _TEMG066=IGHosp_Other_St;	
rename _TEMG067=IGHosp_Other_Loc;	
rename _TEMG068=THighways;	
rename _TEMG069=DHighways;	
rename _TEMG070=TRegular_Hwy;	
rename _TEMG071=DRegular_Hwy;	
rename _TEMG072=IGRegular_Hwy_St;	
rename _TEMG073=IGRegular_Hwy_Loc;	
rename _TEMG074=TToll_Hwy; 
rename _TEMG075=TTransit_Sub;	
rename _TEMG076=DTransit_Sub;	
rename _TEMG077=IGTransit_Sub_St;	
rename _TEMG078=IGTransit_Sub_Loc;	
rename _TEMG079=THousCom;	
rename _TEMG080=DHousCom;	
rename _TEMG081=IGHousCom_St;	
rename _TEMG082=IGHousCom_Loc;	
rename _TEMG083=TLib;	
rename _TEMG084=DLib;	
rename _TEMG085=IGLib_St;	
rename _TEMG086=IGLib_Loc;	
rename _TEMG087=TNatural_Res;	
rename _TEMG088=DNatural_Res;	
rename _TEMG089=IGNatural_Res_St;	
rename _TEMG090=IGNatural_Res_Loc;	
rename _TEMG091=TParking;	
rename _TEMG092=DParking;	
rename _TEMG093=IGParking_St;	
rename _TEMG094=IGParking_Loc;	
rename _TEMG095=TParks;	
rename _TEMG096=DParks;	
rename _TEMG097=IGParks_St;	
rename _TEMG098=IGParks_Loc;	
rename _TEMG099=TPolice;	
rename _TEMG100=DPolice;	
rename _TEMG101=IGPolice_St;	
rename _TEMG102=IGPolice_Loc;	
rename _TEMG103=TProt_Insp;	
rename _TEMG104=DProt_Insp;	
rename _TEMG105=IGProt_Insp_St;	
rename _TEMG106=IGProt_Insp_Loc;	
rename _TEMG107=TPublic_Welf;	
rename _TEMG108=DPublic_Welf;	
rename _TEMG109=Public_Welf_Cash_Asst;	
rename _TEMG110=TWelf_Categ;	
rename _TEMG111=Welf_Categ_Cash_Assist;	
rename _TEMG112=IGWelf_Categ_St;	
rename _TEMG113=IGWelf_Categ_Loc;	
rename _TEMG114=TWelf_Cash;	
rename _TEMG115=Welf_Cash_Cash_Assist;	
rename _TEMG116=IGWelf_Cash_Loc;	
rename _TEMG117=Welf_Vend_Pmts_Medical;	
rename _TEMG118=Welf_Vend_Pmts_NEC;	
rename _TEMG119=Welf_State_Share_Part_D;	
rename _TEMG120=TWelf_Ins;	
rename _TEMG121=TWelf_NEC;	
rename _TEMG122=DWelf_NEC;	
rename _TEMG123=IGWelf_NEC_St;	
rename _TEMG124=IGWelf_NEC_Loc; 
rename _TEMG125=TSewerage;	
rename _TEMG126=DSewerage;	
rename _TEMG127=IGSewerage_St;	
rename _TEMG128=IGSewerage_Loc;	
rename _TEMG129=TSW_Mgmt;	
rename _TEMG130=DSW_Mgmt;	
rename _TEMG131=IGSW_Mgmt_St;	
rename _TEMG132=IGSW_Mgmt_Loc;	
rename _TEMG133=TWater_Trans;	
rename _TEMG134=DWater_Trans;	
rename _TEMG135=IGWater_Trans_St;	
rename _TEMG136=IGWater_Trans_Loc;	
Run;

Proc import out = Exp.govid_fips datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\crosswalk_govid_fips_name.xlsx"
DBMS = xlsx replace;
Sheet = "sheet1";
Getnames =yes;
Run;

proc sort data=expsum_9701; by govidn; run;
proc sort data=exp.govid_fips; by govidn; run;

data exp.expsum_9710; 
merge expsum_9701 exp.govid_fips; by govidn; run;



/* FRAGMENTATION DATA - GOV FREQUENCY - 1997 */
/**CREATE # OF GOVERNMENT (EACH TYPE) **/

data type1_97; set exp.exp_97_01; where type_code=1; run;
data type2_97; set exp.exp_97_01; where type_code=2; run;
data type3_97; set exp.exp_97_01; where type_code=3; run;
data type4_97; set exp.exp_97_01; where type_code=4; run;
data type5_97; set exp.exp_97_01; where type_code=5; run;


/** type 1 **/
proc sort data=type1_97; by stn ctn; run;

proc freq data=type1_97;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_11_97;
run;

proc transpose data=ngov_11_97 
out=ngov_12_97
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 2 **/
proc sort data=type2_97; by stn ctn; run;

proc freq data=type2_97;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_21_97;
run;

proc transpose data=ngov_21_97 
out=ngov_22_97
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 3 **/
proc sort data=type3_97; by stn ctn; run;

proc freq data=type3_97;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_31_97;
run;

proc transpose data=ngov_31_97 
out=ngov_32_97
prefix=Count;
var Count;
by stn ctn govidn;
run;


/** type 4 **/
proc sort data=type4_97; by stn ctn; run;

proc freq data=type4_97;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_41_97;
run;

proc transpose data=ngov_41_97 
out=ngov_42_97
prefix=Count;
var Count;
by stn ctn govidn;
run;

/** type 5 **/
proc sort data=type5_97; by stn ctn; run;

proc freq data=type5_97;
   by stn ctn govidn;
   tables stn ctn govidn type_code/out = ngov_51_97;
run;

proc transpose data=ngov_51_97 
out=ngov_52_97
prefix=Count;
var Count;
by stn ctn govidn;
run;



/*** Count1 name changed as # gov has variable name "count1" ***/ 
data ngov_22_97; set ngov_22_97; rename count1=count2; run;
data ngov_32_97; set ngov_32_97; rename count1=count3; run;
data ngov_42_97; set ngov_42_97; rename count1=count4; run;
data ngov_52_97; set ngov_52_97; rename count1=count5; run;

proc sort data=ngov_12_97; by govidn; run;
proc sort data=ngov_22_97; by govidn; run;
proc sort data=ngov_32_97; by govidn; run;
proc sort data=ngov_42_97; by govidn; run;
proc sort data=ngov_52_97; by govidn; run;

data exp.ngov_97; 
merge ngov_12_97 ngov_22_97 ngov_32_97 ngov_42_97 ngov_52_97; by govidn; run; /** # gov completed **/

data exp.ngov_97; set exp.ngov_97; 
rename count1=type1; rename count2=type2; rename count3=type3; rename count4=type4; rename count5=type5;
/*rename st=stc; rename ct=ctc;*/ run; /* As it's merged with cross_gov_FIPS_12 data, ct and st are not compatible because it has numeric st and ct while other has character variables */


/* MERGE Ngov_07 (# of gov, gov fips codes) WITH EXP_SUM DATA */
proc sort data= exp.ngov_97; by govidn; run;
proc sort data= exp.expsum_9710; by govidn; run;

data exp.expsum_9711; 
merge exp.ngov_97 exp.expsum_9710; by govidn; run;



/*************** POPULATION DATA ********************/

data pop_1201; set exp.exp_12_01; where type_code=1; run; 
data pop_0701; set exp.exp_07_01; where type_code=1; run; 
data pop_0201; set exp.exp_02_01; where type_code=1; run; 
data pop_9701; set exp.exp_97_01; where type_code=1; run; 

data pop_1202 (keep=Year4 stn ctn Type_code name Population); set pop_1201; run;
data pop_0702 (keep=Year4 stn ctn Type_code name Population); set pop_0701; run;
data pop_0202 (keep=Year4 stn ctn Type_code name Population); set pop_0201; run;
data pop_9702 (keep=Year4 stn ctn Type_code name Population); set pop_9701; run;

data pop_1202 ; set pop_1202; govidn=(stn*1000)+ctn; run;
data pop_0702 ; set pop_0702; govidn=(stn*1000)+ctn; run;
data pop_0202 ; set pop_0202; govidn=(stn*1000)+ctn; run;
data pop_9702 ; set pop_9702; govidn=(stn*1000)+ctn; run;

proc sort data=pop_1202; by govidn; run;
proc sort data=pop_0702; by govidn; run;
proc sort data=pop_0202; by govidn; run;
proc sort data=pop_9702; by govidn; run;

proc sort data=exp.expsum_1211; by govidn; run;
proc sort data=exp.expsum_0711; by govidn; run;
proc sort data=exp.expsum_0211; by govidn; run;
proc sort data=exp.expsum_9711; by govidn; run;

data expsum_1215; merge exp.expsum_1211 pop_1202; by govidn; run;
data expsum_0715; merge exp.expsum_0711 pop_0702; by govidn; run;
data expsum_0215; merge exp.expsum_0211 pop_0202; by govidn; run;
data expsum_9715; merge exp.expsum_9711 pop_9702; by govidn; run;
 

/*************** MHI ********************/

/* IMPORT INCOME DATA */
Proc import out = Exp.MHI_97 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_1997";
Getnames =yes;
Run;

Proc import out = Exp.MHI_02 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_2002";
Getnames =yes;
Run;

Proc import out = Exp.MHI_07 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_2007";
Getnames =yes;
Run;

Proc import out = Exp.MHI_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\Median_Household_Income_97-12.xlsx"
DBMS = xlsx replace;
Sheet = "MHI_2012";
Getnames =yes;
Run;

/** Create numeric fips code **/
data mhi_12; set exp.mhi_12; fipsn=fipsstr*1000+fipsctyr*1;run;
data mhi_07; set exp.mhi_07; fipsn=fipsstr*1000+fipsctyr*1;run;
data mhi_02; set exp.mhi_02; fipsn=stn*1000+ctn*1;run;
data mhi_97; set exp.mhi_97; fipsn=stn*1000+ctn*1;run;

data mhi_12; set mhi_12; mhin=mhi*1; run;
data mhi_12; set mhi_12; drop mhi; run;
data mhi_12; set mhi_12; rename mhin=mhi; run;

data mhi_02; set mhi_02; mhin=mhi*1; run;
data mhi_02; set mhi_02; drop mhi; run;
data mhi_02; set mhi_02; rename mhin=mhi; run;

data mhi_1201 (keep=fipsn mhi) ; set mhi_12; run;
data mhi_0701 (keep=fipsn mhi) ; set mhi_07; run;
data mhi_0201 (keep=fipsn mhi) ; set mhi_02; run;
data mhi_9701 (keep=fipsn mhi) ; set mhi_97; run;

proc sort data=exp.govid_fips; by fipsn; run;
proc sort data=mhi_1201; by fipsn; run;
proc sort data=mhi_0701; by fipsn; run;
proc sort data=mhi_0201; by fipsn; run;
proc sort data=mhi_9701; by fipsn; run;

data mhi_1202; merge mhi_1201 exp.govid_fips; by fipsn; run;
data mhi_0702; merge mhi_0701 exp.govid_fips; by fipsn; run;
data mhi_0202; merge mhi_0201 exp.govid_fips; by fipsn; run;
data mhi_9702; merge mhi_9701 exp.govid_fips; by fipsn; run;


/** Merge income into exp data **/
proc sort data=expsum_1215; by fipsn; run;
proc sort data=expsum_0715; by fipsn; run;
proc sort data=expsum_0215; by fipsn; run;
proc sort data=expsum_9715; by fipsn; run;

proc sort data=mhi_1202; by fipsn; run;
proc sort data=mhi_0702; by fipsn; run;
proc sort data=mhi_0202; by fipsn; run;
proc sort data=mhi_9702; by fipsn; run;

data expsum_1220; merge expsum_1215 mhi_1202; by fipsn; run;
data expsum_0720; merge expsum_0715 mhi_0702; by fipsn; run;
data expsum_0220; merge expsum_0215 mhi_0202; by fipsn; run;
data expsum_9720; merge expsum_9715 mhi_9702; by fipsn; run;


/*************** MHI (1997-2012) COMPLETED ******************/


/*************** POVERTY (1997-2012) ******************/

Proc import out = Exp.pov_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\pov_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "pov_12";
Getnames =yes;
Run;

Proc import out = Exp.pov_07 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\pov_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "pov_07";
Getnames =yes;
Run;

Proc import out = Exp.pov_02 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\pov_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "pov_02";
Getnames =yes;
Run;

Proc import out = Exp.pov_97 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\pov_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "pov_97";
Getnames =yes;
Run;

data pov_12; set exp.pov_12; fipsn=fipsstr*1000+fipsctyr*1;run;
data pov_07; set exp.pov_07; fipsn=fipsstr*1000+fipsctyr*1;run;
data pov_02; set exp.pov_02; fipsn=stn*1000+ctn*1;run;
data pov_97; set exp.pov_97; fipsn=stn*1000+ctn*1;run;

/* As vars only in pov_12 are character, it needs to be converted to numeric */
data pov_12; set pov_12; pov_estn=pov_est*1; run;
data pov_12; set pov_12; drop pov_est; run;
data pov_12; set pov_12; rename pov_estn = pov_est; run;
data pov_12; set pov_12; povrn=povr*1; run;
data pov_12; set pov_12; drop povr; run;
data pov_12; set pov_12; rename povrn = povr; run;
data pov_12; set pov_12; pov_est_18n=pov_est_18*1; run;
data pov_12; set pov_12; drop pov_est_18; run;
data pov_12; set pov_12; rename pov_est_18n = pov_est_18; run;
data pov_12; set pov_12; povr_18n=povr_18*1; run;
data pov_12; set pov_12; drop pov_18; run;
data pov_12; set pov_12; rename pov_18n = pov_18; run;

data pov_1201 (keep=fipsn pov pov_est povr pov_est_18 porv_18) ; set pov_12; run;
data pov_0701 (keep=fipsn pov pov_est povr pov_est_18 porv_18) ; set pov_07; run;
data pov_0201 (keep=fipsn pov pov_est povr pov_est_18 porv_18) ; set pov_02; run;
data pov_9701 (keep=fipsn pov pov_est povr pov_est_18 porv_18) ; set pov_97; run;

/** Merge pov into exp data **/
proc sort data=expsum_1220; by fipsn; run;
proc sort data=expsum_0720; by fipsn; run;
proc sort data=expsum_0220; by fipsn; run;
proc sort data=expsum_9720; by fipsn; run;

proc sort data=pov_1201; by fipsn; run;
proc sort data=pov_0701; by fipsn; run;
proc sort data=pov_0201; by fipsn; run;
proc sort data=pov_9701; by fipsn; run;

data expsum_1225; merge expsum_1220 pov_1201; by fipsn; run;
data expsum_0725; merge expsum_0720 pov_0701; by fipsn; run;
data expsum_0225; merge expsum_0220 pov_0201; by fipsn; run;
data expsum_9725; merge expsum_9720 pov_9701; by fipsn; run;


/*************** POVERTY (1997-2012) COMPLETED ******************/


/*************** UNEMPLOYMENT RATE (1997-2012) ******************/


Proc import out = Exp.unemp_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\unempr_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "unempr_12";
Getnames =yes;
Run;

Proc import out = Exp.unemp_07 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\unempr_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "unempr_07";
Getnames =yes;
Run;

Proc import out = Exp.unemp_02 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\unempr_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "unempr_02";
Getnames =yes;
Run;

Proc import out = Exp.unemp_97 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\unempr_97_12.xlsx"
DBMS = xlsx replace;
Sheet = "unempr_97";
Getnames =yes;
Run;


data unemp_12; set exp.unemp_12; fipsn=fipsstr*1000+fipsctyr*1;run;
data unemp_07; set exp.unemp_07; fipsn=fipsstr*1000+fipsctyr*1;run;
data unemp_02; set exp.unemp_02; fipsn=fipsstr*1000+fipsctyr*1;run;
data unemp_97; set exp.unemp_97; fipsn=fipsstr*1000+fipsctyr*1;run;

data unemp_1201 (keep=fipsn name_unemp year_unemp lf emp unemp unempr) ; set unemp_12; run;
data unemp_0701 (keep=fipsn name_unemp year_unemp lf emp unemp unempr) ; set unemp_07; run;
data unemp_0201 (keep=fipsn name_unemp year_unemp lf emp unemp unempr) ; set unemp_02; run;
data unemp_9701 (keep=fipsn name_unemp year_unemp lf emp unemp unempr) ; set unemp_97; run;

/** Merge unemp into exp data **/
proc sort data=expsum_1220; by fipsn; run;
proc sort data=expsum_0720; by fipsn; run;
proc sort data=expsum_0220; by fipsn; run;
proc sort data=expsum_9720; by fipsn; run;

proc sort data=unemp_1201; by fipsn; run;
proc sort data=unemp_0701; by fipsn; run;
proc sort data=unemp_0201; by fipsn; run;
proc sort data=unemp_9701; by fipsn; run;

data expsum_1227; merge expsum_1225 unemp_1201; by fipsn; run;
data expsum_0727; merge expsum_0725 unemp_0701; by fipsn; run;
data expsum_0227; merge expsum_0225 unemp_0201; by fipsn; run;
data expsum_9727; merge expsum_9725 unemp_9701; by fipsn; run;


/*************** UNEMPLOYMENT RATE (1997-2012) COMPLETED ******************/

/*************** DENSITY (2012)********************************************/

Proc import out = Exp.density_12 datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\density_12.xlsx"
DBMS = xlsx replace;
Sheet = "sheet1";
Getnames =yes;
Run;

proc sort data=expsum_1227; by fipsn; run;
proc sort data=expsum_0727; by fipsn; run;
proc sort data=expsum_0227; by fipsn; run;
proc sort data=expsum_9727; by fipsn; run;
proc sort data=exp.density_12; by fipsn; run;

data expsum_1228; merge expsum_1227 exp.density_12; by fipsn; run; /** merging by fips codes unlike other merging process with govidn as density has only fips codes **/
data expsum_0728; merge expsum_0727 exp.density_12; by fipsn; run; 
data expsum_0228; merge expsum_0227 exp.density_12; by fipsn; run; 
data expsum_9728; merge expsum_9727 exp.density_12; by fipsn; run; 

/*************** DENSITY (2012) - COMPLETED - 11/19/15 **********************************/

data expsum_1228; set expsum_1228; if type1=. then type1=0; run;
data expsum_1228; set expsum_1228; if type2=. then type2=0; run;
data expsum_1228; set expsum_1228; if type3=. then type3=0; run;
data expsum_1228; set expsum_1228; if type4=. then type4=0; run;
data expsum_1228; set expsum_1228; if type5=. then type5=0; run;

data expsum_0728; set expsum_0728; if type1=. then type1=0; run;
data expsum_0728; set expsum_0728; if type2=. then type2=0; run;
data expsum_0728; set expsum_0728; if type3=. then type3=0; run;
data expsum_0728; set expsum_0728; if type4=. then type4=0; run;
data expsum_0728; set expsum_0728; if type5=. then type5=0; run;

data expsum_0228; set expsum_0228; if type1=. then type1=0; run;
data expsum_0228; set expsum_0228; if type2=. then type2=0; run;
data expsum_0228; set expsum_0228; if type3=. then type3=0; run;
data expsum_0228; set expsum_0228; if type4=. then type4=0; run;
data expsum_0228; set expsum_0228; if type5=. then type5=0; run;

data expsum_9728; set expsum_9728; if type1=. then type1=0; run;
data expsum_9728; set expsum_9728; if type2=. then type2=0; run;
data expsum_9728; set expsum_9728; if type3=. then type3=0; run;
data expsum_9728; set expsum_9728; if type4=. then type4=0; run;
data expsum_9728; set expsum_9728; if type5=. then type5=0; run;

data expsum_1228; set expsum_1228; govall=type1+type2+type3+type4+type5; run;
data expsum_1228; set expsum_1228; genall=type1+type2+type3; run;
data expsum_1228; set expsum_1228; speall=type4+type5; run;

data expsum_0728; set expsum_0728; govall=type1+type2+type3+type4+type5; run;
data expsum_0728; set expsum_0728; genall=type1+type2+type3; run;
data expsum_0728; set expsum_0728; speall=type4+type5; run;

data expsum_0228; set expsum_0228; govall=type1+type2+type3+type4+type5; run;
data expsum_0228; set expsum_0228; genall=type1+type2+type3; run;
data expsum_0228; set expsum_0228; speall=type4+type5; run;

data expsum_9728; set expsum_9728; govall=type1+type2+type3+type4+type5; run;
data expsum_9728; set expsum_9728; genall=type1+type2+type3; run;
data expsum_9728; set expsum_9728; speall=type4+type5; run;

data expsum_1228; set expsum_1228; frag=govall/population*1000; run;
data expsum_1228; set expsum_1228; fraggen=genall/population*1000; run;
data expsum_1228; set expsum_1228; fragspe=speall/population*1000; run;
data expsum_1228; set expsum_1228; fragsch=type5/population*1000; run;

data expsum_0728; set expsum_0728; frag=govall/population*1000; run;
data expsum_0728; set expsum_0728; fraggen=genall/population*1000; run;
data expsum_0728; set expsum_0728; fragspe=speall/population*1000; run;
data expsum_0728; set expsum_0728; fragsch=type5/population*1000; run;

data expsum_0228; set expsum_0228; frag=govall/population*1000; run;
data expsum_0228; set expsum_0228; fraggen=genall/population*1000; run;
data expsum_0228; set expsum_0228; fragspe=speall/population*1000; run;
data expsum_0228; set expsum_0228; fragsch=type5/population*1000; run;

data expsum_9728; set expsum_9728; frag=govall/population*1000; run;
data expsum_9728; set expsum_9728; fraggen=genall/population*1000; run;
data expsum_9728; set expsum_9728; fragspe=speall/population*1000; run;
data expsum_9728; set expsum_9728; fragsch=type5/population*1000; run;

/*** Converted to Real price - test ****/
data exp.expsum_1230; set expsum_1228; rtexp=texp/1; rdexp=dexp/1; rthealth=thealth/1; rmhi=mhi/1; rtexp_cap=rtexp/population; rthealth_cap=rthealth/population; run;
data exp.expsum_0730; set expsum_0728; rtexp=texp/0.903; rdexp=dexp/0.903; rthealth=thealth/0.903; rmhi=mhi/0.903; rtexp_cap=rtexp/population; rthealth_cap=rthealth/population; run;
data exp.expsum_0230; set expsum_0228; rtexp=texp/0.783; rdexp=dexp/0.783; rthealth=thealth/0.783; rmhi=mhi/0.783; rtexp_cap=rtexp/population; rthealth_cap=rthealth/population; run;
data exp.expsum_9730; set expsum_9728; rtexp=texp/0.701; rdexp=dexp/0.701; rthealth=thealth/0.701; rmhi=mhi/0.701; rtexp_cap=rtexp/population; rthealth_cap=rthealth/population; run;


/*************** POP and Pct by race 12/02/15 *********************************************************/


Proc format library = library;

Value datayear;
Value state;
Value $st;
Value $ct;
Value $fips;
Value regist;
Value $race;
/* '1'='white'
'2'='black'
'3'='other';*/
Value origin;
Value sex;
value age;
Value pop;
Run;

Data exp.pop;
INFILE 'C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\pop\pop_1969_2012_All.txt'; 
Attrib datayear length=4 format=datayear. 
   Label = 'data year'
       state length=3 format=state.
   Label = 'state'
       st length=$2 format=$st.
   Label = 'st'
       ct length=$3 format=$ct.
   Label = 'ct'
       fips length=$3 format=$fips.
   Label = 'fips'
       regist length=8 format=regist.
   Label = 'registry'
       race length=$82 format=$race.
   Label = 'race'
       origin length=8 format=origin.
   Label = 'origin'
       sex length=5 format=sex.
   Label = 'sex'
       age length=8 format=age.
   Label = 'age'
       pop length=8 format=pop.
   Label = 'pop'
	   ;
Input
/* input enters the values of each variables. without it, the cells are blank */

year   1-4
state $5-6
st     $7-8
ct    $9-11
fips $7-11
regist 12-13
race   $14
origin 15
sex    16
age    17-18
pop    19-26
;
Run;


data pop_97; set exp.pop; where year=1997; run; 
data pop_02; set exp.pop; where year=2002; run; 
data pop_07; set exp.pop; where year=2007; run; 
data pop_12; set exp.pop; where year=2012; run; 

data pop_9701; set pop_97; fipsn=st*1000+ct*1; run;
data pop_0201; set pop_02; fipsn=st*1000+ct*1; run;
data pop_0701; set pop_07; fipsn=st*1000+ct*1; run;
data pop_1201; set pop_12; fipsn=st*1000+ct*1; run;

/* white*/
data pop_97w; set pop_9701; if race=1; run; 
data pop_02w; set pop_0201; if race=1; run; 
data pop_07w; set pop_0701; if race=1; run; 
data pop_12w; set pop_1201; if race=1; run; 

/* black*/
data pop_97b; set pop_9701; if race=2; run; 
data pop_02b; set pop_0201; if race=2; run; 
data pop_07b; set pop_0701; if race=2; run; 
data pop_12b; set pop_1201; if race=2; run; 

/* other*/
data pop_97o; set pop_9701; if race=3; run; 
data pop_02o; set pop_0201; if race=3; run; 
data pop_07o; set pop_0701; if race=3; run; 
data pop_12o; set pop_1201; if race=3; run; 

/* 1997 sum*/
proc sql;
create table pop_97w_02 as 
select fipsn, sum(pop)
from pop_97w
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_97b_02 as 
select fipsn, sum(pop)
from pop_97b
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_97o_02 as 
select fipsn, sum(pop)
from pop_97o
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_97t as 
select fipsn, sum(pop)
from pop_9701
group by fipsn
order by fipsn;
quit;


/* 2002 sum*/
proc sql;
create table pop_02w_02 as 
select fipsn, sum(pop)
from pop_02w
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_02b_02 as 
select fipsn, sum(pop)
from pop_02b
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_02o_02 as 
select fipsn, sum(pop)
from pop_02o
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_02t as 
select fipsn, sum(pop)
from pop_0201
group by fipsn
order by fipsn;
quit;

/* 2007 sum*/
proc sql;
create table pop_07w_02 as 
select fipsn, sum(pop)
from pop_07w
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_07b_02 as 
select fipsn, sum(pop)
from pop_07b
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_07o_02 as 
select fipsn, sum(pop)
from pop_07o
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_07t as 
select fipsn, sum(pop)
from pop_0701
group by fipsn
order by fipsn;
quit;


/* 2012 sum*/
proc sql;
create table pop_12w_02 as 
select fipsn, sum(pop)
from pop_12w
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_12b_02 as 
select fipsn, sum(pop)
from pop_12b
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_12o_02 as 
select fipsn, sum(pop)
from pop_12o
group by fipsn
order by fipsn;
quit;

proc sql;
create table pop_12t as 
select fipsn, sum(pop)
from pop_1201
group by fipsn
order by fipsn;
quit;

data pop_97w_03; set pop_97w_02; rename _TEMG001=white; run;
data pop_02w_03; set pop_02w_02; rename _TEMG001=white; run;
data pop_07w_03; set pop_07w_02; rename _TEMG001=white; run;
data pop_12w_03; set pop_12w_02; rename _TEMG001=white; run;

data pop_97b_03; set pop_97b_02; rename _TEMG001=black; run;
data pop_02b_03; set pop_02b_02; rename _TEMG001=black; run;
data pop_07b_03; set pop_07b_02; rename _TEMG001=black; run;
data pop_12b_03; set pop_12b_02; rename _TEMG001=black; run;

data pop_97o_03; set pop_97o_02; rename _TEMG001=other; run;
data pop_02o_03; set pop_02o_02; rename _TEMG001=other; run;
data pop_07o_03; set pop_07o_02; rename _TEMG001=other; run;
data pop_12o_03; set pop_12o_02; rename _TEMG001=other; run;

data pop_97t; set pop_97t; rename _TEMG001=tpop; run;
data pop_02t; set pop_02t; rename _TEMG001=tpop; run;
data pop_07t; set pop_07t; rename _TEMG001=tpop; run;
data pop_12t; set pop_12t; rename _TEMG001=tpop; run;

data pop_9710; merge pop_97w_03 pop_97b_03 pop_97o_03 pop_97w_03 pop_97t; by fipsn; run;
data pop_0210; merge pop_02w_03 pop_02b_03 pop_02o_03 pop_02w_03 pop_02t; by fipsn; run;
data pop_0710; merge pop_07w_03 pop_07b_03 pop_07o_03 pop_07w_03 pop_07t; by fipsn; run;
data pop_1210; merge pop_12w_03 pop_12b_03 pop_12o_03 pop_12w_03 pop_12t; by fipsn; run;

/* merged */
data exp.expsum_9735; merge exp.expsum_9730 pop_9710; by fipsn; run;
data exp.expsum_0235; merge exp.expsum_0230 pop_0210; by fipsn; run;
data exp.expsum_0735; merge exp.expsum_0730 pop_0710; by fipsn; run;
data exp.expsum_1235; merge exp.expsum_1230 pop_1210; by fipsn; run;

/* pct white and pct black */
data exp.expsum_9735; set exp.expsum_9735; pwhite=white/tpop; pblack=black/tpop; run;
data exp.expsum_0235; set exp.expsum_0235; pwhite=white/tpop; pblack=black/tpop; run;
data exp.expsum_0735; set exp.expsum_0735; pwhite=white/tpop; pblack=black/tpop; run;
data exp.expsum_1235; set exp.expsum_1235; pwhite=white/tpop; pblack=black/tpop; run;


/*************** POP and Pct by race 12/02/15 - COMPLETED AND MERGED  **********************************/


/*************** INCOME PER CAPITA 12/09/15 **********************************/
Proc import out = Exp.inc datafile = "C:\Users\yonsuk\Documents\Dissertation\Dissertation Data\Fiscal\INCOME.xlsx"
DBMS = xlsx replace;
Sheet = "INC";
Getnames =yes;
Run;

data inc_9712; set exp.inc; ripc_97=ipc_07/0.701; ripc_02=ipc_02/0.783; ripc_07=ipc_07/0.903; ripc_12=ipc_12/1;
rpi_97=pi_07/0.701; rpi_02=pi_02/0.783; rpi_07=pi_07/0.903; rpi_12=pi_12/1;run;
/** Applied the following IPC index 0.701 for 1997, 0.783 for 2002, 0.903 for 2007 as Price of 2012 **/

data inc_97(keep= fips region ipc_97 ripc_97 pi_97 rpi_97); set inc_9712; run;
data inc_02(keep= fips region ipc_02 ripc_02 pi_02 rpi_02); set inc_9712; run;
data inc_07(keep= fips region ipc_07 ripc_07 pi_07 rpi_07); set inc_9712; run;
data inc_12(keep= fips region ipc_12 ripc_12 pi_12 rpi_12); set inc_9712; run;

proc sort data=inc_97; by fips; run;
proc sort data=inc_02; by fips; run;
proc sort data=inc_07; by fips; run;
proc sort data=inc_12; by fips; run;

proc sort data=exp.expsum_9735; by fips; run;
proc sort data=exp.expsum_0235; by fips; run;
proc sort data=exp.expsum_0735; by fips; run;
proc sort data=exp.expsum_1235; by fips; run;

data exp.expsum_9735; merge inc_97 exp.expsum_9735; by fips; run;
data exp.expsum_0235; merge inc_02 exp.expsum_0235; by fips; run;
data exp.expsum_0735; merge inc_07 exp.expsum_0735; by fips; run;
data exp.expsum_1235; merge inc_12 exp.expsum_1235; by fips; run;

data exp.expsum_9735; set exp.expsum_9735; rename ipc_97=ipc; rename ripc_97=ripc; rename pi_97=pi;  rename rpi_97=rpi; run;
data exp.expsum_0235; set exp.expsum_0235; rename ipc_02=ipc; rename ripc_02=ripc; rename pi_02=pi;  rename rpi_02=rpi; run;
data exp.expsum_0735; set exp.expsum_0735; rename ipc_07=ipc; rename ripc_07=ripc; rename pi_07=pi;  rename rpi_07=rpi; run;
data exp.expsum_1235; set exp.expsum_1235; rename ipc_12=ipc; rename ripc_12=ripc; rename pi_12=pi;  rename rpi_12=rpi; run;


/*************** INCOME PER CAPITA - COMPLETED AND MERGED - 12/09/15 **********************************/



/*************** CALCULATING NEW VARIABLES *************************************************************/


/* TOTAL IGEXP PER CAPITA */
data exp.expsum_9735; set exp.expsum_9735; rdexp_cap=rdexp/population; run;
data exp.expsum_0235; set exp.expsum_0235; rdexp_cap=rdexp/population; run;
data exp.expsum_0735; set exp.expsum_0735; rdexp_cap=rdexp/population; run;
data exp.expsum_1235; set exp.expsum_1235; rdexp_cap=rdexp/population; run;

/* HEALTH/TOTAL */
data exp.expsum_9735; set exp.expsum_9735; health_texp=rthealth/rtexp; run;
data exp.expsum_0235; set exp.expsum_0235; health_texp=rthealth/rtexp; run;
data exp.expsum_0735; set exp.expsum_0735; health_texp=rthealth/rtexp; run;
data exp.expsum_1235; set exp.expsum_1235; health_texp=rthealth/rtexp; run;

/* HEALTH_CAP/TOTAL_CAP */
data exp.expsum_9735; set exp.expsum_9735; health_texp_cap=rthealth_cap/rtexp_cap; run;
data exp.expsum_0235; set exp.expsum_0235; health_texp_cap=rthealth_cap/rtexp_cap; run;
data exp.expsum_0735; set exp.expsum_0735; health_texp_cap=rthealth_cap/rtexp_cap; run;
data exp.expsum_1235; set exp.expsum_1235; health_texp_cap=rthealth_cap/rtexp_cap; run;

/* LOG TRANSFORMATION FOR MHI AND POP  */
data exp.expsum_9735; set exp.expsum_9735; lnmhi=log(mhi); lnpop=log(population); lnhealthtexp=log(health_texp);run;
data exp.expsum_0235; set exp.expsum_0235; lnmhi=log(mhi); lnpop=log(population); lnhealthtexp=log(health_texp);run;
data exp.expsum_0735; set exp.expsum_0735; lnmhi=log(mhi); lnpop=log(population); lnhealthtexp=log(health_texp);run;
data exp.expsum_1235; set exp.expsum_1235; lnmhi=log(mhi); lnpop=log(population); lnhealthtexp=log(health_texp);run;

data exp.expsum_9735; set exp.expsum_9735; healthpi=rthealth/ripc; run;
data exp.expsum_0235; set exp.expsum_0235; healthpi=rthealth/ripc; run;
data exp.expsum_0735; set exp.expsum_0735; healthpi=rthealth/ripc; run;
data exp.expsum_1235; set exp.expsum_1235; healthpi=rthealth/ripc; run;

data exp.expsum_9735; set exp.expsum_9735; lnhealthpi=log(healthpi); run;
data exp.expsum_0235; set exp.expsum_0235; lnhealthpi=log(healthpi); run;
data exp.expsum_0735; set exp.expsum_0735; lnhealthpi=log(healthpi); run;
data exp.expsum_1235; set exp.expsum_1235; lnhealthpi=log(healthpi); run;


/* DROP VARIABLES */
data exp.expsum_9735 (drop= rthealt_cap health_tex); set exp.expsum_9735; run;
data exp.expsum_0235 (drop= rthealt_cap health_tex); set exp.expsum_0235; run;
data exp.expsum_0735 (drop= rthealt_cap health_tex); set exp.expsum_0735; run;
data exp.expsum_1235 (drop= rthealt_cap health_tex); set exp.expsum_1235; run;

/*************** CALCULATING NEW VARIABLES - END ********************************************************/

/* CRATE DATASET THAT ALLOWS CORR BETWEEN VARIABLES OVER TIME - 12/02/15 */

data cap_97 (keep=fipsn stname ctyname rtexp rdexp rthealth rtexp_cap rthealth_cap population); set exp.expsum_9735; run;
data cap_02 (keep=fipsn stname ctyname rtexp rdexp rthealth rtexp_cap rthealth_cap population); set exp.expsum_0235; run;
data cap_07 (keep=fipsn stname ctyname rtexp rdexp rthealth rtexp_cap rthealth_cap population); set exp.expsum_0735; run;
data cap_12 (keep=fipsn stname ctyname rtexp rdexp rthealth rtexp_cap rthealth_cap population); set exp.expsum_1235; run;

 
data cap_97; set cap_97; rename rtexp=rtexp_97; rename rdexp=rdexp_97; rename rthealth=rthealth_97; rename rtexp_cap=rtexp_cap_97; rename rthealth_cap=rthealth_cap_97; run;
data cap_02; set cap_02; rename rtexp=rtexp_02; rename rdexp=rdexp_02; rename rthealth=rthealth_02; rename rtexp_cap=rtexp_cap_02; rename rthealth_cap=rthealth_cap_02; run;
data cap_07; set cap_07; rename rtexp=rtexp_07; rename rdexp=rdexp_07; rename rthealth=rthealth_07; rename rtexp_cap=rtexp_cap_07; rename rthealth_cap=rthealth_cap_07; run;
data cap_12; set cap_12; rename rtexp=rtexp_12; rename rdexp=rdexp_12; rename rthealth=rthealth_12; rename rtexp_cap=rtexp_cap_12; rename rthealth_cap=rthealth_cap_12; run;

proc sort data=cap_97; by fipsn; run;
proc sort data=cap_02; by fipsn; run;
proc sort data=cap_07; by fipsn; run;
proc sort data=cap_12; by fipsn; run;

data cap_all; merge cap_97 cap_02 cap_07 cap_12; by fipsn; run;
data cap_all; set cap_all; if fipsn=. then delete; run;

proc corr data=cap_all; var rtexp_97 rtexp_02 rtexp_07 rtexp_12; where population>=200000; run;

proc corr data=cap_all; var rdexp_97 rdexp_02 rdexp_07 rdexp_12; where population>=200000; run;

proc corr data=cap_all; var rthealth_97 rthealth_02 rthealth_07 rthealth_12; where population>=200000; run;

proc corr data=cap_all; var rtexp_cap_97 rtexp_cap_02 rtexp_cap_07 rtexp_cap_12; where population>=200000; run;

proc corr data=cap_all; var rthealth_cap_97 rthealth_cap_02 rthealth_cap_07 rthealth_cap_12; where population>=200000; run;


/* CRATE DATASET THAT ALLOWS CORR BETWEEN VARIABLES OVER TIME - END 12/02/15 */


/*******************************PANEL DATA **************************************************************************************/

data expsum_all; set exp.expsum_1235 exp.expsum_0735 exp.expsum_0235 exp.expsum_9735; run;
data expsum_all; set expsum_all; if ctn=. then delete; run;
data expsum_all; set expsum_all; if st=. then delete; run;

/*******************************PANEL DATA **************************************************************************************/


data expsum_12; set expsum_all; where year4=2012; run;
data expsum_07; set expsum_all; where year4=2007; run;
data expsum_02; set expsum_all; where year4=2002; run;
data expsum_97; set expsum_all; where year4=1997; run;

proc sort data=test; by fipsn year4; run;

data test_11; set test_1; igratio = tigexp/texp; run;
proc means data=test_11; var igratio; run;


/* 111815*/

/** Corr test**/
proc corr data=test; 
var frag govall texp dexp teduc thealth thospital thouscom tpublic_welf mhi unempr povr population density_pop; 
where population>=200000; run;

proc corr data=test; 
var texp rtexp dexp tigexp rdexp teduc tfire tjudicial rthealth thealth thospital thighways thouscom tparks tpolice tpublic_welf ; 
where population>=200000; run;

proc corr data=test; 
var rtexp_cap rthealth_cap health_texp_cap pwhite pblack mhi lnmhi povr population lnpop;
where population>=200000; run;

proc corr data=test; 
var frag texp tigexp ig_exp_st ig_exp_local rtexp_cap thealth ighealth_st ighealth_loc rthealth_cap pwhite pblack rmhi povr population ;
where population>=200000; run;

proc corr data=expsum_all; 
var frag govall texp rtexp_cap thealth rthealth_cap mhi unempr povr population density_pop; run;

where population>=200000; run;

/* DESCRIPTIVE STATS - 12/08/15 */
/** by quantukes **/
proc means data=expsum_all; var population frag rtexp rthealth rthealth_cap health_texp ; where population>60882.5; run;
proc means data=expsum_all; var population frag rtexp rthealth rthealth_cap health_texp ; where 60882.5 > population > 24526.0 ; run;
proc means data=expsum_all; var population frag rtexp rthealth rthealth_cap health_texp ; where 24526.0 > population > 11046.0; run;
proc means data=expsum_all; var population frag rtexp rthealth rthealth_cap health_texp ; where 11046.0 > population ; run;



/* *******************************MODEL SELECTION **************************************************************
********************************************************************************************************************/
/*
rtexp: total exp (real)
rdexp: direct exp (real)
rtheath: health exp (real)
rtexp_cap: total exp_cap (real)
thealth_texp: health/total exp (real)
rthealth_cap: health exp_cap (real)
health_texp_cap: health_cap/total_cap (reap) 
*/

/** 1. Total Expenditure **/
proc reg data=expsum_all; /*sig - Lev hold */
model rtexp = frag rmhi unempr povr population density_pop pblack year4; run;
proc reg data=expsum_all;
model rtexp = frag rmhi unempr povr population density_pop pblack year4; where population>=60882; run;
proc reg data=expsum_all; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4; where population>=200000; run;

/** 2. Total Expenditure (per cap)**/
proc reg data=expsum_all; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4; run;
proc reg data=expsum_all; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4; where population>=60882; run;
proc reg data=expsum_all; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4; where population>=200000; run;

/** 3. Total Health Expenditure **/
proc reg data =expsum_all; 
model rthealth = frag rmhi unempr povr population density_pop pblack year4; run;
proc reg data =expsum_all; 
model rthealth = frag rmhi unempr povr population density_pop pblack year4; where population>=60882; run;
proc reg data =expsum_all;
model rthealth = frag rmhi unempr povr population density_pop pblack year4; where population>=200000; run;

/** 4. Health Exp (per cap) **/
proc reg data =expsum_all;
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4; run;
proc reg data =expsum_all; 
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4; where population>=60882; run;
proc reg data =expsum_all; 
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4; where population>200000; run;


/** 5. Health/Total Expenditure **/
proc reg data=expsum_all; /*sig -*/
model health_texp = frag rmhi unempr povr population density_pop pblack year4; run;

proc reg data=expsum_all; /*sig*/
model health_texp = frag rmhi unempr povr population density_pop pblack year4; where population>=60882; run;

proc reg data=expsum_all; /*insig*/
model health_texp = frag rmhi unempr povr population density_pop pblack year4; where population>200000; run;

/** 7. Health/Income **/
proc reg data=expsum_all; /*sig - share of health/PI */
model healthpi = frag ripc unempr povr density_pop pwhite pblack year4; where population>200000; run;


/* health_texp_cap is the same as health_texp_cap*/

/* GLM - FE MODEL */
/** 1. Total Expenditure **/
proc glm data = expsum_all; class st year4; /* sig - Lev vio */
model rtexp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = expsum_all; class st year4; /* sig - Lev vio */
model rtexp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population>=60882; run;
proc glm data = expsum_all; class st year4; /* sig - Lev vio */
model rtexp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population>=200000; run;

/** 2. Total Expenditure (per cap)**/
proc glm data = expsum_all; class st year4; /* sig */
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = expsum_all; class st year4; /* sig */
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 60882; run;
proc glm data = expsum_all; class st year4; /* sig */
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 200000; run;

/** 3. Total Health Expenditure **/
proc glm data = expsum_all; class st year4; /* sig  */
model rthealth = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = expsum_all; class st year4; /* insig */
model rthealth = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population>= 60882/*3Q*/; run;
proc glm data = expsum_all; class st year4; /* insig */
model rthealth = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population>= 200000; run;

/** 4. Health Expenditure (per cap) **/
proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;

proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>=60882/*3Q*/; run;

proc glm data = expsum_all; class st year4; /* insig */
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>=200000; run;

proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag rmhi/*use rmhi other than ripc*/ unempr povr population density_pop pblack year4 fips/ solution ; where population>=60882/*3Q*/; run;

proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag rmhi/*use rmhi other than ripc*/ unempr povr density_pop pblack year4 st/ solution ; where population>=60882/*3Q*/; run;
proc glm data = expsum_all; class st year4; /* insig */
model rthealth_cap = frag rmhi unempr povr density_pop pblack year4 st/ solution ; where population>=200000; run;

proc glm data = expsum_all; class fips year4; /* County FE -> SE is too high */
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 fips/ solution ; where population>=60882/*3Q*/; run;

proc glm data = expsum_all; class year4; /* sig */
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4/ solution ; where population>=60882/*3Q*/; run;

/* VarComp test - 01/25/16 */

/** - subject: fips **/
proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model frag= fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model rmhi= fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model unempr= fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model povr= fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model pblack = fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model rtexp = fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model rtexp_cap = fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model rthealth = fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model rthealth_cap = fips year4; run;

/**  subject: st **/
proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model frag= st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
model frag= st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model rmhi= st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model unempr= st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model povr= st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model pblack = st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model rtexp = st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model rtexp_cap = st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model rthealth = st year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model rthealth_cap = st year4; run;




proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag rmhi/*use rmhi other than ripc*/ unempr povr population density_pop pblack year4 st/ solution ; where population>=60882/*3Q*/; run;

data expsum_all; set exp.expsum_all;

proc glm data = expsum_all; /* Hypothesis test for two random vars. using ANOVA */
class st year4 ; 
where population>=60882;
model rthealth_cap = st year4;
random st year4/ test; run; 


PROC MIXED data=lib.SGF13 covtest noclprint method = ML;
class schoolid;
model ma_z=/solution ddfm = SATTERTHWAITE;
random intercept / sub=schoolid type=vc;

PROC MIXED data=expsum_all covtest noclprint method= ML;
class st;
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 st/solution ddfm = SATTERTHWAITE;; where population>=60882/*3Q*/; 
random intercept /sub=schoolid type=vc;

PROC MIXED data=expsum_all covtest noclprint method= ML;
class schoolid;
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 st/solution ddfm = SATTERTHWAITE;; where population>=60882/*3Q*/; 
random intercept frag/ sub=schoolid type=vc;

PROC MIXED data=expsum_all covtest noclprint method= ML;
class st;
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 st/solution ddfm = SATTERTHWAITE;; where population>=60882/*3Q*/; 
random intercept frag/ sub=st type=vc;

proc means data=expsum_all; var frag; by fipsstr; where population>=60882; run;

proc means data=expsum_all; var density_pop; by fipsstr; where population>=60882; run;



/** 5. Health/Total Expenditure **/
proc glm data = expsum_all; class st year4; /* sig */
model health_texp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = expsum_all; class st year4; /* sig */
model health_texp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population>=60882/*3Q*/; run;
proc glm data = expsum_all; class st year4; /* insig */
model health_texp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population>=200000; run;

/* VarComp test - 02/06/16 */

proc varcomp data=exp.expsum_all method=reml;
class fips year4;
where population>=60882;
model health_texp = fips year4; run;

proc varcomp data=exp.expsum_all method=reml;
class st year4;
where population>=60882;
model health_texp = st year4; run;


/** 6. log(Health/Total Expenditure) **/
proc glm data = expsum_all; class st year4; /* insig */
model lnhealthtexp = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; run;
proc glm data = expsum_all; class st year4; /* sig */
model lnhealthtexp = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>=60882/*3Q*/; run;
proc glm data = expsum_all; class st year4; /* insig */
model lnhealthtexp = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>=200000; run;

proc genmod data=expsum_all; class st year4;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st/link=logit dist=binomial;
where population>=60882; run;

proc logistic data=expsum_all /*desc*/;
class year4 st/*/param=ref*/;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st;
/*strata st;*/ run;

proc logistic data=expsum_all desc;
class year4 st /param=ref;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st;
strata st; run;

proc logistic data=expsum_all;
class year4 st;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st/link=logit;
where population>=60882/*3Q*/;run;

proc logistic data=expsum_all;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st/link=logit dist=binomial;
where population>=60882/*3Q*/;run;

proc logistic data=expsum_all descending;
class year4 st;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st;
where population>=60882/*3Q*/;run;


data aa; set expsum_all; run;
data aa1; set aa; dep1=1-health_texp; run;
data aa1; set aa1; dep2=health_texp; run;
data aa1; set aa1; ratio=dep2/dep1; run;
data aa1; set aa1; lr = log(ratio); run;

proc glm data=aa1;
class year4 st;
model lr=frag rmhi unempr povr population density_pop pblack year4 st/ solution; run;

proc glm data=expsum_all;
class year4 st;
model health_texp=frag rmhi unempr povr population density_pop pblack year4 st/ solution; where population>=60882; run;

proc logistic data=expsum_all;
class year4 st;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st/link=logit ;run;

proc logistic data=expsum_all; /* Best but too good*/
class year4 st;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st/link=logit ;
where population>=60882; run;

proc logistic data=expsum_all desc; /* Best but too good*/
class year4 st;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st;
where population>=60882; run;

proc logistic data=expsum_all desc; /* CONDITIONAL LOGISTIC FOR FE - refer to http://www2.sas.com/proceedings/sugi31/184-31.pdf*/
class year4 /PARAM=REF; 
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4;
where population>=60882; strata st; run;

proc genmod data=expsum_all; /* using genmod but the same as above*/
class year4 st;
model rthealth/rtexp=frag rmhi unempr povr population density_pop pblack year4 st/link=logit dist=binomial ;
where population>=60882; run;

proc glm data=expsum_all;
class year4 st;
model health_texp=frag rmhi unempr povr population density_pop pblack year4 st/ solution;
where population>=60882; run;

proc glm data=expsum_all;
class year4 st;
model health_texp=frag rmhi unempr povr population density_pop pblack year4 st/ solution; where population>=60882; run;

proc genmod data=expsum_all; /* p=-.048 */
class st year4; 
model health_texp=frag rmhi unempr povr population density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;



dist=binomial; run;




proc glm data = expsum_all; class st year4; /* sig */
model lnhealthtexp = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>=60882/*3Q*/; run;



proc reg data=expsum_all;
model lnhealthtexp=frag rmhi unempr povr population density_pop pblack year4 st;
run;

/** 7. Health/Income **/
proc glm data = expsum_all; class st year4; /* sig */
model healthpi = frag ripc rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = expsum_all; class st year4; /* insig */
model healthpi = frag ripc rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>= 60882; run;
proc glm data = expsum_all; class st year4; /* insig */
model healthpi = frag ripc rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>= 200000; run;

/** 8. log(Health/Income) **/
proc glm data = expsum_all; class st year4; /* sig */
model lnhealthpi = frag ripc unempr povr population density_pop pwhite pblack st year4 / solution ; run;
proc glm data = expsum_all; class st year4; /* sig */
model lnhealthpi = frag ripc unempr povr population density_pop pwhite pblack st year4 / solution ; where population> 60882; run;
proc glm data = expsum_all; class st year4; /* sig */
model lnhealthpi = frag ripc unempr povr population density_pop pblack st year4 / solution ; where population> 200000; run;


/* GEE model */

/** 1. Total Expenditure **/
proc genmod data=expsum_all; /*sig*/
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*sig*/
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*sig*/
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

/** 2. Total Health Expenditure (per cap)**/
proc genmod data=expsum_all; /*sig*/
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*insig*/
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*insig, sig (no pop restriction) */
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;


/** 3. Total Health Expenditure **/
proc genmod data=expsum_all; /*insig */
class st year4; 
model rthealth = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*insig, sig (no pop restriction) */
class st year4; 
model rthealth = frag rmhi unempr povr population density_pop pblack year4;
where population>=60082;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*insig, sig (no pop restriction) */
class st year4; 
model rthealth = frag rmhi unempr povr population density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;


/** 4. Health Expenditure (per cap) **/
proc genmod data=expsum_all; /*insig */
class st year4; 
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*sig */
class st year4; 
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4;
where population>=60082;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*insig, sig (no pop restriction)*/
class st year4; 
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*sig */
class st year4; 
model rthealth_cap = frag rmhit unempr povr population density_pop pblack year4;
where population>=60082;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;


/** 5. Health/Total Expenditure **/
proc genmod data=expsum_all;
class st year4; 
model health_texp = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all;
class st year4; 
model health_texp = frag rmhi unempr povr population density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all;
class st year4; 
model health_texp = frag rmhi unempr povr population density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all;
class govidn year4; 
model health_texp = frag rmhi unempr povr density_pop pblack year4;
where population>=60882;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc corr data =expsum_all; var frag density_pop; where population>=60882; run;



/** 6. ln(Health/Total) **/
proc genmod data=expsum_all;
class st year4; 
model lnhealthtexp = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all;
class st year4; 
model lnhealthtexp = frag rmhi unempr povr population density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all;
class st year4; 
model lnhealthtexp = frag rmhi unempr povr population density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;


proc univariate data=expsum_all; var healthpi lnhealthpi; run;
proc means data=expsum_all; var thealth ripc; run;
data test_100; set expsum_all; where thealth > ripc; run;


/** 7. Health/Income **/
proc genmod data=expsum_all; /* sig (0.0663)*/
class st year4; 
model healthpi = frag ripc unempr population povr density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /* sig */
class st year4; 
model healthpi = frag ripc unempr povr population density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /* sig */
class st year4; 
model healthpi = frag ripc unempr povr population density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; 
class st year4; 
model healthpi = frag ripc unempr povr /*population*/ density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;


/** 8. log(Health/Income) **/
proc genmod data=expsum_all; /* sig */
class st year4; 
model lnhealthpi = frag ripc unempr povr density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /* sig */
class st year4; 
model lnhealthpi = frag ripc unempr povr density_pop pblack year4;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /* sig */
class st year4; 
model lnhealthpi = frag ripc unempr population povr density_pop pblack year4;
where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;


/* DESCRIPTIVE STATS */

proc univariate data=expsum_all; var population; run;

proc means data=expsum_all; var frag; run;
proc means data=expsum_all; var frag; where population>=60882; run;
proc means data=expsum_all; var frag; where population>=200000; run;

proc means data=expsum_all; var rtexp rtexp_cap rthealth rthealth_cap health_texp; run;
proc means data=expsum_all; var rtexp rtexp_cap rthealth rthealth_cap health_texp; where population>=60882; run;
proc means data=expsum_all; var rtexp rtexp_cap rthealth rthealth_cap health_texp; where population>=200000; run;

proc means data=expsum_all; var ripc rmhi; run;
proc means data=expsum_all; var ripc rmhi; where population>=60882; run;
proc means data=expsum_all; var ripc rmhi; where population>=200000; run;

proc means data=expsum_all; var unempr povr pblack; run;
proc means data=expsum_all; var unempr povr pblack; where population>=60882; run;
proc means data=expsum_all; var unempr povr pblack; where population>=200000; run;

proc means data=expsum_all; var density_pop; run;
proc means data=expsum_all; var density_pop; where population>=60882; run;
proc means data=expsum_all; var density_pop; where population>=200000; run;


/* Correlation coefficients */
proc corr data=expsum_all; var frag govall population density_pop rmhi ripc unempr povr rtexp rthealth pblack; run;
proc corr data=expsum_all; var frag govall population density_pop rmhi ripc unempr povr rtexp rthealth pblack; where population>=60882; run;
proc corr data=expsum_all; var frag govall population density_pop rmhi ripc unempr povr rtexp rthealth pblack; where population>=200000; run;

proc corr data=expsum_all; var texp thealth teduc tfire tpolice tjudicial thighways thouscom tparks tpublic_welf; run;
proc corr data=expsum_all; var texp thealth teduc tfire tpolice tjudicial thighways thouscom tparks tpublic_welf; where population>=60882; run;
proc corr data=expsum_all; var texp thealth teduc tfire tpolice tjudicial thighways thouscom tparks tpublic_welf; where population>=200000; run;

proc corr data=cap_all; var rtexp_97 rtexp_02 rtexp_07 rtexp_12; run;
proc corr data=cap_all; var rtexp_97 rtexp_02 rtexp_07 rtexp_12; where population>=60882; run;
proc corr data=cap_all; var rtexp_97 rtexp_02 rtexp_07 rtexp_12; where population>=200000; run;

proc corr data=cap_all; var rtexp_cap_97 rtexp_cap_02 rtexp_cap_07 rtexp_cap_12; run;
proc corr data=cap_all; var rtexp_cap_97 rtexp_cap_02 rtexp_cap_07 rtexp_cap_12; where population>=60882; run;
proc corr data=cap_all; var rtexp_cap_97 rtexp_cap_02 rtexp_cap_07 rtexp_cap_12; where population>=200000; run;

proc corr data=cap_all; var rthealth_97 rthealth_02 rthealth_07 rthealth_12; run;
proc corr data=cap_all; var rthealth_97 rthealth_02 rthealth_07 rthealth_12; where population>=60882; run;
proc corr data=cap_all; var rthealth_97 rthealth_02 rthealth_07 rthealth_12; where population>=200000; run;

proc corr data=cap_all; var rthealth_cap_97 rthealth_cap_02 rthealth_cap_07 rthealth_cap_12; run;
proc corr data=cap_all; var rthealth_cap_97 rthealth_cap_02 rthealth_cap_07 rthealth_cap_12; where population>=608820; run;
proc corr data=cap_all; var rthealth_cap_97 rthealth_cap_02 rthealth_cap_07 rthealth_cap_12; where population>=200000; run;


proc means data=expsum_3q; var fips; where year4=2012; run;
proc means data=expsum_3q; var fips; where year4=2007; run;
proc means data=expsum_3q; var fips; where year4=2002; run;
proc means data=expsum_3q; var fips; where year4=1997; run;


/* DESCRIPTIVE STATS */

data expsum_3Q; set expsum_all; where population>60882; run;
data expsum_3Q_01; set expsum_3Q; if thospital>0 then thospital= 1; run;

proc univariate data =expsum_3Q; var frag povr unempr population density_pop rthealth rmhi ripc healthpi healthinc rthealth_cap pblack; run;
proc means data =expsum_3Q; var frag povr unempr population density_pop rthealth rmhi ripc healthpi healthinc rthealth_cap pblack; run;
 

proc univariate data=expsum_all; var healthpi lnhealthpi; run;

proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag rmhi/*use rmhi other than ripc*/ thospital unempr povr population density_pop pblack year4 st/ solution ; where population> 60882/*3Q*/; run;

proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag rmhi/*use rmhi other than ripc*/ thospital unempr povr population density_pop pwhite year4 st/ solution ; where population> 60882/*3Q*/; run;


proc glm data = expsum_all; class st year4; /* sig */
model rthealth_cap = frag ripc /*use rmhi other than ripc*/ unempr povr population density_pop pblack year4 st/ solution ; where population> 60882/*3Q*/; run;

proc glm data = expsum_all; class fips year4; /* sig */
model rthealth_cap = frag rmhi/*use rmhi other than ripc*/ unempr povr population density_pop pblack year4 fips/ solution ; where population> 60882/*3Q*/; run;

proc corr data = expsum_3Q; var rmhi ripc unempr; run;


proc means data=expsum_3Q; var rthealth_cap; by stname; run;



proc genmod data=expsum_all; /* sig at p=.10 */
class fips_code_state year4; 
model rtexp_cap = frag rmhi unempr povr density_pop govall year4;
repeated subject = fips_code_state/ type=exch covb corrw modelse; 
run; quit;


proc genmod data=expsum_all; /*insig*/
class fips_code_state year4; 
model rthealthcap = frag rmhi unempr povr density_pop govall year4;
repeated subject = fips_code_state/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*sig*/
class fips_code_state year4; 
model rthealth = frag rmhi unempr povr density_pop govall year4;
repeated subject = fips_code_state/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=expsum_all; /*insig*/
class fips_code_state year4; 
model phealth_tot = frag rmhi unempr povr density_pop govall year4;
repeated subject = fips_code_state/ type=exch covb corrw modelse; 
run; quit;





data aa1; set expsum_all; where population<65; run;

data big; set expsum_all; where population>=60882; run;

proc means data=big; var population; where year4=1997; run;
proc means data=big; var population; where year4=2002; run;
proc means data=big; var population; where year4=2007; run;
proc means data=big; var population; where year4=2012; run;

proc means data=big; var frag govall population; where year4=1997; run;
proc means data=big; var frag govall population; where year4=2002; run;
proc means data=big; var frag govall population; where year4=2007; run;
proc means data=big; var frag govall population; where year4=2012; run;


proc means data=expsum_all; var rtexp; where year4=1997; run;
proc means data=expsum_all; var rtexp; where year4=2002; run;
proc means data=expsum_all; var rtexp; where year4=2007; run;
proc means data=expsum_all; var rtexp; where year4=2012; run;
proc means data=expsum_all; var rtexp; run;
proc means data=big11; var rtexp; run;

/* total exp per cap */
proc means data=expsum_all; var rtexp_cap; where year4=1997; run;
proc means data=expsum_all; var rtexp_cap; where year4=2002; run;
proc means data=expsum_all; var rtexp_cap; where year4=2007; run;
proc means data=expsum_all; var rtexp_cap; where year4=2012; run;
proc means data=big11; var rtexp_cap; run; /* after deleting missing for datayear */

/* texp_cap rankings */
data t97; set big11; where year4=1997; run;
data t02; set big11; where year4=2002; run;
data t07; set big11; where year4=2007; run;
data t12; set big11; where year4=2012; run;

data t3q97; set t97; where population>=60882; run;
data t3q02; set t02; where population>=60882; run;
data t3q07; set t07; where population>=60882; run;
data t3q12; set t12; where population>=60882; run;

proc sort data=t3q97; by rtexp_cap; run;
proc sort data=t3q02; by rtexp_cap; run;
proc sort data=t3q07; by rtexp_cap; run;
proc sort data=t3q12; by rtexp_cap; run;

proc sort data=t12; by rthealth; run;
 
/* health spending over time */
data th97 (keep=year4 st ctyname rthealth population) ; set t97; run;
data th02 (keep=year4 st ctyname rthealth population) ; set t02; run;
data th07 (keep=year4 st ctyname rthealth population) ; set t07; run;
data th12 (keep=year4 st ctyname rthealth population) ; set t12; run;

proc means data=th97; var rthealth; run;
proc means data=th02; var rthealth; run;
proc means data=th07; var rthealth; run;
proc means data=th12; var rthealth; run;

proc means data=th97; var rthealth; where population>=60882; run;
proc means data=th02; var rthealth; where population>=60882; run;
proc means data=th07; var rthealth; where population>=60882; run;
proc means data=th12; var rthealth; where population>=60882; run;

proc means data=th97; var rthealth; where population>=200000; run;
proc means data=th02; var rthealth; where population>=200000; run;
proc means data=th07; var rthealth; where population>=200000; run;
proc means data=th12; var rthealth; where population>=200000; run;

/* health exp per cap */
data thc97 (keep=year4 state_1 ctyname rthealth_cap population) ; set t97; run;
data thc02 (keep=year4 state_1 ctyname rthealth_cap population) ; set t02; run;
data thc07 (keep=year4 state_1 ctyname rthealth_cap population) ; set t07; run;
data thc12 (keep=year4 state_1 ctyname rthealth_cap population) ; set t12; run;

data thc971 ; set thc97; where population>=60882; run;
data thc021 ; set thc02; where population>=60882; run;
data thc071 ; set thc07; where population>=60882; run;
data thc121 ; set thc12; where population>=60882; run;

data thc972 ; set thc97; where population>=200000; run;
data thc022 ; set thc02; where population>=200000; run;
data thc072 ; set thc07; where population>=200000; run;
data thc122 ; set thc12; where population>=200000; run;

proc means data=thc97; var rthealth_cap; run;
proc means data=thc02; var rthealth_cap; run;
proc means data=thc07; var rthealth_cap; run;
proc means data=thc12; var rthealth_cap; run;

proc means data=thc97; var rthealth_cap; where population>=60882; run;
proc means data=thc02; var rthealth_cap; where population>=60882; run;
proc means data=thc07; var rthealth_cap; where population>=60882; run;
proc means data=thc12; var rthealth_cap; where population>=60882; run;

proc means data=thc97; var rthealth_cap; where population>=200000; run;
proc means data=thc02; var rthealth_cap; where population>=200000; run;
proc means data=thc07; var rthealth_cap; where population>=200000; run;
proc means data=thc12; var rthealth_cap; where population>=200000; run;


/* CONTRO VARIABLE */
/* health exp per cap */
data thc97 (keep=year4 state_1 ctyname rmhi ripc pblack unempr povr density_pop population) ; set t97; run;
data thc02 (keep=year4 state_1 ctyname rmhi ripc pblack unempr povr density_pop population) ; set t02; run;
data thc07 (keep=year4 state_1 ctyname rmhi ripc pblack unempr povr density_pop population) ; set t07; run;
data thc12 (keep=year4 state_1 ctyname rmhi ripc pblack unempr povr density_pop population) ; set t12; run;

data thc971 ; set thc97; where population>=60882; run; /* this is for rankings, max, min */
data thc021 ; set thc02; where population>=60882; run;
data thc071 ; set thc07; where population>=60882; run;
data thc121 ; set thc12; where population>=60882; run;

proc means data=thc97; var rmhi ripc pblack unempr povr density_pop; run;
proc means data=thc02; var rmhi ripc pblack unempr povr density_pop; run;
proc means data=thc07; var rmhi ripc pblack unempr povr density_pop; run;
proc means data=thc12; var rmhi ripc pblack unempr povr density_pop;run;

proc means data=thc97; var rmhi ripc pblack unempr povr density_pop; where population>=60882; run;
proc means data=thc02; var rmhi ripc pblack unempr povr density_pop; where population>=60882; run;
proc means data=thc07; var rmhi ripc pblack unempr povr density_pop; where population>=60882; run;
proc means data=thc12; var rmhi ripc pblack unempr povr density_pop; where population>=60882; run;

proc means data=expsum_all; var density_pop; run;
proc means data=expsum_all; var density_pop; where population>=60882; run;



data only1; set expsum_all; if county=1; run;

data t3q02; set t02; where population>=60882; run;
data t3q07; set t07; where population>=60882; run;
data t3q12; set t12; where population>=60882; run;


proc means data=big11; var rtexp rtexp rtexp_cap rthealth rthealth_cap health_texp ;run;
proc means data=big11; var rtexp rtexp rtexp_cap rthealth rthealth_cap health_texp ; where population>=60882; run;
proc means data=big11; var rtexp rtexp rtexp_cap rthealth rthealth_cap health_texp ; where population>=200000; run;

data big11; set expsum_all; if year4=. then delete; run;


/* Expenditure - Rankings - Final -  START */

data expsum_all; set exp.expsum_all; run;

data rank_01; set expsum_all; where population>=60882; run;
data rank_02 (keep=year4 state_1 ctyname frag rtexp rtexp_cap rthealth rthealth_cap health_texp population); set rank_01; run;

data rank_1997; set rank_02; where year4=1997; run;
data rank_2002; set rank_02; where year4=2002; run;
data rank_2007; set rank_02; where year4=2007; run;
data rank_2012; set rank_02; where year4=2012; run;

proc means data=rank_01; var health_texp; run;
proc means data=rank_1997; var health_texp; run;
proc means data=rank_2002; var health_texp; run;
proc means data=rank_2007; var health_texp; run;
proc means data=rank_2012; var health_texp; run;

proc means data=expsum_all; var health_texp; run;
proc means data=expsum_all; var health_texp; where year4=1997; run;
proc means data=expsum_all; var health_texp; where year4=2002; run;
proc means data=expsum_all; var health_texp; where year4=2007; run;
proc means data=expsum_all; var health_texp; where year4=2012; run;



/* Expenditure - Rankings - Final - END */

/* Health/total - Descriptive - START */



/* Health/total - Descriptive - END */

data aa1; set expsum_all; where year4=2012; run;

data aa2; set aa1; where population>=60882; run;
data aa3; set aa1; where population>=200000; run;






/* Leviathan - 031816 */

data exp.expsum_all; set exp.expsum_all; lnrtexp=log(rtexp); lnrtexp_cap=log(rtexp_cap); run;

/** data by year **/
data exp.expsum_all; set exp.expsum_all; year=year_unemp; run;
data exp.expsum_all; set exp.expsum_all; nyear=year*1; run;

data exp_1997; set exp.expsum_all; where nyear=1997; run;
data exp_2002; set exp.expsum_all; where nyear=2002; run;
data exp_2007; set exp.expsum_all; where nyear=2007; run;
data exp_2012; set exp.expsum_all; where nyear=2012; run;


/*** 
Common function: tfire  thighways tparks tpolice (police, fire, parks and recreation, sanitation, highways, general control, and general administration)
Social function: thousecom tpublic-welf thospital teduc 
***/

data exp_2012; set exp_2012; rfire=tfire/1; rhighways=thighways/1; rparks=tparks/1; rpolice=tpolice/1; rhouscom=thouscom/1; rpublic_welf=tpublic_welf/1; rhospital=thospital/1; reduc=teduc/1; run;
data exp_2007; set exp_2007; rfire=tfire/0.903; rhighways=thighways/0.903; rparks=tparks/0.903; rpolice=tpolice/0.903; rhouscom=thouscom/0.903; rpublic_welf=tpublic_welf/0.903; rhospital=thospital/0.903; reduc=teduc/0.903; run;
data exp_2002; set exp_2002; rfire=tfire/0.783; rhighways=thighways/0.783; rparks=tparks/0.783; rpolice=tpolice/0.783; rhouscom=thouscom/0.783; rpublic_welf=tpublic_welf/0.783; rhospital=thospital/0.783; reduc=teduc/0.783; run;
data exp_1997; set exp_1997; rfire=tfire/0.701; rhighways=thighways/0.701; rparks=tparks/0.701; rpolice=tpolice/0.701; rhouscom=thouscom/0.701; rpublic_welf=tpublic_welf/0.701; rhospital=thospital/0.701; reduc=teduc/0.701; run;


data exp_2012; set exp_2012; comexp = rfire + rhighways + rparks + rpolice; socexp = rhouscom + rpublic_welf + rhospital + reduc; run;
data exp_2007; set exp_2007; comexp = rfire + rhighways + rparks + rpolice; socexp = rhouscom + rpublic_welf + rhospital + reduc; run;
data exp_2002; set exp_2002; comexp = rfire + rhighways + rparks + rpolice; socexp = rhouscom + rpublic_welf + rhospital + reduc; run;
data exp_1997; set exp_1997; comexp = rfire + rhighways + rparks + rpolice; socexp = rhouscom + rpublic_welf + rhospital + reduc; run;

data expsum_all_02; set exp_1997 exp_2002 exp_2007 exp_2012; run;
data add; set expsum_all_02; keep fipsstrn fipsctyrn nyear comexp rfire rhighways rparks rpolice socexp rhousecom rpublic_welf rhospital reduc; run;

proc sort data=exp.expsum_all; by nyear fipsstrn fipsctyrn; run;
proc sort data=add; by nyear fipsstrn fipsctyrn ; run;
data exp.expsum_all;
merge exp.expsum_all add; by nyear fipsstrn fipsctyrn; run;

data exp.expsum_all; set exp.expsum_all; comexp_cap=comexp/population; socexp_cap=socexp/population; run;

data d1997; set exp.expsum_all; where year4=1997; if population>=60882; run;
data d2002; set exp.expsum_all; where year4=2002; if population>=60882; run;
data d2007; set exp.expsum_all; where year4=2007; if population>=60882; run;
data d2012; set exp.expsum_all; where year4=2012; if population>=60882; run;

/*** the final data backed up in case of the wrong integration ***/
data exp.expsum_all_backup; set exp.expsum_all; run;


proc glm data = exp.expsum_all; class st year4; 
model comexp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model comexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model socexp = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model socexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;



/** 1. Total Expenditure **/


/*** rtexp ***/
/**** LSDV ****/
/***** State *****/
proc glm data = exp.expsum_all; class st year4 ; 
model rtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=60882; run;
proc glm data = exp.expsum_all; class st year4 ;
model rtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model rtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;

/***** County *****/
proc glm data = exp.expsum_all; class govidn year4 ; 
model rtexp = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; run;
proc glm data = exp.expsum_all; class govidn year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where population>=60882; run;
proc glm data = exp.expsum_all; class govidn year4 ;
model rtexp = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where population>=200000; run;

proc glm data = exp.expsum_all; class govidn year4 ;
model rtexp = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class govidn year4;
model rtexp = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class govidn year4;
model rtexp = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where population<50000; run;


/**** GEE - FIPS State ****/

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where population>200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where population>60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where 200000>population>=100000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where 100000>population>=50000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where population<50000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;



/**** GEE - FIPS County ****/

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where population>200000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where population>60882;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where 200000>population>=100000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where 100000>population>=50000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp = frag rmhi unempr povr population density_pop pblack year4;where population<50000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;


/** general purpose **/
proc glm data = exp.expsum_all; class st year4 ; 
model rtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model rtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=60882; run;
proc glm data = exp.expsum_all; class st year4 ;
model rtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model rtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;

/** Special purpose **/
proc glm data = exp.expsum_all; class st year4 ; 
model rtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model rtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=60882; run;
proc glm data = exp.expsum_all; class st year4 ;
model rtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model rtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;




/* 1997 */
proc glm data = exp_1997; class st ; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_1997; class st; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_1997; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_1997; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>population>=100000; run;
proc glm data = exp_1997; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>population>=50000; run;
proc glm data = exp_1997; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population<50000; run;


/* 2002 */
proc glm data = exp_2002; class st ; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2002; class st; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2002; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2002; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2002; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2002; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;

/* 2007 */
proc glm data = exp_2007; class st ; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2007; class st; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2007; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2007; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2007; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2007; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;


/* 2012 */
proc glm data = exp_2012; class st ; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2012; class st; 
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2012; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2012; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2012; class st ;
model rtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2012; class govidn ;
model rtexp = frag rmhi unempr povr population density_pop pblack govidn / solution ; where 50000>=population; run;



/*** ln (rtexp) ***/
proc glm data = exp.expsum_all; class st year4 ; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=60882; run;
proc glm data = exp.expsum_all; class st year4 ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>=population; run;
proc glm data = exp.expsum_all; class st year4 ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;

/** General Purpose **/
proc glm data = exp.expsum_all; class st year4 ; 
model lnrtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model lnrtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=60882; run;
proc glm data = exp.expsum_all; class st year4 ;
model lnrtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model lnrtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model lnrtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model lnrtexp = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;


/** Special Purpose **/
proc glm data = exp.expsum_all; class st year4 ; 
model lnrtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model lnrtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=60882; run;
proc glm data = exp.expsum_all; class st year4 ;
model lnrtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where population>=200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model lnrtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model lnrtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model lnrtexp = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;


/* 1997 */
proc glm data = exp_1997; class st ; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_1997; class st; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_1997; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_1997; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>population>=100000; run;
proc glm data = exp_1997; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>population>=50000; run;
proc glm data = exp_1997; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population<50000; run;


/* 2002 */
proc glm data = exp_2002; class st ; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2002; class st; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2002; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2002; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2002; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2002; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;

/* 2007 */
proc glm data = exp_2007; class st ; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2007; class st; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2007; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2007; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2007; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2007; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;


/* 2012 */
proc glm data = exp_2012; class st ; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2012; class st; 
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2012; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2012; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2012; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2012; class st ;
model lnrtexp = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;



/** 2. Total Expenditure (per cap)**/

data expsum_all; set exp.expsum_all; run;


/*** LSDV ***/
/**** State ****/
proc glm data = expsum_all; class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 60882; run;
proc glm data = expsum_all; class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;


/**** FIPS county ****/
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 govidn / solution ; run;
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 govidn / solution ; where population> 60882; run;
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 govidn / solution ; where population> 200000; run;

proc glm data = exp.expsum_all; class govidn year4 ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class govidn year4;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class govidn year4;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack govidn year4 / solution ; where population<50000; run;

/*** GEE ***/

/**** State ****/
proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;


proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where population>60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where 200000>population>=100000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where 100000>population>=50000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class st year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where population<50000;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;




/**** County ****/
proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where population>=200000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;


proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where population>60882;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where 200000>population>=100000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where 100000>population>=50000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;

proc genmod data=exp.expsum_all; 
class govidn year4; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4;where population<50000;
repeated subject = govidn/ type=exch covb corrw modelse; 
run; quit;


/** General Purpose **/
/*** LSDV ***/
/**** STATE ****/
proc glm data = expsum_all; class st year4; 
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = expsum_all; class st year4; 
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 60882; run;
proc glm data = expsum_all; class st year4; 
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 200000; run;

/* fraggen and fragspe */
proc glm data = expsum_all; class st year4; 
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;

proc glm data = exp.expsum_all; class st year4 ;
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;

/**** COUNTY ****/
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4 govidn / solution ; run;
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4 govidn / solution ; where population> 60882; run;
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4 govidn / solution ; where population> 200000; run;

/*** GEE ***/
/**** COUNTY ****/
proc genmod data=exp.expsum_all; 
class govidn year4; model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4;
repeated subject = govidn/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class govidn year4; model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4;where population>=60882;
repeated subject = govidn/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class govidn year4; model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4;where population>=200000;
repeated subject = govidn/ type=exch covb corrw modelse; run; quit;

/**** STATE ****/
proc genmod data=exp.expsum_all; 
class st year4; model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class st year4; model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4;where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class st year4; model rtexp_cap = fraggen rmhi unempr povr population density_pop pblack year4;where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; run; quit;

/** Special Purpose **/
/*** LSDV ***/
/**** STATE ****/
proc glm data = expsum_all; class st year4; 
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = exp.expsum_all; class st year4; 
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 60882; run;
proc glm data = expsum_all; class st year4; 
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; where population> 200000; run;

proc glm data = exp.expsum_all; class st year4 ;
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4;
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack st year4 / solution ; where population<50000; run;

/**** COUNTY ****/
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4 govidn / solution ; run;
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4 govidn / solution ; where population> 60882; run;
proc glm data = expsum_all; class govidn year4; 
model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4 govidn / solution ; where population> 200000; run;

/*** GEE ***/
/**** COUNTY ****/
proc genmod data=exp.expsum_all; 
class govidn year4; model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = govidn/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class govidn year4; model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4;where population>=60882;
repeated subject = govidn/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class govidn year4; model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4;where population>=200000;
repeated subject = govidn/ type=exch covb corrw modelse; run; quit;

/**** STATE ****/
proc genmod data=exp.expsum_all; 
class st year4; model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class st year4; model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4;where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=exp.expsum_all; 
class st year4; model rtexp_cap = fragspe rmhi unempr povr population density_pop pblack year4;where population>=200000;
repeated subject = st/ type=exch covb corrw modelse; run; quit;




/* 1997 */
proc glm data = exp_1997; class st ; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_1997; class st; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_1997; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_1997; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>population>=100000; run;
proc glm data = exp_1997; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>population>=50000; run;
proc glm data = exp_1997; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population<50000; run;


/* 2002 */
proc glm data = exp_2002; class st ; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2002; class st; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2002; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2002; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2002; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2002; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;

/* 2007 */
proc glm data = exp_2007; class st ; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2007; class st; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2007; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2007; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2007; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2007; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;


/* 2012 */
proc glm data = exp_2012; class st ; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; run;
proc glm data = exp_2012; class st; 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=60882; run;
proc glm data = exp_2012; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where population>=200000; run;

proc glm data = exp_2012; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 200000>=population>100000; run;
proc glm data = exp_2012; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 100000>=population>50000; run;
proc glm data = exp_2012; class st ;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack st / solution ; where 50000>=population; run;



/* spending comparision - 04/15/16 - START */


/* 
rtexp: total exp
rtexp_cap: total exp per cap
rdexp: total direct exp
rhealth: health
rhealth_cap: health per cap
rtexp_cap: total exp per cap
rdexp_cap: total direct exp per cap
health_texp: health/ total ratio 
*/

/** additional items: construction, salaries & wages, general expenditure,   **/


data real_12; set exp.expsum_all; where year4=2012; run;
data real_07; set exp.expsum_all; where year4=2007; run;
data real_02; set exp.expsum_all; where year4=2002; run;
data real_97; set exp.expsum_all; where year4=1997; run;

data real_12; set real_12; rtedu=teduc/1; rthouscom=thouscom/1; rtwelf=tpublic_welf/1; rtfire=tfire/1; rtstaff=tstaff/1; rtpolice=tpolice/1; rthigh=thighways/1;run;
data real_07; set real_07; rtedu=teduc/0.903; rthouscom=thouscom/0.903; rtwelf=tpublic_welf/0.903; rtfire=tfire/0.903; rtstaff=tstaff/0.903; rtpolice=tpolice/0.903; rthigh=thighways/0.903; run;
data real_02; set real_02; rtedu=teduc/0.783; rthouscom=thouscom/0.783; rtwelf=tpublic_welf/0.783; rtfire=tfire/0.783; rtstaff=tstaff/0.783; rtpolice=tpolice/0.783; rthigh=thighways/0.783; run;
data real_97; set real_97; rtedu=teduc/0.701; rthouscom=thouscom/0.701; rtwelf=tpublic_welf/0.701; rtfire=tfire/0.701; rtstaff=tstaff/0.701; rtpolice=tpolice/0.701; rthigh=rhighways/0.701; run;

data real_12; set real_12; rtedu_cap=rtedu/population; rthous_cap=rthouscom/population; rtwelf_cap=rtwelf/population; rtfire_cap=tfire/population; rtstaff_cap=rtstaff/population; rtpolice_cap=rtpolice/population; rthigh_cap=rthigh/population; run;
data real_07; set real_07; rtedu_cap=rtedu/population; rthous_cap=rthouscom/population; rtwelf_cap=rtwelf/population; rtfire_cap=tfire/population; rtstaff_cap=rtstaff/population; rtpolice_cap=rtpolice/population; rthigh_cap=rthigh/population;run;
data real_02; set real_02; rtedu_cap=rtedu/population; rthous_cap=rthouscom/population; rtwelf_cap=rtwelf/population; rtfire_cap=tfire/population; rtstaff_cap=rtstaff/population; rtpolice_cap=rtpolice/population; rthigh_cap=rthigh/population;run;
data real_97; set real_97; rtedu_cap=rtedu/population; rthous_cap=rthouscom/population; rtwelf_cap=rtwelf/population; rtfire_cap=tfire/population; rtstaff_cap=rtstaff/population; rtpolice_cap=rtpolice/population; rthigh_cap=rthigh/population;run;

data com; set real_97 real_02 real_07 real_12; run;
data com_3Q; set com; where population>=60882; run;
 
proc sort data=com; by year4; run;
proc means data=com; var rtexp_cap rthealth_cap rtedu_cap rthous_cap rtwelf_cap rtfire_cap rtstaff_cap rtpolice_cap rthigh_cap; by year4; where population >=60882; run;
proc means data=com; var rthigh_cap; by year4; where population >=60882; run;

/* to detect counties without general purpose government */
data zeromuni; set com_3Q; where type2=0 ; run; 
data comgen_3Q; set com_3Q; if type2=1 then delete; run;
data comgen_3Q; set com_3Q; if type2=0 then delete; run; /* n=2989 was 3035 */


/* Create vertical fragmentation variable */
data comgen_3Q; set comgen_3Q; vfrag=speall/govall; run; 
data comgen_3Q; set comgen_3Q; spefrag=type4/govall; run; 
data comgen_3Q; set comgen_3Q; schfrag=type5/govall; run; 

proc glm data = comgen_3Q; class st year4;
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4 ;
model rthealth_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* positive/sig */
model rtedu_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* negative/ sig*/
model rthous_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* positive/insig */
model rtwelf_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* negative/ sig*/
model rtfire_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* positive/ sig at 0.1 */
model rtstaff_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* negative/ sig */
model rtpolice_cap = frag rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* positive/ sig */
model rthigh_cap = frag rmhi unempr povr population density_pop pblack year4  st / solution ; run;

/** general purpose vs special purpose **/
proc glm data = com_3Q; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4 ; /*neg/sig neg/insig*/
model rthealth_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4; /* neg/sig pos/sig*/
model rtedu_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4; /* neg/sig neg/sig */
model rthous_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4; /* neg/sig  neg/sig */
model rtwelf_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4; /* neg/sig neg/insig*/
model rtfire_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4; /* pos/ing neg/insig */
model rtstaff_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4; /* neg/sig neg/sig */
model rtpolice_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = com_3Q; class st year4; /* pos/sig pos/sig */
model rthigh_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4  st / solution ; run;

/* to test horizontal(gen) and vertical(spe) to compare with Goodman(2015) */
proc glm data = expsum_all; class st year4; 
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;

/* Test of vertical fragmentation measure by Goodman - mixed results */
data comgen_3Q; set comgen_3Q; spefrag=type4/govall; run; 
data comgen_3Q; set comgen_3Q; schfrag=type5/govall; run; 
proc glm data = comgen_3Q; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen spefrag schfrag rmhi unempr povr population density_pop pblack year4 st/ solution ; run;

proc means data=comgen_3Q; var rtexp_cap; where year4=1997; run;
proc means data=comgen_3Q; var rtexp_cap; where year4=2002; run;
proc means data=comgen_3Q; var rtexp_cap; where year4=2007; run;
proc means data=comgen_3Q; var rtexp_cap; where year4=2012; run;

/* model comparision by county population size etc */
proc glm data = exp.expsum_all; class st year4; /* all with frag*/ 
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; run;
proc glm data = exp.expsum_all; class st year4; /* all with fraggen and fragspe */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; run;
proc glm data = comgen_3Q; class st year4; /* 3Q after with frag */
model rtexp_cap = frag rmhi unempr povr population density_pop pblack year4 st/ solution ; run;
proc glm data = com_3Q; class st year4; /* 3Q before with fraggen and fragspe */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; run;
proc glm data = comgen_3Q; class st year4; /* 3Q after with fraggen and fragspe */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; run;

/* test of subgroups by population - NOT SIGNIFICANT */ 
proc glm data = comgen_3Q; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>=200000;run;
proc glm data = comgen_3Q; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; where 200000>population>=100000;run;
proc glm data = comgen_3Q; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; where population<100000;run;

data comgen_3Q; set comgen_3Q; rig=rig_exp_st+rig_exp_local+rig_exp_fed; run;

/* County indicator - POSITIVE SIGN */
proc glm data = comgen_3Q; class fips year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 fips/ solution ; run;
proc glm data = comgen_3Q; class fips year4 ; /*neg/sig neg/insig*/
model rthealth_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 fips / solution ; run;


/** BEST AS OF NOW!! - general purpose vs special purpose after deleting zero or one muni**/
proc glm data = comgen_3Q; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; run;
proc glm data = comgen_3Q; class st year4 ; /*neg/sig neg/insig*/
model rthealth_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* neg/sig pos/sig*/
model rtedu_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* neg/sig neg/sig */
model rthous_cap = fraggen fragspe rmhi unempr povr population density_pop pblack  year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* neg/sig  neg/sig */
model rtwelf_cap = fraggen fragspe rmhi unempr povr population density_pop pblack  year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* neg/sig neg/insig*/
model rtfire_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* pos/ing neg/insig */
model rtstaff_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* neg/sig neg/sig */
model rtpolice_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;
proc glm data = comgen_3Q; class st year4; /* pos/sig pos/sig */
model rthigh_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st / solution ; run;

data exp.comgen_3Q; set comgen_3Q; run;
data comgen_3Q; set exp.comgen_3Q; run;


/* Compare final data and data without zero or one numi */
proc means data=comgen_3Q; var rtexp_cap; run;
proc means data=com_3Q; var rtexp_cap; run;


/* Descriptive statistics for other spendings */
proc means data=comgen_3Q; var rthealth_cap rtedu_cap rthous_cap rtwelf_cap rtfire_cap rtpolice_cap rthigh_cap; run;
data zzz; set comgen_3Q; run;
proc sort data=zzz; by year4; run;
proc means data =comgen_3Q; var rtedu_cap; run;
proc means data=zzz; var rtedu_cap; run;
proc means data=zzz; var rtedu_cap;  by year4; run;
proc means data=zzz; var rtwelf_cap; by year4; run;
proc means data=zzz; var rtfire_cap; by year4; run;
proc means data=zzz; var rtpolice_cap; by year4; run;
proc means data=zzz; var rthigh_cap; by year4; run;


proc genmod data=comgen_3Q; 
class FIPS year4; model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = fips/ type=exch covb corrw modelse; run; quit;

proc means data=comgen_3Q; var fraggen fragspe; run;
proc means data=comgen_3Q; var rtexp_cap; run;


proc genmod data=comgen_3Q; 
class st year4; model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rthealth_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rtedu_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rthous_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rtwelf_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rtfire_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rtstaff_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rtpolice_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;
proc genmod data=comgen_3Q; 
class st year4; model rthigh_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4;
repeated subject = st/ type=exch covb corrw modelse; run; quit;



/*** Creating frag metric for special only (no school) - similar results ***/ 
data special; set comgen_3Q; frags=type4/population*1000; run;

proc glm data = special; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen frags rmhi unempr povr population density_pop pblack styear4 / solution ; run;
proc glm data = special; class st year4 ; /*neg/sig neg/insig*/
model rthealth_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4 / solution ; run;
proc glm data = special; class st year4; /* neg/insig pos/sig*/
model rtedu_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4/ solution ; run;
proc glm data = special; class st year4; /* neg/sig neg/sig */
model rthous_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4/ solution ; run;
proc glm data = special; class st year4; /* neg/sig  pos/sig */
model rtwelf_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4/ solution ; run;
proc glm data = special; class st year4; /* neg/sig neg/insig*/
model rtfire_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4/ solution ; run;
proc glm data = special; class st year4; /* pos/ing neg/sig */
model rtstaff_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4/ solution ; run;
proc glm data = special; class st year4; /* neg/sig neg/sig */
model rtpolice_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4/ solution ; run;
proc glm data = special; class st year4; /* pos/sig pos/sig */
model rthigh_cap = fraggen frags rmhi unempr povr population density_pop pblack st year4/ solution ; run;
/*** Creating frag metric for special only (no school) - similar results ***/ 


/*** Test after taking log - 041716 ***/
data log; set comgen_3Q; lnt=log(rtexp_cap); lnf=log(frag); lnfg=log(fraggen); lnfs=log(fragspe); lninc=log(rmhi); lnemp=log(unempr); lnpv=log(povr); lnpop=log(population); lnden=log(density_pop); lnb=log(pblack); run;
data logall; set exp.expsum_all; lnt=log(rtexp_cap); lnf=log(frag); lnfg=log(fraggen); lnfs=log(fragspe); lninc=log(rmhi); lnemp=log(unempr); lnpv=log(povr); lnpop=log(population); lnden=log(density_pop); lnb=log(pblack); run;

proc glm data = log; class st year4; /* neg/sig pos/sig */
model lnt = lnfg lnfs lninc  lnemp lnpv lnpop lnb st year4/ solution ; run;
proc glm data = logall; class st year4;
model lnt = lnfg lnfs lninc  lnemp lnpv lnpop lnb st year4/ solution ; run;


proc sgplot data=log; reg x=lnfs y=lnt;run;
proc sgplot data=comgen_3Q; reg x=fraggen y=rtexp_cap;run;


proc corr data=comgen_3Q; var rtexp_cap frag fraggen fragspe; run;
proc reg data=comgen_3Q; model rtexp = frag; run;
proc glm data = comgen_3Q; class st year4; model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st /solution; where population>300000; run;



/* % of general and special for vertical fragmentation - NOT GOOD */
data comgen_3Q; set comgen_3Q; pctgen=genall/govall; pctspe=speall/govall; run;
data comgen_3Q; set comgen_3Q; fragpctgen=pctgen/population; fragpctspe=pctspe/population; run;

 
proc means data = com_3Q; var type2; run; /* mean: 10.71 */
proc means data = comgen_3Q; var type2; run; /* mean: 10.71 */


/* spending by fraggen quartile */
proc univariate data=com_3Q; var fraggen; run;

data comgen_3Q; set comgen_3Q; if fraggen >=0.16738214 then q=4; run;
data comgen_3Q; set comgen_3Q; if 0.16738214 > fraggen >=0.07632306 then q=3; run;
data comgen_3Q; set comgen_3Q; if 0.07632306 > fraggen >=0.03588517 then q=2; run;
data comgen_3Q; set comgen_3Q; if 0.03588517 > fraggen  then q=1; run;

proc means data=comgen_3Q; var rtexp_cap; where fraggen<=0.03588517; run;

proc sort data=comgen_3Q; by q; run;
proc means data=comgen_3Q; var rtexp_cap; by q; run;
proc means data=comgen_3Q; var rthealth_cap; by q; run;
proc means data=comgen_3Q; var rtedu_cap; by q; run;
proc means data=comgen_3Q; var rthous_cap; by q; run;
proc means data=comgen_3Q; var rtwelf_cap; by q; run;
proc means data=comgen_3Q; var rtfire_cap; by q; run;
proc means data=comgen_3Q; var rtstaff_cap; by q; run;
proc means data=comgen_3Q; var rtpolice_cap; by q; run;
proc means data=comgen_3Q; var rthigh_cap; by q; run;


/* spending by fragspe quartile */
proc univariate data=com_3Q; var fragspe; run;
/*100% Max 1.15998795 
75% Q3 0.23258248 
50% Median 0.12606419 
25% Q1 0.06040927 */

data comgen_3Q; set comgen_3Q; if fragspe >=0.23258248 then qs=4; run;
data comgen_3Q; set comgen_3Q; if 0.23258248 > fragspe >=0.12606419 then qs=3; run;
data comgen_3Q; set comgen_3Q; if 0.12606419 > fragspe >=0.06040927 then qs=2; run;
data comgen_3Q; set comgen_3Q; if 0.06040927 > fragspe  then qs=1; run;

proc sort data=comgen_3Q; by qs; run;

proc means data=comgen_3Q; var rtexp_cap; by qs; run;
proc means data=comgen_3Q; var rthealth_cap; by qs; run;
proc means data=comgen_3Q; var rtedu_cap; by qs; run;
proc means data=comgen_3Q; var rthous_cap; by qs; run;
proc means data=comgen_3Q; var rtwelf_cap; by qs; run;
proc means data=comgen_3Q; var rtfire_cap; by qs; run;
proc means data=comgen_3Q; var rtstaff_cap; by qs; run;
proc means data=comgen_3Q; var rtpolice_cap; by qs; run;
proc means data=comgen_3Q; var rthigh_cap; by qs; run;

proc means data=com_3Q; var type2; run;

proc sgplot data=change_0712; reg x=fraggen y=rtexp_cap;run;
data log; set comgen_3Q; lnx=log(fraggen); lny=log(rtexp_cap); run;
proc sgplot data=log; reg x=lnx y=lny;run;

/* spending comparision - 04/15/16 - End */

/* 3Q statistics */
proc means data=comgen_3Q; var rtexp_cap; run;
proc means data=comgen_3Q; var rtexp_cap; where year4=1997; run;
proc means data=comgen_3Q; var rtexp_cap; where year4=2002; run;
proc means data=comgen_3Q; var rtexp_cap; where year4=2007; run;
proc means data=comgen_3Q; var rtexp_cap; where year4=2012; run;

proc means data=comgen_3Q; var rtexp_cap; where population>=200000;run;
proc means data=comgen_3Q; var rtexp_cap; where 200000>population>=100000;run;
proc means data=comgen_3Q; var rtexp_cap; where 100000>population;run;

/* Make a permanent final dataset */
data exp.comgen_3q; set comgen_3q; run;


/* Changes in spending */
/** between 2007 and 2012 **/
proc sql;
create table change as 
select fipsn, year4, frag, fraggen, fragspe, rmhi, unempr, povr, density_pop, pblack, st, rtexp_cap, rthealth_cap, rtedu_cap, rthous_cap, rtwelf_cap, rtfire_cap, rtstaff_cap, rtpolice_cap, rthigh_cap, population
from comgen_3Q
order by year, fipsn;
quit;

data change_07; set change; where year4=2007; run;
data change_12; set change; where year4=2012; run;
data change_12; set change_12; rtexp_cap_12=rtexp_cap; rthealth_cap_12=rthealth_cap; rtedu_cap_12=rtedu_cap; rthous_cap_12=rthous_cap; 
rtwelf_cap_12=rtwelf_cap; rtfire_cap_12=rtfire_cap; rtstaff_cap_12=rtstaff_cap; rtpolice_cap_12=rtpolice_cap; rthigh_cap_12=rthigh_cap ; run;
data change_12; set change_12; drop frag fraggen fragspe rmhi unempr povr density_pop pblack st rtexp_cap rthealth_cap rtedu_cap rthous_cap rtwelf_cap rtfire_cap rtstaff_cap rtpolice_cap rthigh_cap population; run;
proc sort data=change_07; by fipsn; run;
proc sort data=change_12; by fipsn; run;
data change_0712; merge change_07 change_12; by fipsn; run;
data change_0712; set change_0712; change_t=(rtexp_cap_12-rtexp_cap)/rtexp_cap; run; /* set with base on 2007 data */

proc corr data=change_0712; var frag fraggen fragspe change_t; run;
proc glm data=change_0712; model change_t=frag fraggen fragspe/ solution; run;
proc glm data=change_0712; model change_t=fraggen fragspe/ solution; run;
proc glm data=change_0712; class st ; model change_t = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st /solution; run;
proc reg data=change_0712; model change_t=fraggen fragspe;run;

proc sgplot data=change_0712; reg x=frag y=change_t ; run;
proc sgplot data=change_0712; reg x=fraggen y=change_t ;  run;
proc sgplot data=change_0712; reg x=fragspe y=change_t ; run;

proc means data=change_0712; var frag fraggen fragspe change_t; run;

proc corr data=expsum_all; var frag fraggen fragspe population rtexp_cap; run;
proc corr data=expsum_all; var frag fraggen fragspe population rtexp_cap; where population>=60882; run;
proc corr data=expsum_all; var frag fraggen fragspe population rtexp_cap; where population>=200000; run;

/** between 1997 and 2012 **/
proc sql;
create table change as 
select fipsn, year4, frag, fraggen, fragspe, rmhi, unempr, povr, density_pop, pblack, st, rtexp_cap, rthealth_cap, rtedu_cap, rthous_cap, rtwelf_cap, rtfire_cap, rtstaff_cap, rtpolice_cap, rthigh_cap, population
from comgen_3Q
order by year, fipsn;
quit;

data change_97; set change; where year4=1997; run;
data change_12; set change; where year4=2012; run;
data change_12; set change_12; rtexp_cap_12=rtexp_cap; rthealth_cap_12=rthealth_cap; rtedu_cap_12=rtedu_cap; rthous_cap_12=rthous_cap; 
rtwelf_cap_12=rtwelf_cap; rtfire_cap_12=rtfire_cap; rtstaff_cap_12=rtstaff_cap; rtpolice_cap_12=rtpolice_cap; rthigh_cap_12=rthigh_cap ; run;
data change_12; set change_12; drop frag fraggen fragspe rmhi unempr povr density_pop pblack st rtexp_cap rthealth_cap rtedu_cap rthous_cap rtwelf_cap rtfire_cap rtstaff_cap rtpolice_cap rthigh_cap population; run;
proc sort data=change_97; by fipsn; run;
proc sort data=change_12; by fipsn; run;
data change_9712; merge change_97 change_12; by fipsn; run;
data change_9712; set change_9712; change_t=(rtexp_cap_12-rtexp_cap)/rtexp_cap; run; /* set with base on 2007 data */

proc corr data=change_9712; var frag fraggen fragspe change_t; run;
proc glm data=change_9712; class st ; model change_t = fraggen fragspe rmhi unempr povr population density_pop pblack st /solution; run;
proc glm data=change_9712; model change_t = fraggen fragspe rmhi unempr povr population density_pop pblack /solution; run;




proc genmod data=exp_2012; 
class st; 
model rthealth_cap = frag rmhi unempr povr population density_pop pblack;
where population>=60882;
repeated subject = st/ type=exch covb corrw modelse; 
run; quit;




proc glm data = exp.expsum_all; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; where population>=200000; run;
proc glm data = exp.expsum_all; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; where 200000>population>=100000; run;
proc glm data = exp.expsum_all; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; where 100000>population>=50000; run;
proc glm data = exp.expsum_all; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; where population<50000; run;
proc glm data = exp.expsum_all; class st year4; /* neg/sig pos/sig */
model rtexp_cap = fraggen fragspe rmhi unempr povr population density_pop pblack year4 st/ solution ; run;




options nodate nonumber nocenter formdlim="-";
data hsb2;
  input  id female race ses prog
         read write math science socst;
datalines;
 70 0 4 1 1 57 52 41 47 57
121 1 4 2 3 68 59 53 63 61
 86 0 4 3 1 44 33 54 58 31
141 0 4 3 3 63 44 47 53 56
172 0 4 2 2 47 52 57 53 61
113 1 4 2 2 44 52 51 63 61
 50 0 3 2 1 50 59 42 53 61
 11 0 1 2 2 34 46 45 39 36
 84 0 4 2 1 63 57 54 51 63
 48 1 3 2 2 57 55 52 50 51
 75 1 4 2 3 60 46 51 53 61
 60 1 4 2 2 57 65 51 63 61
 95 0 4 3 2 73 60 71 61 71
104 0 4 3 2 54 63 57 55 46
 38 0 3 1 2 45 57 50 31 56
115 0 4 1 1 42 49 43 50 56
 76 0 4 3 2 47 52 51 50 56
195 0 4 2 1 57 57 60 56 52
;
run;

%let indvars = write math female socst;
proc means data = hsb2;
  var &indvars;
run;

proc reg data = hsb2;
  model read = &indvars;
run;
quit;

%put my first macro variable indvars is &indvars;

title "today's date is &SYSDATE9 and today is &SYSDAY";
proc means data = hsb2;
  var &indvarS;
run;

data expsum_all; set expsum_all; rmhit=rmhi*1000;run;
data exp.expsum_all; set expsum_all;run;



