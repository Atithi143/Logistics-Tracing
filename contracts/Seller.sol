// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
// The seller's address 
contract Seller {
    address owner;
    uint product_id=1;
    uint order_id=1;

    struct Product {
        uint id;
        string name;
        string desc;
        bool sold;
        uint pprice;
        address buyer;
        uint timestamp;
    }

    struct Buyer {
        uint Orderid;
        string name;
        string addr;   
        uint phone;

    }
    struct Order {
        uint Productid;
        uint Orderid;
        string name;
        address addr;
        bool odd;
        uint pprice; 
    } 

    mapping (uint256 => Product) public Products;
    mapping (uint => Buyer) internal BuyerDetails;
    mapping (uint => Order) public Ods;
    Product[] public products_list;
    Product private productInfo;

    constructor(address _owner) {
    
        owner = _owner;
    }
    modifier onlySeller() {
        require(msg.sender == owner,"Not Seller");
        _;

    }   

    // Function to add prodcut
    function addProduct(string memory name,string memory desc, uint pprice) public
    {   
        
        productInfo=Product(product_id,name,desc,false,pprice,address(0),block.timestamp);
        Products[product_id]=(productInfo);
        products_list.push(productInfo);
        product_id++;

    }
    // Function to requeest Quote for products 
    function requestQuote(uint _ProductID) external view returns (uint, string memory, string memory, bool, address,uint) {
            
        require(Products[_ProductID].id > 0, "no product");
        require(_ProductID > 0 && _ProductID <=  product_id, "invalid Product_ID");

            return (Products[_ProductID].id,
            Products[_ProductID].name,
            Products[_ProductID].desc,
            Products[_ProductID].sold,
            Products[_ProductID].buyer,
            Products[_ProductID].timestamp);

    }

    
    function Buy(uint pID,address _Buyer,string memory _name,string memory _address,uint40 _phone) public payable returns (uint, address) {
            Products[pID].sold = true;
            Products[pID].buyer = _Buyer;
            uint toPay = Products[pID].pprice;
            //Ods[order_id] = Order(order_id,pID,Products[pID].name,toPay,_Buyer,true,false,false);
            BuyerDetails[order_id] = Buyer(order_id,_name,_address,_phone);
            order_id++;
            return (toPay, owner);
    }

    function fv(uint oid) external view returns (uint,string memory,string memory){
        return (Ods[oid].Productid,
        BuyerDetails[oid].addr,
        BuyerDetails[oid].name);
        // BuyerDetails[oid].ph);
}

    function sendInvoice(uint orderid) external view returns(uint,uint,string memory,uint,address)
     {     
        return (Ods[orderid].Productid,
        Ods[orderid].Orderid,
        Ods[orderid].name,
        Ods[orderid].pprice,
        Ods[orderid].addr);
    }

}