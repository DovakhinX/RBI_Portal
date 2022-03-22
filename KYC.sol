// SPDX-License-Identifier:GPL-3.0

pragma solidity^0.8.7;
contract RBI_PORTAL{

//INITIALISE ADMIN-(FOR ADMIN ONLY FUNCTIONS)

address admin;

//STRUCT WITH CUSTOMER DETAILS

struct user_details{
string Name;
uint Aadhar_No;
uint Mobile_No;
bool Verified;
}

//STRUCT WITH BANK DETAILS

struct bank_details{
string bankName;
bool kyc;
bool addcust;
}

//MAPPING CUSTOMER DETAILS WITH UNIQUE ID

mapping(address=>user_details) user;

//MAPPING BANK DETAILS WITH UNIQUE ID

mapping(address=>bank_details) bank;

//ADMIN SETTER

constructor(){
admin=msg.sender;
}

//ADD BANK

function ADD_BANK(string memory Bank_Name,address Bank_id)public {
bool kyc=true;
bool addcust=true;
if (admin==msg.sender){
bank[Bank_id]=bank_details(Bank_Name,kyc,addcust);
}
}

//ADD KYC REQUEST 

function ADD_KYC_REQUEST(address Bank_id,address Cust_id,string memory
Name,uint Aadhar_No,uint Mobile_No )public {
bool Verified;
if(bank[Bank_id].kyc==true ){
user[Cust_id]=user_details(Name,Aadhar_No,Mobile_No,Verified);
}
}
//KYC VERIFIED & ADD CUSTOMER

function VERIFY_ADD_CUSTOMER( address Cust_id,address Bank_id)public {
if(bank[Bank_id].addcust==true ){
user[Cust_id].Verified=true;
}
}

//KYC STATUS CHECK

function KYC_CHECK(address Cust_id)public view returns(string memory stat){
if(user[Cust_id].Verified==true){
stat="KYC COMPLETE";
return stat;
}else{
stat="KYC PENDING";
return stat;
}
}
//CHANGE KYC PERMISSION TO NO

function REMOVE_KYC_PERMISSION(address Bank_id)public {
if (admin==msg.sender){
bank[Bank_id].kyc=false;
}
}

//CHANGE KYC PERMISSION TO YES

function ALLOW_KYC_PERMISSION(address Bank_id)public {
if (admin==msg.sender){
bank[Bank_id].kyc=true;
}
}

//CHANGE ADD CUSTOMER PERMISSION TO NO

function REMOVE_ADDCUST_PERMISSION(address Bank_id)public {
if (admin==msg.sender){
bank[Bank_id].addcust=false;
}
}

//CHANGE ADD CUSTOMER PERMISSION TO YES

function ALLOW_ADDCUST_PERMISSION(address Bank_id)public {
if (admin==msg.sender){
bank[Bank_id].addcust=true;
}
}

//GET CUSTOMER DATA

function VIEW_CUSTOMER_DATA(address Cust_id)public view returns(string memory
Name,uint Aadhar_No,uint Mobile_No){
if(user[Cust_id].Verified==true){
return(user[Cust_id].Name,user[Cust_id].Aadhar_No,user[Cust_id].Mobile_No);
}
}
