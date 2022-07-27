// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract BuyMeACoffee {
    
    // Event to emit when a memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );


    //Memo struct or object
    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }

    //List of all memos 
    Memo[] memos;

    //Address of cotrcat deployer
    address payable owner;

    //Constructor is run once when the contract is deployed
    constructor (){
        //we can set the owner address using the msg.sender method, we need to set is as payable too
        owner = payable (msg.sender); 
    }

    /**
    * @dev buy a coffee for contract owner
    * @param _name of the coffee buyer
    * @param _message a nice message for the coffee buyer
     */

     //memory keyword saves us some gas
    //payable allows the an address to receive money
     function  buyCoffee(string memory _name, string memory _message) public payable {

        require (msg.value > 0 , "Cant buy coffee with 0 eth");
        memos.push(
            Memo(
                msg.sender,
                block.timestamp,
                _name,
                _message
            )
        );

        //emit a log event when a new memo is created
        emit NewMemo(
                msg.sender,
                block.timestamp,
                _name,
                _message
            );





        
     }

     function withdrawTips () public {
        require (owner.send(address(this).balance));
        
     }

     function getMemos () public view returns (Memo[] memory){
        return memos; 

     }





}