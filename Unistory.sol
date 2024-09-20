// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
// массив адресов ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]


pragma solidity ^0.8.25;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";




contract Unistory is ERC20, Ownable {
    uint256 public tokensLimit;         //лимит токенов (указывается при деплое)

    constructor(address initialOwner, uint256 _myTotalSupply, address[] memory addresses)
        ERC20("Unistory", "MTK")
        Ownable(initialOwner)
    {
        tokensLimit = _myTotalSupply;
        mintMany(addresses, 100000);
    }


    function mint(address to, uint256 amount) public onlyOwner{
        if (totalSupply() + amount > tokensLimit) {          //проверка на превышение лимита
            console.log("MINT ERROR: token limit exceeded");
            return;
        }
        _mint(to, amount);
    }


    function mintMany(address[] memory to, uint256 amount) public onlyOwner{
        uint tokens = amount / to.length;
        //проверяем массив на непустоту
        if (to.length <= 0){
                console.log("ERROR: emply list");
                return;
            }
        for (uint i = 0; i < to.length; i++){
            //проверяем на превышение лимита
            if ((totalSupply() + tokens) > tokensLimit){
                console.log("ERROR: token limit exceeded");
                break;
            }
            _mint(to[i], tokens);
        }
    }

}
