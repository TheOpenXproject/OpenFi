pragma solidity >=0.5.0;
pragma experimental ABIEncoderV2;

import "./MoonDust.sol";
//test contract to manage Verified tokens on harmony


contract TokenTruth{
    address _owner;
     address[] tokenAddr;
     string[] tokenName;
     string[] tokenSymbol;
     uint[] decimals;
     string[] tokenImg;
     
     uint index;
     mapping(string => uint) indexByName;
     mapping(string => string) imageBySymbol;
     mapping(address => address) validatedcheck;
     address[] pendingTokenContractAddresses;
     mapping(string => address) contractAddrByName;
     uint pendingTokenContractCount;
     //addr name symb decimals image upvotes downvotes address of proposer
     
     constructor() public{
         _owner = msg.sender;
     }
     
     
    modifier onlyAdmin(address _account)
    {
        require(
            msg.sender == _owner,
            "Sender not authorized."
        );
        _;
    }
    
        modifier onlyAuthorised(address _account)
    {
        MoonDust Authtoken = MoonDust(0xAD57d111725f093B2B7C25BAf792a2F3d68DCB68);
        
        require(
           Authtoken.balanceOf(_account) > 100000000,
            "Sender not authorized."
        );
        _;
    }
    
     
     function propose_token(address _tokenAddr,string memory _tokenName, string memory _tokenSymbol, uint _decimals,string memory _tokenImg) public{
         if(validatedcheck[_tokenAddr] == address(0x0000000000000000000000000000000000000000)){
         ProposeToken _proposal = new ProposeToken(_tokenAddr, _tokenName, _tokenSymbol, _decimals, _tokenImg);
         validatedcheck[_tokenAddr] = _tokenAddr;
         address _proposal_address = _proposal.getContractAddr();
         pendingTokenContractAddresses.push(_proposal_address);
         contractAddrByName[_tokenName] = _proposal_address; 
         indexByName[_tokenName] = pendingTokenContractCount;
         pendingTokenContractCount++;
         }
        else{
             revert("Token already Submited");
         }
     }
     
     function vote_token(bool _vote,string memory _tokenName) onlyAuthorised(msg.sender) public{
         
        address _proposal_address  = contractAddrByName[_tokenName];
        ProposeToken vote = ProposeToken(_proposal_address);
        vote.vote(_vote, msg.sender);//bad programing example
     }
     
     function get_all_proposals() public view returns(address[] memory){
         return pendingTokenContractAddresses;
     }
     function get_all_verified_tokens()public view returns(address[] memory,string[] memory,string[] memory,uint[] memory,string[] memory,uint){
         return(tokenAddr,tokenName,tokenSymbol,decimals,tokenImg,index);
     }
     function validate_token(string memory _tokenName) onlyAdmin(msg.sender) public{
            address _proposal_address  = contractAddrByName[_tokenName];
            ProposeToken validate = ProposeToken(_proposal_address);
            address _tokenAddr = validate.getaddr();
            string memory _tokenSymbol = validate.getsymbol();
            uint _decimals = validate.getdecimal();
            string memory _tokenImg = validate.getimg();
            tokenAddr.push(_tokenAddr);
            tokenName.push(_tokenName);
            tokenSymbol.push(_tokenSymbol);
            decimals.push(_decimals);
            tokenImg.push(_tokenImg);
            index++;
     }
     function remove_proposed_contract(string memory _tokenName) public onlyAuthorised(msg.sender){
        address _proposal_address  = contractAddrByName[_tokenName];
        ProposeToken deletecontract = ProposeToken(_proposal_address);
        deletecontract.finalize();
        
        uint _index = indexByName[_tokenName];
        delete pendingTokenContractAddresses[_index];
        delete contractAddrByName[_tokenName];

        pendingTokenContractCount--;
        
     }
     

     
     
}

contract ProposeToken{
    address _owner;
    address tokenAddr;
    string tokenName;
    string tokenSymbol;
    uint decimals;
    string tokenImg;
    uint index;
    uint approvals; 
    uint unapprovals;
    uint proposedTS;
    mapping(address => address) voted_addresses;
     
     //addr name symb decimals image upvotes downvotes address of proposerk
     
    modifier onlyAdmin(address _account)
    {
        require(
            msg.sender == _owner,
            "Sender not authorized."
        );
        _;
    }
        modifier only1weekafter()
    {
        require(
            proposedTS + 604800 < now ,
            "minimum time has not elapsed yet."
        );
        _;
    }

     
     constructor (address _tokenAddr,string memory _tokenName, string memory _tokenSymbol, uint _decimals,string memory _tokenImg) public{
        _owner = msg.sender;
        tokenAddr = _tokenAddr;
        tokenName =  _tokenName;
        tokenSymbol = _tokenSymbol;
        decimals = _decimals;
        tokenImg = _tokenImg;
        index++;
        approvals = 0;
        unapprovals = 0;
        proposedTS = now; 
         
         
     }
     function vote(bool _vote, address _voter) onlyAdmin(msg.sender) public{
         if(voted_addresses[_voter] == address(0x0000000000000000000000000000000000000000))
         {
         if(_vote){
             voted_addresses[_voter] = _voter;
             approvals++;
         }
         else{
             voted_addresses[_voter] = _voter;
             unapprovals++;
         }
         }
         else{
             revert("user already voted");
         }
         
     }
     function getsymbol() public view returns(string memory){
         return tokenSymbol;
         
     }
          function getaddr() public view returns(address){
         return tokenAddr;
         
     }
          function getdecimal() public view returns(uint){
         return decimals;
         
     }
          function getimg() public view returns(string memory){
         return tokenImg;
         
     }
    function getTokenDetails() public view returns(address,string memory,string memory,uint,string memory){
        address _tokenAddr = tokenAddr;
        string memory _tokenName = tokenName;
        string memory _tokenSymbol = tokenSymbol;
        uint _decimals =  decimals;
        string memory _tokenImg = tokenImg;
        return (_tokenAddr, _tokenName, _tokenSymbol, _decimals,_tokenImg);
    }
    function getStatus() public view returns(uint,uint){
        return (approvals,unapprovals);
    }
    function getContractAddr() public view returns (address){
        address thisaddr = address(this);
        return thisaddr;
    }
    function finalize() public onlyAdmin(msg.sender) only1weekafter{
        address payable destroyer = 0xB02FbF1986D308A7C4E6626D5a7673DC09646dfe;
        selfdestruct(destroyer);
    }
     
}