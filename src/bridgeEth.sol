// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
contract BridgeEth is Ownable{
     address public tokenAddress;
    uint256 public balance;
    event Deposit(address indexed from, uint amount);
    mapping(address => uint256) public pendingBalance;
    constructor(address _tokenAddress) Ownable(msg.sender){
        tokenAddress = _tokenAddress;
    }

    function deposit(IERC20 _tokenAddress,uint amount)public{
        require(address(_tokenAddress) == tokenAddress);
        require(_tokenAddress.allowance(msg.sender,address(this)) >= amount);
        _tokenAddress.transferFrom(msg.sender,address(this),amount);
        emit Deposit(msg.sender,amount);
    }
    function burnedOnOtherChain(uint amount)public onlyOwner{
        pendingBalance[msg.sender] += amount;
    }
    function withdraw(IERC20 _tokenAddress,uint amount)public{
        require(address(_tokenAddress) == tokenAddress);
        require(pendingBalance[msg.sender] >= amount);
        pendingBalance[msg.sender] -= amount;
        _tokenAddress.transfer(msg.sender,amount);
    }
}
