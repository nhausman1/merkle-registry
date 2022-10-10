pragma solidity ^0.8.15;

import "forge-std/Test.sol";
import "../src/MerkleRegistry.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OwnableERC20 is ERC20, Ownable {
    constructor() ERC20("OWNABLE", "OWN") {
        _mint(address(1), 1 ether);
    }
}

contract MerkleRgistryTest is Test {
    ERC20 ownableToken;
    ERC20 noOwnerToken;
    MerkleURIs merkle;

    function setUp() public {
        merkle = new MerkleURIs();
        vm.prank(address(1));
        ownableToken = new OwnableERC20();
        noOwnerToken = new ERC20("NO_OWNER", "NOOWN");
    }

    function testSetURI() public {
        vm.prank(address(1));
        merkle.setURI(address(ownableToken), 0, "12345");
        assert(
            keccak256(abi.encode(merkle.merkleTrees(address(ownableToken), 0))) ==
                keccak256(abi.encode("12345"))
        );
    }

    function testOnlyContractOwnerCanSet() public {
        vm.expectRevert(bytes("Must be owner of contract to update"));
        merkle.setURI(address(ownableToken), 0, "12345");
    }

    function testOwnerlessContractRevers() public {
        vm.expectRevert(bytes("Contract does not implement IOwner"));
        merkle.setURI(address(noOwnerToken), 0, "12345");
    }

    function testNonContractReverts() public {
        // Call reverts with EVM error. Contract does not attemp to catch this
        // error because Address.isContract usage is discouraged.
        vm.expectRevert();
        merkle.setURI(address(2), 0, "12345");
    }
}
