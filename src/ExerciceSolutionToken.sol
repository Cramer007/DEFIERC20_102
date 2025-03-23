// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract ExerciceSolutionToken is ERC20 {
    mapping(address => bool) public authorizedMinter;
    address public owner;

    constructor() ERC20("MyERC20_102_Token", "MTK") {
        owner = msg.sender; 
    }

    function addMinter(address minterAddress) external {
        require(msg.sender == owner, "Only owner can add minters");
        authorizedMinter[minterAddress] = true;
    }

    function isMinter(address minterAddress) external view returns (bool) {
        return authorizedMinter[minterAddress];
    }

    function mint(address toAddress, uint256 amount) external {
        require(authorizedMinter[msg.sender], "Unauthorized minter");
        _mint(toAddress, amount);
    }

    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}