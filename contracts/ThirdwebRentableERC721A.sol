// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";
import "@thirdweb-dev/contracts/extension/LazyMint.sol";
import "@thirdweb-dev/contracts/extension/ContractMetadata.sol";
import "@thirdweb-dev/contracts/extension/Royalty.sol";
import "@thirdweb-dev/contracts/extension/Ownable.sol";

contract ThirdwebRentableERC721A is ERC721A, PermissionsEnumerable,  ContractMetadata, Ownable, Royalty, LazyMint {

    // DEFINE YOUR ROLE
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");  
    bytes32 private constant TRANSFER_ROLE = keccak256("TRANSFER_ROLE");

    address private deployer;

    mapping(uint256 => string) private fullURI;


    /*//////////////////////////////////////////////////////////////
                            Constructor
    //////////////////////////////////////////////////////////////*/

    /*
    *  Overriding constructor to include setting up of thirdweb feature extensions
    */
    constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    ) ERC721A(_name, _symbol) {

        deployer = msg.sender;

        // set all permissions
        _setupOwner(deployer);
        _setupRole(DEFAULT_ADMIN_ROLE, deployer);
        _setupRole(MINTER_ROLE, deployer);
        _setupRole(TRANSFER_ROLE, deployer);

        // set royalty data
        _setupDefaultRoyaltyInfo(_royaltyRecipient, _royaltyBps);

    }

    /*
    *   Since both ERC721A and thirdweb Royalty extension implement ERC2981 need supportsInterface
    */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721A, IERC165) returns (bool) {
        return
            interfaceId == 0x01ffc9a7 || // ERC165 Interface ID for ERC165
            interfaceId == 0x80ac58cd || // ERC165 Interface ID for ERC721
            interfaceId == 0x5b5e139f || // ERC165 Interface ID for ERC721Metadata
            interfaceId == type(IERC2981).interfaceId; // ERC165 ID for ERC2981
    }
    
     /*//////////////////////////////////////////////////////////////////////////
                            THIRDWEB OWNABLE FEATURE OVERRIDES
    //////////////////////////////////////////////////////////////////////////*/

    function _canSetOwner() internal view virtual override returns (bool) {
        return msg.sender == owner();
    }

    /*////////////////////////////////////////////////////////////////////////
                            THIRDWEB CONTRACT METADATA FEATURE OVERRIDES
    /////////////////////////////////////////////////////////////////////////*/

    /*
    ** only admins/owners can update the contract URI
    */
    function _canSetContractURI() internal view virtual override returns (bool){
        return msg.sender == deployer || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /*//////////////////////////////////////////////////////////////////////
                            THIRDWEB ROYALTY FEATURE OVERRIDES
    ////////////////////////////////////////////////////////////////////////*/

    /*
    *   Only admins/owners can set royalties
    */
    function _canSetRoyaltyInfo() internal view virtual override returns (bool){
        return msg.sender == deployer || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /*/////////////////////////////////////////////////////////////////////
                            THIRDWEB LAZY MINT FEATURE OVERRIDES
    //////////////////////////////////////////////////////////////////////*/

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

        fullURI[nextTokenIdToLazyMint] = _tokenURI;
        _safeMint(_to, quantity, "");
    }

   /**
     *  This function returns who is authorized to lazy mint NFTs on your contract.
     *
     */
    function _canLazyMint() internal view virtual override returns (bool) {
        return msg.sender == deployer || hasRole(MINTER_ROLE, msg.sender) || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

}