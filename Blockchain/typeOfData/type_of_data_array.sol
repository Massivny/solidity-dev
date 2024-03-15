// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo{
    //Struct
    struct Payment {
        uint amount;
        uint timestamp;
        address from;
        string message;
    }

    struct Balance{
        uint totalPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) balances;

    function payPublic(string memory message) public payable{   
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;

        //Создадим временный платеж, который запишем в постоянную структуру данных
        //Которая хранится в блокчейне, т.е он станет постоянным

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );

         balances[msg.sender].payments[paymentNum] = newPayment;
    }

    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }   

    // //Byte
    // bytes32 public myVar = "test";
    // // 1 --> 32 bytes
    // // 32 * 8 = 256 bit

    // bytes public myDynVar = "test";

    // function lengthMeasure() public view returns(bytes1) {
    //     return myDynVar[0];
    // }

    //Array
    // uint[10] public items = [1, 2, 3];

    // uint[3][2] public item;
    // // 5 - общий размер массива, 10 - размер вложенного массива

    // uint[] public mass;     // объявление динамического массива
    // uint public len;

    // function din() public {
    //     mass.push(4);   //push только для динамического массива
    //     mass.push(5);   //т.к. push динамически mass.lenght++
    //     len = mass.length;
    // }

    // function sampleMemory() public view returns(uint[] memory) {
    //     uint[] memory tempArray = new uint[](10); // массив в памяти
    //     tempArray[0] = 1;
    //     return tempArray;
    // }

    // function dvumern() public {
    //     item = [
    //         [3,4,5],
    //         [6,7,8]
    //     ];
    // }

    // function demo() public{
    //     items[0] = 100;
    //     items[1] = 200;
    //     items[4] = 400;
    // }

    // //Enum 
    // enum Status { Paid, Delivered, Received }
    // Status public currentStatus;

    // /* По умолчанию currentStatus имеет значение первого элемента структуры,
    //    то есть 0, что соответствует состоянию Paid*/

    // function pay() public{
    //     currentStatus = Status.Paid;
    // }

    // function delivered() public {
    //     currentStatus = Status.Delivered;
    // }
}