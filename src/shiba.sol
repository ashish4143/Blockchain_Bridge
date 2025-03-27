// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract Shiba is ERC20,Ownable{
    constructor() ERC20("Shiba Inu", "SHIBA") Ownable(msg.sender){

    }

    function mint(address _to, uint amount)public{
        _mint(_to, amount);
    }
    
}