// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";

contract KennyToken is ERC20 {
    uint256 public unitsOneEthCanBuy  = 1000;
    address public tokenOwner;

    constructor(string memory name, string memory symbol) 
        ERC20(name, symbol) {
        tokenOwner = msg.sender;

        uint256 n = 1000000;
        _mint(msg.sender, n * 10**uint(decimals()));
    }

    // this function is called when someone sends ether to the 
    // token contract
    buyToken() external payable {        
        uint256 amount = msg.value * unitsOneEthCanBuy;
        // ensure you have enough tokens to sell
        require(balanceOf(tokenOwner) >= amount, 
            "Not enough tokens");
        // transfer the token to the buyer
        _transfer(tokenOwner, msg.sender, amount);
        // emit an event to inform of the transfer        
        emit Transfer(tokenOwner, msg.sender, amount);
        
        // send the ether earned to the token owner
        payable(tokenOwner).transfer(msg.value);
    }
}