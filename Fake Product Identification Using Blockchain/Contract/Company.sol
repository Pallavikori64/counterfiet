//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Company {
    address public owner;

    struct Product {
        uint256 id;
        string name;
        string category;
        uint256 addedTime;
    }

    mapping(address => Product[]) public ownerToProducts;

    event ProductRegistered(address indexed owner, uint256 productId);
    event CompanyInitialized(address indexed owner);

    constructor(address _owner) {
        owner = _owner;
        emit CompanyInitialized(_owner);
    }

    function addProducts(
        address _owner,
        uint256[] memory _productIds
    ) public returns (string memory) {
        for (uint i = 0; i < _productIds.length; i++) {
            ownerToProducts[_owner].push(Product({
                id: _productIds[i],
                name: "Generic",  // You can allow this as input later
                category: "Default",
                addedTime: block.timestamp
            }));
            emit ProductRegistered(_owner, _productIds[i]);
        }

        return "Products added successfully";
    }

    function getProductsByOwner(address _owner) public view returns (Product[] memory) {
        return ownerToProducts[_owner];
    }
}
