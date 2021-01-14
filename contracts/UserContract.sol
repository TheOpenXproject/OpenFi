pragma solidity >=0.4.22 <0.8.0;
pragma experimental ABIEncoderV2;

contract UserFactory  {
  
  mapping(address => address) public usercontract;
  

  function createUser() payable public {
      if(usercontract[msg.sender] == address(0x0000000000000000000000000000000000000000))
      {
          User newContract = new User();
            usercontract[msg.sender] = newContract.getContractAddr();
      }
      else
      {
          revert("user already exists");
      }

  }
  function getUserContractAddress() public view returns (address){
        return usercontract[msg.sender];
    }
}


contract User {
    address public disAddress;
    constructor() public {
       disAddress = address(this);
        
    }
    
    function getContractAddr() public view returns (address){
        
        return address(this);
    }
    
        /*
    // Budget context
    string[1][] txcat;
   
    uint arrayLength=0;
    
    mapping(string => string) public mappedtxCategories;
    
    function setTxCategory(string[2] memory _txid_cat) public payable {
        mappedtxCategories[_txid_cat[0]] = _txid_cat[1];
       
       // mappedtxCategories[txid] = arrayLength;
      
    }

    function getTxCategory(string memory txid) public returns(string memory)
    {
        string memory whereisit = mappedtxCategories[txid];
        return whereisit;
    }
    
    */
    
    
    
    
}