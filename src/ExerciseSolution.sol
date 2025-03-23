// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "src/ERC20Claimable.sol";
import "src/ExerciceSolutionToken.sol"; 

contract ExerciceSolution is ERC20 {
    ERC20Claimable public erc20claimable;
    ExerciceSolutionToken public erc20Token; 
    uint256 public distributedAmount;
    address public deployer;

    mapping(address => uint256) public mapdistrib;

    constructor(address _erc20claimable) ERC20("MyERC20_102", "MTK") {
        erc20claimable = ERC20Claimable(_erc20claimable);
        deployer = msg.sender;
        erc20Token = new ExerciceSolutionToken();
        erc20Token.addMinter(address(this));
    }

    function claimTokensOnBehalf() external {
        distributedAmount = erc20claimable.claimTokens();
        mapdistrib[msg.sender] += distributedAmount;
    }

    function tokensInCustody(address callerAddress) external view returns (uint256) {
        return mapdistrib[callerAddress];
    }

    function withdrawTokens(uint256 amountToWithdraw) external returns (uint256) {
        erc20Token.burn(amountToWithdraw);
        erc20claimable.transferFrom(address(this), msg.sender, amountToWithdraw);
        return amountToWithdraw;
    }

    function depositTokens(uint256 amountToWithdraw) external returns (uint256) {
        erc20claimable.transferFrom(msg.sender, address(this), amountToWithdraw);
        mapdistrib[msg.sender] += amountToWithdraw;
        erc20Token.mint(msg.sender,amountToWithdraw);
        return mapdistrib[msg.sender];
    }

    function getERC20DepositAddress() external view returns (address) {
        return address(erc20Token);
    }
}