// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./Seller.sol";
import "./Freight.sol";

contract Buyer {
    address seller;
    Seller s;
    address freight;
    Freight f;
    constructor (address _seller, address _freight){
        seller = _seller;
        s = Seller(_seller);
        freight = _freight;
        f = Freight(_freight);
    }

    function requestQuote(uint _ProductId) public view returns (uint,string memory, string memory, bool, address,uint){
        return s.requestQuote(_ProductId);
    }

    function Buy(uint ProductId, string memory name, string memory addr, uint40 phone) public payable{
        address _Buyer = msg.sender;
        (uint num, address _seller) = s.Buy(ProductId,_Buyer, name,addr,phone);
        require(msg.value == num, "Low Fund");
        (bool success,) = (_seller).call{value: msg.value}("");
        require(success , "Buy Failed");
    }

    function getInvoice(uint Orderid) external view returns(uint,uint,string memory, uint, address){
        return s.sendInvoice(Orderid);
    }
}
