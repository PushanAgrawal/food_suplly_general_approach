// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract items {


    mapping(bytes32=>string) item;
    
    event newItem (bytes32 indexed code , address a , string itemType, string ipfs);
    event updateitemDetails (bytes32 indexed code , address a, string itemType, string indexed ipfs);
    
    function addItem(string memory ipfs,  string memory itemType) public {
        bytes32 code = keccak256(abi.encodePacked(ipfs,itemType));
        item[code]=ipfs;    
        emit newItem(code, msg.sender, itemType, ipfs);    
    }
    function updateItem(string memory ipfs, bytes32 code,string memory itemType) internal  {
        item[code]=ipfs; 
        emit updateitemDetails(code, msg.sender, itemType, ipfs);    


                   
    }
}