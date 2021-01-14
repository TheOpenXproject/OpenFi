pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2; 
    contract Ownable {
  address public owner;

  constructor() internal{
    owner = msg.sender;
  }

  modifier onlyOwner() {
    if (msg.sender == owner)
      _;
  }

   function transferOwnership(address newOwner) onlyOwner public{
    if (newOwner != address(0)) owner = newOwner;
  }

}
    
    contract UserBudgetContract is Ownable{
    // Budget context
    string[1][] txcat;
   
    uint arrayLength=0;
    
    mapping(string => string) public mappedtxCategories;
    
    function setTxCategory(string[2] memory _txid_cat) public payable {
        mappedtxCategories[_txid_cat[0]] = _txid_cat[1];
       
       // mappedtxCategories[txid] = arrayLength;
      
    }

         function initialize(address _owner) public  {
              Ownable(_owner);
    }

    function getTxCategory(string memory txid) public returns(string memory)
    {
        string memory whereisit = mappedtxCategories[txid];
        return whereisit;
    }
    
}
    