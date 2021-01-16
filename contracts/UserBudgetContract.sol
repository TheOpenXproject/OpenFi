pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2; 

    
    contract UserBudgetContract {
    // Budget context
    address owner;
    string[1][] txcat;
   
    uint arrayLength=0;
             function initialize(address _owner) public  {
              owner = _owner;
    }
    mapping(string => string) public mappedtxCategories;
    
    function setTxCategory(string[2] memory _txid_cat) public payable {
        mappedtxCategories[_txid_cat[0]] = _txid_cat[1];
       
       // mappedtxCategories[txid] = arrayLength;
      
    }
    function getContractAddr() public view returns (address){
        
        return address(this);
}

    function getTxCategory(string memory txid) public returns(string memory)
    {
        string memory whereisit = mappedtxCategories[txid];
        return whereisit;
    }
    
}
    