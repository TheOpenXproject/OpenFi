pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2; 

    
contract UserBudgetContract {
    // Budget context
    address owner;
    string[1][] txcat;
    string[] txids;
    string[] categories;
    uint ArraySize = 0;


    uint arrayLength=0;
    function initialize(address _owner) public{
        owner = _owner;
    }
    mapping(string => string) public mappedtxCategories;

    function setTxCategory(string memory _txid, string memory _cat) public {
        mappedtxCategories[_txid] = _cat;
        txids.push(_txid);
        categories.push(_cat);
    }
    function getContractAddr() public view returns (address){
        address thisaddr = address(this);
        return thisaddr;
    }
    function getAllCategories() public view returns (string[] memory){
        string[] memory _allcat = categories;
        return _allcat;
    }
    function getAllTxids() public view returns(string[] memory){
        string[] memory _alltx = txids;
        return _alltx;

    }


    function getTxCategory(string memory txid) public view returns(string memory)
    {
        string memory whereisit = mappedtxCategories[txid];
        return whereisit;
    }

}
