// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo{
    mapping (address => uint) public payments;  // storage переменная, которая хранится в блокчейне. 

    //address И mapping всегда хранятся в блокчейне, создавать временные нельзя

    address public myAddr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    function receiveFunds() public payable { 
        //value доступен только тогда, когда ф-я payable
        payments[msg.sender] = msg.value;
        
    }

    function transferTo(address payable targetAddress, uint amount) public {
        targetAddress.transfer(amount); // addr для перевода должен быть помечен как payable
    }

    function getBalance(address targetAddress) public view returns(uint){
        return targetAddress.balance;
    }

    string public myStr = "test";     // storage переменная, которая хранится в блокчейне. 
    // причем чем длиннее текст, да и в  целом размер хранимой памяти, тем дороже встанет деплой контракта

    function demo(string memory newValueStr) public{
        //string memory myTmpStr = "temp";    // временная переменная в памяти
        myStr = newValueStr;
    }
}