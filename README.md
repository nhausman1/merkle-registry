# Merkle Registry
Decentralized the storage of your Merkle tree data today 🌱

### Background
Many ERC20 and ERC721 contracts gate access to minting via a Merkle Claim. Often, the claim parameters are hardcoded into the frontend or stored on a centralized backend, preventing direct contract interaction and cross-app composability. This contract serves as a decentralized registry for any contract with merkle claim data.

### How it works
```
TODO: Add mainnet address
TODO: Add Goerli address
TODO: Add Polygon address
TODO: Add Mumbai address
TODO: Deploy to other chains!
```
The contract is deployed on various chains. You can use the [IMerkleRegistry](./src/IMerkleRegistry.sol) interface to interact with the read and write functions in the contract. Note that in order to call the `setURI` function, four conditions must be met:
1. The Merkle Registry contract must be deployed on that chain.
2. The contract you're setting the data for must be deployed on that chain.
3. The contract must provied a public `owner` function that returns an address, as specified in the `IOwner` interface. It is sufficient if your contract imlements OpenZepplin Ownable.
4. The address calling the function must be the owner of the contract.
### Storing and Retrieving Merkle Data
The `merkleTrees` query returns a URI in the form of a string, giving flexibility to contract owners and clients to choose how to store the URI and retrieve its data. A simple and decentralized option is to store the IPFS `CID` of a JSON file which contains all the Merkle data specific to one tree index for the contract. An [example JSON file](./.example.json) is provided for reference and to help standardize formatting for composabaility.


