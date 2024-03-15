// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

// Merkle tree

contract Tree{
    // Массив хэшей, которые представляют собой древо
    bytes32[] public hashes;
    //                Hroot
    //             H12      H34
    //            H1  H2  H3  H4
    // Транзакции TX1 TX2 TX3 TX4
    string[4] transactions = [
        "TX1: John -> Wick",
        "TX2: Wick -> Allice",
        "TX3: Allice -> Cooper",
        "TX4: Cooper -> Head"
    ];

    constructor() {
        for(uint i = 0; i < transactions.length; i++)
        {
           hashes.push(makeHash(transactions[i]));  //H1, H2, H3, H4 - хэш от четырех транзакций (лепестки)
        }

        uint count = transactions.length;
        uint offset = 0;

        while(count > 0)
        {
            for(uint i = 0; i < count - 1; i += 2)
            {
                hashes.push(keccak256(
                    abi.encodePacked(
                        hashes[offset + i], hashes[offset + i +1] 
                        )
                    )
                );
            }    
            offset += count;
            count = count / 2;
        }
    }

    function verify(string memory transaction, uint index, bytes32 root, bytes32[] memory proof) public pure returns(bool){

        //  "TX3: Allice -> Cooper"
        //  2
        //  0xbae76f71c336ab4a6c01008ea4be0920e37e0fa7a7f98bfd4d8762f1dad8c661
        //  0x899642b2f8b43927a4c52e8f1fc70b75ba7ab04a5c71a469da90d55d8f9cb684
        //  0xdfb8cf2a929df1c16028415eb1ba26d164a2399b38f5f9f434d00d114354ee5e

        /* Если пронумировать хэши от листьев до корня, то можно заметить следующую закономерность:
        Если номер хэша четный - чтобы найти вышестоящий хэш необходимо брать следующий элемент уровня
        
        Если номер хэша нечетный - чтобы найти вышестоящий хэш необходимо брать предыдущий элемент уровня
        */

        bytes32 hash = makeHash(transaction);
        for(uint i = 0; i < proof.length; i++)
        {
            bytes32 element = proof[i];
            if(index % 2 == 0)
            {
                hash = keccak256(abi.encodePacked(hash, element));
            }
            else 
            {
                hash = keccak256(abi.encodePacked(element, hash));
            }
            index /= 2;
        }
        return hash == root;

    }

    function encode(string memory input) public pure returns (bytes memory){
        return abi.encodePacked(input);
    }

    function makeHash(string memory input) public pure returns(bytes32)
    {
        //keccak256 - ф-я предназначеная для возврата хэша от значения, возвращает bytes32
        return keccak256(
            encode(input)
        );
    }
}