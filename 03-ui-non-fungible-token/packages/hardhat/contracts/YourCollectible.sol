// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2; //Do not change the solidity version as it negatively impacts submission grading

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract YourCollectible is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    uint256 public tokenIdCounter;
    mapping(address => uint256[]) private _addressTokenApprovals;

    constructor() ERC721("Bantu", "BT") Ownable(msg.sender) {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function mintItem(address to, string memory uri) public returns (uint256) {
        uint256 tokenId = tokenIdCounter;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        tokenIdCounter += 1;
        return tokenId;
    }

    /**
        Override internal lower level _approve
        This function sets _addressTokenApprovals so that we can track and enumerate the approved tokens for each token
     */
    function _approve(address to, uint256 tokenId, address auth, bool emitEvent) internal override {
        // TODO: get the currently approved address for the tokenId

        // TODO: call the _approve logic of the parent ERC721 smart contract

        // TODO: if the previous approved is the same as the new approved address return

        // TODO: add the tokenId to the address's approved array

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

        for (uint256 i=0; i < approvedTokens.length; ++i){
            uint256 approvedTokenId = approvedTokens[i];
            if (tokenId == approvedTokenId){
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

    function _update(address to, uint256 tokenId, address auth) internal override(ERC721, ERC721Enumerable) returns (address) {
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
