// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract registration{

    address owner=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    mapping(address=>string) SeedProducer; 
    mapping(address=>string) Farmer; 
    mapping(address=>string) Processor; 
    mapping(address=>string) Distributor;
    mapping(address=>string) Retailer; 
    mapping(address=>string) Consumer; 

    event updated(address a, string  ipfshash);
    
    modifier onlyOwner {
       require(msg.sender == owner);
       _;
    }

    function addSeedproducer(address a, string memory ipfshash) onlyOwner public {
        require(bytes(SeedProducer[a]).length!=0,
        "Farmer exists already"
        );
        SeedProducer[a] = ipfshash;
        emit updated (a ,ipfshash);
    }

    function addFarmer(address a, string memory ipfshash) onlyOwner public {
        require(bytes(Farmer[a]).length!=0,
        "Farmer exists already"
        );
        Farmer[a] = ipfshash;
        emit updated (a ,ipfshash);
    }

    function addProcessor(address a, string memory ipfshash) onlyOwner public {
         require(bytes(Processor[a]).length!=0,
        "processor exists already"
        );
        Processor[a] = ipfshash;
        emit updated (a ,ipfshash);
    }

    function addDistributor(address a, string memory ipfshash) onlyOwner public {
         require(bytes(Distributor[a]).length!=0,
        "Distributor exists already"
        );
        Distributor[a] = ipfshash;
        emit updated (a ,ipfshash);
    }

    function addRetailer(address a, string memory ipfshash) onlyOwner public {
         require(bytes(Retailer[a]).length!=0,
        "Retailer exists already"
        );
        Retailer[a] = ipfshash;
        emit updated (a ,ipfshash);
    }

    function addConsumer(address a, string memory ipfshash) onlyOwner public {
         require(bytes(Consumer[a]).length!=0,
        "Consumer exists already"
        );
        Consumer[a] = ipfshash;
        emit updated (a ,ipfshash);
    }

    function seedproducerExists(address a) public view returns(string memory) {
        if( !(bytes(SeedProducer[a]).length==0)){
            return "Does not exists";
        }
        return SeedProducer[a];
    }

    function farmerExists(address a) public view returns(string memory) {
        if( !(bytes(Farmer[a]).length==0)){
            return "Does not exists";
        }
        return Farmer[a];

    }

    function processorExists(address a) public view returns(string memory) {
        if( !(bytes(Processor[a]).length==0)){
            return "Does not exists";
        }
        return Processor[a];
    }

    function distributorExists(address a) public view returns(string memory) {
        if( !(bytes(Distributor[a]).length==0)){
            return "Does not exists";
        }
        return Distributor[a];
    }

    function retailerExists(address a) public view returns(string memory) {
        if( !(bytes(Retailer[a]).length==0)){
            return "Does not exists";
        }
        return Retailer[a];
    }

    function consumerExists(address a) public view returns(string memory) {
        if( !(bytes(Consumer[a]).length==0)){
            return "Does not exists";
        }
        return Consumer[a];
    }

    function updateSeedProducer(address a,string memory ipfs) internal{ 
        SeedProducer[a]=ipfs;
        emit updated (a ,ipfs);
    }

    function updateFarmer(address a,string memory ipfs) internal{
        Farmer[a]=ipfs;
        emit updated (a ,ipfs);
    }

    function updateProcessor(address a,string memory ipfs) internal{
        Processor[a]=ipfs;
        emit updated (a ,ipfs);
    }

    function updateRetailer(address a,string memory ipfs) internal{
        Distributor[a]=ipfs;
        emit updated (a ,ipfs);
    }

    function updateDistributor(address a,string memory ipfs) internal{
        Retailer[a]=ipfs;
        emit updated (a ,ipfs);
    }
}



