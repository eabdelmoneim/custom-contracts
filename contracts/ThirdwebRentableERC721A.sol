// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@thirdweb-dev/contracts/base/ERC721LazyMint.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";

contract ThirdwebRentableERC721A is ERC721LazyMint, PermissionsEnumerable {

    // DEFINE YOUR ROLE
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");  
    bytes32 private constant TRANSFER_ROLE = keccak256("TRANSFER_ROLE");

    address private deployer;


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
    ) ERC721LazyMint(_name, _symbol, _royaltyRecipient, _royaltyBps) {
        deployer = msg.sender;

        // set all permissions
        _setupOwner(deployer);
        _setupRole(DEFAULT_ADMIN_ROLE, deployer);
        _setupRole(MINTER_ROLE, deployer);
        _setupRole(TRANSFER_ROLE, deployer);

        // set royalty data
        _setupDefaultRoyaltyInfo(_royaltyRecipient, _royaltyBps);
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
     *
     *  We make it so that anyone can mint tokens that have already been lazy minted.
     */
    function mintTo(address _to, string memory _tokenURI) public virtual override  {
        require(hasRole(MINTER_ROLE, msg.sender),"must have minter role to mint");
        super.mintTo(_to, _tokenURI);
    }

   /**
     *  This function returns who is authorized to lazy mint NFTs on your contract.
     *
     */
    function _canLazyMint() internal view virtual override returns (bool) {
        return msg.sender == deployer || hasRole(MINTER_ROLE, msg.sender) || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

}