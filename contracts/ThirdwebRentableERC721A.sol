// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";
import "@thirdweb-dev/contracts/extension/LazyMint.sol";
import "@thirdweb-dev/contracts/extension/ContractMetadata.sol";
import "@thirdweb-dev/contracts/extension/Royalty.sol";

contract ThirdwebRentableERC721A is ERC721A, PermissionsEnumerable,  ContractMetadata, LazyMint {

    // DEFINE YOUR ROLE
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");  
    bytes32 private constant TRANSFER_ROLE = keccak256("TRANSFER_ROLE");

    address private deployer;

    mapping(uint256 => string) private fullURI;

    constructor() ERC721A("ThirdwebRentableERC721A", "TW721A") {

        deployer = msg.sender;

        // set up basic permissions
        _setupRole(DEFAULT_ADMIN_ROLE, deployer);
        _setupRole(MINTER_ROLE, deployer);
        _setupRole(TRANSFER_ROLE, deployer);
    }
    
    /**
     *  @notice         Returns the metadata URI for an NFT.
     *  @dev            See `BatchMintMetadata` for handling of metadata in this contract.
     *
     *  @param _tokenId The tokenId of an NFT.
     */
    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        string memory fullUriForToken = fullURI[_tokenId];
        if (bytes(fullUriForToken).length > 0) {
            return fullUriForToken;
        }

        string memory batchUri = getBaseURI(_tokenId);
        return string(abi.encodePacked(batchUri, _toString(_tokenId)));
    }

    /*
    ** only admins/owners can update the contract URI
    */
    function _canSetContractURI() internal virtual override returns (bool){
        return msg.sender == deployer || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /**
     *
     *  We make it so that anyone can mint tokens that have already been lazy minted.
     */
    function mintTo(address _to, string memory _tokenURI) public virtual  {

        // check permissions
        require(hasRole(MINTER_ROLE, msg.sender),"must have minter role to mint");

        // check to make sure there are lazy minted tokens to be minted
        uint256 quantity = 1;
        require(
            _nextTokenId() + quantity <= nextTokenIdToLazyMint,
            "Not enough lazy minted tokens."
        );

        fullURI[getNextTokenIdToLazyMint()] = _tokenURI;
        _safeMint(_to, quantity, "");
    }

    /**
     *  This function returns who is authorized to lazy mint NFTs on your contract.
     *
     */
    function _canLazyMint() internal view virtual override returns (bool) {
        return msg.sender == deployer || hasRole(MINTER_ROLE, msg.sender) || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function getNextTokenIdToLazyMint() public view virtual returns (uint256) {
        return nextTokenIdToLazyMint;
    }
}