//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "./Buyer.sol";
import "./Seller.sol";

contract Freight{
    Buyer b;
    address freightAcc;
    Seller s;
    uint ExpoCount = 1;
    uint fc = 10;

    struct ProductDetails{
        uint exportId;
        uint orderId;
        uint productId;
        bool exportclr;
        bool importclr;
        bool delivered;
    }
    struct freightBook{
        uint orderid;
        uint productid;
        string name;
        string addr;
        
    }
    mapping (uint => freightBook) internal FBooks;
    mapping (uint => ProductDetails) public ProdDetails;

    constructor (address addr){
        freightAcc = addr;
    }

    modifier onlyFreight(){
        require(msg.sender == freightAcc, "this is not freight");
        _;
    }
    function bookFreight(uint orderid, address seller) external returns (bool,uint,address){
        s = Seller(seller);
        (uint productid,string memory addr,string memory name) = s.fv(orderid);
        FBooks[orderid] = freightBook(orderid,productid,name,addr);
        return (true,fc,freightAcc);
    }

    function exportClearance(uint exportId) public onlyFreight{
        ProdDetails[exportId].exportclr = true;
    }

    function importClearance(uint _exportid) public onlyFreight{
        ProdDetails[_exportid].importclr = true;
        ProdDetails[_exportid].delivered = true;
    }
}