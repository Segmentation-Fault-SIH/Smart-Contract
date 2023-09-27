// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract RescueHub {

    struct Volunteer {
        string id;
        string name;
        bool isVerified; // Added isVerified attribute
    }
mapping(uint256 => Volunteer) public volunteersList;
modifier onlyAdmin() {
        require(isAdmin(msg.sender), "Only admin can perform this action");
        _;
    }
uint256 public verificationReward = 0.00001 ether; 
//struct for post


 
  
    constructor() payable {
        // Initialize the contract with 1 ether
        //require(msg.value == 1 ether, "You must send 1 ether to initialize the contract");
    }

    receive() external payable {}
    fallback() external payable {}

  //  mapping(uint256 => Post) public posts;
    uint256 public postCount = 0;
    uint256 public disasterCount = 0;
    uint256 public volunteerCount = 0;
    address[] public admin = [0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,
    0x742A5a2f33886E4527052F913274547D2d5A0044,
    0x7210e0a15F105E0a4cd5027683a436FDb1a45dDA,
    0xB11C1915f2cf870596B6Bae501C2ca84Bd0F68a8
    ,0xB9eF15e56A39fAc2a66431d88c7ef950652e6560,0x936F3348c3035ea5530F0d959272DC6cC0402C44,
    0x91f6C69e532F199c4Fde2fb5F23456D505a7DaD5];




    function createVolunteer( string memory _id,
        string memory _name) public returns(uint256){
    Volunteer  storage  volunteer  = volunteersList[volunteerCount];
    volunteer.id = _id;
    volunteer.name = _name;
    volunteerCount++;
    return volunteerCount -1;
        }


function addAdmin(address _admin) public returns(bool){
    admin.push(_admin);
    return true;
}

function sendETHtoContract(uint amount) public payable{
    (bool sent, ) = (address(this)).call{value: amount}("");
        require(sent, "Failed to send Ether");
}




function transfer(address payable to , uint256 amount)public payable{
      (bool sent, ) = to.call{value: amount}("");
        require(sent, "Failed to send Ether");
}
function updateAdmin(address adminAddress) public returns(bool){
    for(uint i=0 ; i<admin.length ; i++){
        if(msg.sender == admin[i]){
            admin.push(adminAddress);
            return true;
        }
    }
    return false;
}

function isAdmin(address _address) public view returns(bool){
    for(uint i=0 ; i<admin.length ; i++){
        if(_address == admin[i]){
            return true;
        }
    }
    return false;
}



 function approveVolunteer(uint256 volunteerId) public onlyAdmin {
        Volunteer storage volunteer = volunteersList[volunteerId];
        require(!volunteer.isVerified, "Volunteer is already verified");

        volunteer.isVerified = true;

        // Transfer a small amount of cryptocurrency to the volunteer
        payable(address(uint160(bytes20(keccak256(abi.encodePacked(volunteer.id)))))).transfer(verificationReward);
    }
    
        
    


}
