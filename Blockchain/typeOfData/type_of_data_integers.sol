// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo{

    uint public minimum;
    uint public maximum;

    function demo() public{
        minimum = type(uint8).min;
        maximum = type(uint8).max;
    }

    uint8 public myVal = 254;

    function inc () public {
        unchecked{      // ф-я для отлавливания ошибок переполнения  при достижении 
            myVal++;    // max/min переменной начинает ее счет с минимального значения
        }
    }
    // bool public myBool = true ; //state - переменная состояния (сохранится в блокчейн, не временная переменная)
    //              //имя переменной с мальенькой буквы, все остальные с Большой без пробелов, тире, полчеркиваний
    
    // function myFunc(bool _inputBool) public{
    //     bool localBool = false; // temp - хранится в памяти локально, как и _inputBool
    //     localBool && _inputBool
    //     localBool || _inputBool
    //     localBool == _inputBool
    //     localBool != _inputBool
    //     !localBool
    // }
    //unsigned int
    // uint256 public myUint = 55;
    // // 256 bit 0 || 1 => 2^256 = 1,1579208923731619542357098500869e+77 - макс возможное число для записи
    
    // uint8 public mySmallUint = 2;
    // // 8bit  0 || 1 => 2^8 = 256 => 0-255 для записи

    // //signed int
    // int256 public myInt = -42;
    // int8 public mySmallInt = -1;
    // // 1 bit знаковый => 2^7 = 128 => -128-127 для записи


    // function demo (uint _inputUint) public {
    //     uint localUint = 52;
    //     localUint + 1;
    //     localUint - 1;
    //     localUint * 2;
    //     localUint / 2;
    //     localUint ** 3;
    //     localUint % 3 ;
    //     -myInt; // -(-42) = 42


    // }
}