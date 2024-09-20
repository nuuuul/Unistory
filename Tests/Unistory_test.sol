// SPDX-License-Identifier: MIT
// ["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]
pragma solidity >=0.4.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "Inter/Unistory.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract UnistoryTest is ERC20("Unistory", "MTK"){
    uint256 tokens_toMintMany = 100000;
    address test_owner;
    address acc0 = TestsAccounts.getAccount(0);
    address acc1 = TestsAccounts.getAccount(1);
    address acc2 = TestsAccounts.getAccount(2);
    address acc3 = TestsAccounts.getAccount(3);
    address payable  acc4;
    address[] public test_addresses;
    Unistory foo;


    //создаем объект с выхзовом mintMany из конструктора
    function beforeAll() public {
        test_owner = address(this);
        test_addresses.push(acc1);
        test_addresses.push(acc2);
        foo = new Unistory(test_owner, 1000000, test_addresses);
        //проверка функции balanceOf(address)
        Assert.equal(uint256(50000), foo.balanceOf(acc1), "Both account balances should be == 50000");
        Assert.equal(uint256(50000), foo.balanceOf(acc2), "Both account balances should be == 50000");
    }

    function testMint() public {
        foo.mint(acc1, 500);        //на аккаунте должно прибавиться 500 токенов 
        foo.mint(acc3, 500);        //на аккаунте должно храниться 500 токенов

        Assert.equal(foo.balanceOf(acc1), uint256(50500), "ACC1 balance should be equal 50500");
        Assert.equal(foo.balanceOf(acc3), uint256(500), "ACC3 balance should be equal 500");
    }
    
    function testMintMany() public {
        test_addresses.push(acc3);
        foo.mintMany(test_addresses, 30000);

        Assert.equal(foo.balanceOf(acc1), uint256(60500), "ACC1 balance should be equal 60500");
        Assert.equal(foo.balanceOf(acc2), uint256(60000), "ACC2 balance should be equal 60000");
        Assert.equal(foo.balanceOf(acc3), uint256(10500), "ACC3 balance should be equal 10500");
    }

    //проверяем все поля
    function tetsAllFields() public {
        Assert.equal(foo.decimals(), uint8(18), "Should be '18'");
        Assert.equal(foo.name(), "Unistory", "Should be 'Unistory'");
        Assert.equal(foo.owner(), test_owner, "Addresses must match");
        Assert.equal(foo.symbol(), "MTK", "Should be 'MTK'");
        Assert.equal(foo.tokensLimit(), 1000000, "Should be 'MTK'");
        Assert.equal(foo.totalSupply(), uint256(131000), "Should be 131000");
    }

    function testApproveAllowance() public {
        //проверяем allowance, который изначально равен 0
        Assert.equal(foo.allowance(test_owner, acc1), uint256(0), "Token amount should be equal 0");
        //проверяем approve, который после исполнения позволит acc1 снять 5000 токенов с test_owner
        foo.approve(acc1, 5000);
        Assert.equal(foo.allowance(test_owner, acc1), uint256(5000), "Token amount should be equal 5000");
    }

    function testTransfer() public {
        foo.mint(test_owner, 50000);
        foo.transfer(acc1, 1500);
        Assert.equal(foo.balanceOf(acc1), 62000, "Acc1 balance after transfer");
        Assert.equal(foo.balanceOf(test_owner), 48500, "Test_owner balance after transfer");
    }

    function testTranferOwnership() public {
        foo.transferOwnership(acc1);        //меняем  адрес owner на адрес acc1
        Assert.notEqual(foo.owner(), test_owner, "Addresses must match");
        delete foo;
        foo = new Unistory(test_owner, 1000000, test_addresses);
    }


    //проверяем функцию renounceOwnership (после исполнения отбирает права владельца)
    function testRenounceOwnership() public{
        foo.renounceOwnership();
        Assert.equal(foo.owner(), 0x0000000000000000000000000000000000000000, "Should be equal 0x0000000000000000000000000000000000000000");
    }
}