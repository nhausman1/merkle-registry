// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

import "./IMerkleRegistry.sol";

/**
 * @dev A contract for the decentralized storage of Merkle tree data.
 *
 * Each registered contract can have 2^(256) - 1 trees associated with it via
 * the treeIndex parameter. The URI is stored as a string, giving flexibility
 * to contract owners and clients to choose how to store the URI and retrieve
 * its data.
 *
 * The address setting data for a contract must own that contract. The contract
 * must expose a public owner function as seen below in the IOwner interface
 * Implementing OpenZepplin Ownable in the contract is sufficient.
 */

interface IOwner {
    function owner() external view returns (address);
}

contract MerkleRegistry is IMerkleRegistry {
    event URISet(address indexed contract_, uint256 treeIndex, string uri);

    /**
     * @dev Mapping of contract address => Merkle tree index => URI
     */
    mapping(address => mapping(uint256 => string)) public merkleTrees;

    /**
     * @dev Sets the URI for the tree index and contract provided. Throws if
     * called by any account other than the owner of the contract provided.
     * Implicitly reverts if contract_ is not a contract.
     */
    function setURI(
        address contract_,
        uint256 treeIndex,
        string calldata uri
    ) external {
        require(
            msg.sender == IOwner(contract_).owner(),
            "Must be owner of contract to update"
        );
        merkleTrees[contract_][treeIndex] = uri;
        emit URISet(contract_, treeIndex, uri);
    }
}
