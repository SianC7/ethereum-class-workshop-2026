// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2; //Do not change the solidity version as it negatively impacts submission grading

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// Create a contract that inherits functionality from Openzeppelin's ERC721, ERC721Enumerable, ERC721URIStorage and Ownable smart contracts
contract YourCollectible is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 public tokenIdCounter;
    mapping(address => uint256[]) private _addressTokenApprovals; // Value associated with the address key is a dynamic array of uint256 integers

    constructor() ERC721("Bantu", "BT") Ownable(msg.sender) {} // ERC721(name of colleciton, symbol of collection). Pass the owner address to the Ownable constructor

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function mintItem(address to, string memory uri) public returns (uint256) {
        /** To create or mint an NFT using the _mint function, you typically interact 
        with a Solidity smart contract based on OpenZeppelin's ERC721 standards. 
        The _mint function is an internal function that assigns a new Token ID to a 
        specified address, effectively creating the token on the blockchain. */

        uint256 tokenId = tokenIdCounter; // Get the current token ID from the counter

        // TODO: use _mint to create/mint an NFT

        //_mint(to, tokenId); // Call the _mint function from the parent ERC721 contract to mint the token to the specified address with the current token ID

        // TODO: Switch from _mint to _safeMint.
        /** Why: _safeMint checks that the recipient can handle ERC-721 tokens via 
        onERC721Received. Minting to a contract that does not implement IERC721Receiver 
        can lock the NFT in that contract with no way to transfer it out. */

        _safeMint(to, tokenId);

        // TODO: use _setTokenURI to set the metadata source for the NFT
        _setTokenURI(tokenId, uri);

        // TODO: increament the tokenIdCounter
        tokenIdCounter++;

        return tokenId;
    }

    /**
        Override internal lower level _approve
        This function sets _addressTokenApprovals so that we can track and enumerate the approved tokens for each token
     */
    function _approve(address to, uint256 tokenId, address auth, bool emitEvent) internal override {
        // TODO: get the currently approved address for the tokenId
        address currentApproved = getApproved(tokenId); // getApproved is an internal function of ERC721 that returns the approved address for a token ID, or zero if no address set

        // TODO: call the _approve logic of the parent ERC721 smart contract
        /** _approve is an internal function responsible for setting the allowance, 
        which is the amount of tokens a third party (spender) is permitted to move on behalf of the token owner. 
        It is the internal, foundational logic called by the public approve function */
        // Call super is your smart contract has a method that has the same name as the parent
        super._approve(to, tokenId, auth, emitEvent);

        // TODO: if the previous approved is the same as the new approved address return
        if (currentApproved == to) {
            return;
        }
        // TODO: add the tokenId to the address's approved array
        _addressTokenApprovals[to].push(tokenId);
        // TODO: delete the previous tokenId from the address's approved array
    }

    function approvedBalanceOf(address owner) public view virtual returns (uint256) {
        if (owner == address(0)) {
            revert ERC721InvalidOwner(address(0));
        }
        return _addressTokenApprovals[owner].length;
    }

    /**
        This function allows external apps to iterate through the approved tokens for an address
     */
    function approvedTokenByIndex(address approved, uint256 index) public view virtual returns (uint256) {
        uint256[] memory approvedTokens = _addressTokenApprovals[approved];

        if (index >= approvedTokens.length) {
            revert ERC721OutOfBoundsIndex(address(0), index);
        }

        return approvedTokens[index];
    }

    function _deleteAddressApproval(address approvedAddress, uint256 tokenId) private {
        uint256[] memory approvedTokens = _addressTokenApprovals[approvedAddress];

        for (uint256 i = 0; i < approvedTokens.length; ++i) {
            uint256 approvedTokenId = approvedTokens[i];
            if (tokenId == approvedTokenId) {
                // put the last tokenId into the position of the deleted
                _addressTokenApprovals[approvedAddress][i] = approvedTokens[approvedTokens.length - 1];

                // pop the last element out
                _addressTokenApprovals[approvedAddress].pop();
                return;
            }
        }
    }

    // The following functions are overrides required by Solidity.

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function _update(
        address to,
        uint256 tokenId,
        address auth
    ) internal override(ERC721, ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
