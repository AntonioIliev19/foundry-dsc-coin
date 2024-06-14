// SPDX-License-Identifier: MIT

// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

pragma solidity ^0.8.18;

import {ERC20Burnable, ERC20} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title DecentralizedStableCoin
 * @author Antonio Iliev
 * Collateral: Exogenous (ETH & BTC)
 * Minting: Algorithmic
 * Relative Stability: Pegged to USD
 * 
 * This is the contract meant to be governed by DSCEngine. This contract is just the ERC20 implementation of our stablecoin system.
 * 
 */

abstract contract DecentralizedStableCoin is ERC20Burnable, Ownable {
    error DecentralizedStableCoin__MustBeMoreThanZero();
    error DecentralizedStableCoin__BurnAmountExceedsBalance();
    error DecentralizedStableCoin__NotZeroAddress();

    constructor()ERC20("DecentralizedStableCoin", "DSC") {}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        require(_amount <= 0, DecentralizedStableCoin__MustBeMoreThanZero()); // Custom Errors with require in Solidity 0.8.26
        // if (_amount <= 0) {
        //     revert DecentralizedStableCoin__MustBeMoreThanZero();
        // }
        require(balance < _amount, DecentralizedStableCoin__BurnAmountExceedsBalance());
        // if (balance < _amount) {
        //     revert DecentralizedStableCoin__BurnAmountExceedsBalance();
        // }
        super.burn(_amount);
    }

    function mint(address _to, uint256 _amount) external onlyOwner returns(bool){
        require (_to == address(0), DecentralizedStableCoin__NotZeroAddress());
        // if(_to == address(0)) {
        //     revert DecentralizedStableCoin__NotZeroAddress();
        // }
        require(_amount <= 0, DecentralizedStableCoin__MustBeMoreThanZero());
        // if (_amount <= 0) {
        //     revert DecentralizedStableCoin__MustBeMoreThanZero();
        // }
        
        _mint(_to, _amount);
        return true;
    }

}