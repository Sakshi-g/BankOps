// SPDX-License-Identifier: MIT
// Sakshi Gadegaonkar
pragma solidity ^0.8.0;
 
contract SakshiGadegaonkarBank {
    mapping (address => uint) private customer;
    address public manager;
    uint private minimumBalance;
    uint private noOfCustomers;
 
    constructor() {
        minimumBalance = 1000 wei;
        manager = msg.sender;
    }
   
    modifier onlyManager(){
        require (msg.sender == manager, "You do NOT have access");
        _;
    }
 
    function checkBankBalance() public view onlyManager returns(uint){
        return address(this).balance;
    }
 
    function checkActiveCustomers() public view onlyManager returns(uint){
        return noOfCustomers;
    }
 
    function checkBalance() public view returns(uint){
        return customer[msg.sender];
    }
 
    function deposit() public payable{
        require(msg.value >= minimumBalance, "Minimum Balance Required");
 
        if (customer[msg.sender] == 0){
            noOfCustomers++;
        }
        customer[msg.sender] += msg.value;
    }
 
    function transfer(address _recipient, uint money) public{
        require(customer[msg.sender] - money >= minimumBalance, "Minimum Balance Required");
        address payable recipient = payable(_recipient);
        recipient.transfer(money);
        customer[msg.sender] -= money;
    }
 
    function closeAccount() public{
        require(customer[msg.sender] > 0, "Account doesn't exist, verify your account number");
        address payable recipient = payable(msg.sender);
        uint money = customer[msg.sender];
        recipient.transfer(money);
        customer[msg.sender] -= money;
        noOfCustomers -= 1;
    }
}
