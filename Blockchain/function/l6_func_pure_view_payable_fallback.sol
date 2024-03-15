// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo{
    // Области видимости функций:
    // public - вызывать можно отовсюду, из вне контракта (со стороны клиента), или обращаться внутри него к этой функции

    // external - вызывать только из вне (например отправлять средства)
    // internal - вызывать только внутри контракта, а также к этой функции могут обращаться те контракты, которые данный
    // контракт с функцией наследуют

    // private - вызывать только внутри контракта, не от потомков

    // Модификаторы: 
    // view - функция может читать данные из блокчейна, но не модифицировать 
    // вызыввется через специальную команду call, за такой вызов клиент ничего не платит


    // pure - фактически то же самое что view, за одним исключением:
    // она вызывается через call, но не может читать никакие внешние данные

    string message = "Hello!";  //state - сохраняем ее в блокчейне
    uint public balance;

    // тип функции, который вызывается, если в смарт контракт просто прилетели деньги, и в транзакции нет
    // информации какую следует функцию выполнять 
    receive() external payable {  }
    
    // вызывается в том случае, если относительно смарт контракта была вызвана транзакция с неизвестным именем ф-ии (внутри смарт контракта)
    fallback() external payable { }

    // payable
    function pay() external payable {
        balance += msg.value;           // даже если функция не будет содержать ничего, и к ней обратятся с платежем, то
    }                                   // он пройдет и деньги зачислятся на баланс

    // transaction не подразумевают return
    function setMessage(string memory newMessage) external  {       // newMessage - временная переменная, которую мы записываем
        message = newMessage;                                       // в переменную state, т.е сохраняем newMessage в блокчейне
    }

    //call
    function getBalance() public view returns(uint balance) {
        balance = address(this).balance;                            // неявное возвращение указанное в returns - implicit
        //return balance;                                           // явное возвращение значения - explicit 
    }

    function getMessage() external view returns(string memory){     
        return message;
    }

    function rate(uint amount) public pure returns (uint){          // обычно pure используют для служебных функций, где
        return amount * 3;                                          // не нужно читать извне, а все небоходимые данные 
    }                                                               // передаются в эту ф-ю через аргументы


}