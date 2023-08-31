// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


import "./registration.sol";
import "./utils.sol";
import "./items.sol";



contract transaction is utils, registration,items {

     event PurchasOrderPlaced (bytes32 indexed PurchaseOrderID,address Buyer ,address Seller,string ipfs);
     event PurchaceOrderConfirmed (bytes32 indexed PurchaseOrderID,string ipfs);
     event ShippingInitiated (bytes32 indexed PurchaseOrderID,string ipfs);
     event PaymentInitiated (bytes32 indexed PurchaseOrderID,string ipfs);
     event PaymentRecived (bytes32 indexed PurchaseOrderID,string ipfs);

    modifier verifySeller(bytes32  id) {
        require(msg.sender == transactions[id].sender);
        _;
    }
     

    modifier verifyBuyer(bytes32  id) {
        require(msg.sender == transactions[id].sender);
        _;
    }
     
      

      function buyItem(
            string memory ipfs,
            address a,
            uint32 check
            ) public  
        {
        if (check==0 && (bytes(SeedProducer[a]).length==0) && (bytes(Farmer[msg.sender]).length==0) )  revert("SeedProducer does not exist");

        

        if (check==1 && ((bytes(Farmer[a]).length == 0)) && (bytes(Processor[msg.sender]).length==0))  revert("Farmer does not exist");

        if (check==2 && (bytes(Processor[a]).length == 0) && (bytes(Distributor[msg.sender]).length==0))  revert("Processor does not exist");
        
        if (check==3 && (bytes(Distributor[a]).length==0) && (bytes(Retailer[msg.sender]).length==0))  revert("Retailer does not exist");
     
        bytes32 id=keccak256(abi.encodePacked(a,check,ipfs,msg.sender));
        transactions[id].reciver = msg.sender;
        transactions[id].ipfs = ipfs;
        transactions[id].sender = a;
        emit PurchasOrderPlaced(id,msg.sender , a, ipfs);
    }

  function confirmItem(
        string memory ipfs,
        bytes32  id,
        string memory ipfsS,
        string memory ipfsR,
        string[] memory ipfsI,
        bytes32[] memory code,
        string memory itemType,
        uint32 check
    
    )
        public
    {   
        if (((msg.sender == transactions[id].sender))  ) revert("You are not permted to confirm this order");

       
        uint arr_length = code.length;
        for (uint i = 0; i < arr_length; i++) {
            updateItem(ipfsI[i], code[i], itemType);
        }
        if (check==0)  {
            updateSeedProducer(transactions[id].reciver, ipfsS);
            updateFarmer(msg.sender,ipfsR);
            transactions[id].ipfs = ipfs;
        }
        if (check==1)  {
            updateFarmer(transactions[id].reciver, ipfsS);
            updateProcessor(msg.sender,ipfsR);
            transactions[id].ipfs = ipfs;
        }
        if (check==2)  {
            updateDistributor(transactions[id].reciver, ipfsS);
            updateProcessor(msg.sender,ipfsR);
            transactions[id].ipfs = ipfs;
        }
        if (check==3)  {
            updateRetailer(transactions[id].reciver, ipfsS);
            updateDistributor(msg.sender,ipfsR);
            transactions[id].ipfs = ipfs;
        }
        emit PurchaceOrderConfirmed(id, ipfs);

     
      
    }

    function shippingInitiated(bytes32  id, string memory ipfs) public verifySeller(id) {
        
        transactions[id].shipStatus = ipfs;
    }

      function shippingReceived(bytes32  id, string memory ipfs) public verifyBuyer(id) {
  
        transactions[id].shipStatus = ipfs;
    }
    
    function paymentInitiated(bytes32  id, string memory ipfs) public verifyBuyer(id) {
        transactions[id].payHash = ipfs;
    }

    function paymentReceived(bytes32  id, string memory ipfs) public verifySeller(id) {
        transactions[id].payHash = ipfs;
    }



    
        



}