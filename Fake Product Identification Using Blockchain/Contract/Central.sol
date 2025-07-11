//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Company.sol";

contract Central {
    address[] walletAddresses;

    mapping(address => address) walletAddressToSmartContractAddress;
    mapping(address => string) public companyNames;
    mapping(address => uint256) public companyCreationTime;

    
    event CompanyCreated(address owner, address contractAddress, string companyName);
    event ProductAdded(address companyAddress, address ownerAddress);

    function createSmartContract(string memory _companyName) public {
        require(walletAddressToSmartContractAddress[msg.sender] == address(0), "Already registered");

        Company companyContract = new Company(msg.sender);
        walletAddresses.push(address(companyContract));
        walletAddressToSmartContractAddress[msg.sender] = address(companyContract);
        companyNames[msg.sender] = _companyName;
        companyCreationTime[msg.sender] = block.timestamp;

        
        emit CompanyCreated(msg.sender, address(companyContract), _companyName);
    }

    function getCompanySmartContractAddress(address _walletAddress) public view returns (address) {
        return walletAddressToSmartContractAddress[_walletAddress];
    }

    function addProduct(
        address _ownerAddress,
        address _contractAddress,
        uint256[] memory _products
    ) public returns (string memory) {
        
        emit ProductAdded(_contractAddress, _ownerAddress);
        return Company(_contractAddress).addProducts(_ownerAddress, _products);
    }
}
