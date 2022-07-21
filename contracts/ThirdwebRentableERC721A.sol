// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";
import "@thirdweb-dev/contracts/extension/Permissions.sol";
import "@thirdweb-dev/contracts/extension/LazyMint.sol";
import "@thirdweb-dev/contracts/extension/ContractMetadata.sol";

contract ThirdwebRentableERC721A is ERC721A, Permissions, LazyMint, ContractMetadata {

    // DEFINE YOUR ROLE
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");  
    bytes32 private constant TRANSFER_ROLE = keccak256("TRANSFER_ROLE");

    address private deployer;

    constructor() ERC721A("ThirdwebRentableERC721A", "TW721A") {

        deployer = msg.sender;

        // set up basic permissions
        _setupRole(DEFAULT_ADMIN_ROLE, deployer);
        _setupRole(MINTER_ROLE, deployer);
        _setupRole(TRANSFER_ROLE, deployer);
    }

    /*
    ** only admins/owners can update the contract URI
    */
    function _canSetContractURI() internal virtual override returns (bool){
        return msg.sender == deployer || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    /**
     *  Here we override the `mintTo` function made available by the `ERC721Base` contract.
     *
     *  We make it so that anyone can mint tokens that have already been lazy minted.
     */
    function mintTo(address _to, string memory) public virtual  {
        uint256 quantity = 1;
        require(
            _nextTokenId() + quantity <= nextTokenIdToLazyMint,
            "Not enough lazy minted tokens."
        );

        _safeMint(_to, quantity, "");
    }

    /**
     *  This function returns who is authorized to lazy mint NFTs on your contract.
     *
     */
    function _canLazyMint() internal view virtual override returns (bool) {
        return msg.sender == deployer || hasRole(MINTER_ROLE, msg.sender) || hasRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mint(uint256 quantity) external payable {
        // check permissions before allowing mint
        if(msg.sender == deployer || hasRole(MINTER_ROLE, msg.sender) || hasRole(DEFAULT_ADMIN_ROLE, msg.sender))
            _mint(msg.sender, quantity);
    }
}