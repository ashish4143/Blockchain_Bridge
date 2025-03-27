// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
contract WShiba is ERC20,Ownable {
    constructor() ERC20("Wrapped Shiba Inu", "wSHIBA") Ownable(msg.sender){
        
    }

    function mint(address _to, uint amount)public onlyOwner{
        _mint(_to, amount);
    }
    function burn(uint amount)public onlyOwner{
        _burn(msg.sender, amount);
    }
}