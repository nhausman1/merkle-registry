// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

interface IMerkleRegistry {
    function merkleTrees(address, uint256) external view returns (string calldata uri);
    function setURI(
        address contract_,
        uint256 treeIndex,
        string calldata uri
    ) external;
}