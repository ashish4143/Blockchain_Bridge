// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/access/Ownable.sol";
interface IBUSDT{
    function mint(address _to, uint amount)external;
    function burn(address _from,uint amount)external;
}
contract BridgeSol is Ownable{
    address public tokenAddress;
    uint256 public balance;
    event Burn(address indexed from, uint amount);
    mapping(address => uint256) public pendingBalance;
    constructor(address _tokenAddress) Ownable(msg.sender){
        tokenAddress = _tokenAddress;
    }       

    function depositOnOtherChain(uint amount)public{
        pendingBalance[msg.sender] += amount;
    }

    function burn(IBUSDT _tokenAddress,uint amount)public{
        require(address(_tokenAddress) == tokenAddress);
        _tokenAddress.burn(msg.sender,amount);
        emit Burn(msg.sender,amount);
    }

    function withdraw(IBUSDT _tokenAddress,uint amount)public{
        require(pendingBalance[msg.sender] >= amount);
        _tokenAddress.mint(msg.sender,amount);
        pendingBalance[msg.sender] -= amount;
    }
        
}