// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo{
    // Инструкции - необходимы для проверки условий соблюдения каких-то действий
    // если не выполняется - транзакция отменяется и вызываемая ф-я быть выполнена не должна

    // require - по факту вызывает revert, но вся разница в том, что require принимает 2 значения, а revert всего 1
    // revert
    // assert - принимает одно выражение, которое представляет собой условное выражение 
    // и если это условие не выполняется, порождает ошибуц типа Panic
    // Обычно с помощью assert проверяют условия которые ни при каких обстоятельствах не должны выполняться

    address owner;

    // События - структура для сообщения окружению о том, что происходит внутри
    // indexed - метка, с помощью которой в журнале событий можно искать определенные поля, если они помечены этой меткой
    event Paid(address indexed _from, uint _amount, uint _timestamp); 

    // констркуция, которая вызывается один раз, при развертывании смарт контракта
    constructor() {
        owner = msg.sender;
    }

    // В журнал событий, который хранится вместе с блокчейном, будет записано новое события Paid со всеми аргуентами
    function pay() external payable{
        emit Paid(msg.sender, msg.value, block.timestamp);
    }

    // Solidity поддерживает написание собственных модификаторов, которые потом можно пристыковать к функции и использвать
    // модификатор для проверки является ли пользователь владельцем
    modifier onlyOwner(address _to){
        require(msg.sender == owner, "You are not an owner!");
        require(_to != address(0), "Incorrect address!");
        // строкчка, которая говорит о том, что необходимо выйти из модификатора и приступить к выполнению кода функции
        _;  
        //require(...);    
    }

    function withdraw(address payable _to) external onlyOwner(_to) {
        //Если условие не выполняется, программа останавливается и выдает сообщение
        //require(msg.sender == owner, "You are not an owner!");
        
        // if(msg.sender != owner)
        // {
        //     revert("You are not an owner!");
        // }
        
        // assert(msg.sender == owner);

        _to.transfer(address(this).balance);
    }
}