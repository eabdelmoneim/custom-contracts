// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@thirdweb-dev/contracts/base/ERC721Base.sol";
import "@thirdweb-dev/contracts/extension/LazyMint.sol";
import "@thirdweb-dev/contracts/extension/Permissions.sol";

contract BasicNFTDrop is ERC721Base, Permissions, LazyMint {

    address public deployer;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");  
    bytes32 private constant TRANSFER_ROLE = keccak256("TRANSFER_ROLE");

constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    )
        ERC721Base(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps
        )
    {
        deployer = msg.sender;

         // set up basic permissions
        _setupRole(DEFAULT_ADMIN_ROLE, deployer);
        _setupRole(MINTER_ROLE, deployer);
        _setupRole(TRANSFER_ROLE, deployer);
    }

    /**
     *  Here we override the `mintTo` function made available by the `ERC721Base` contract.
     *
     *  We make it so that anyone can mint tokens that have already been lazy minted.
     */
    function mintTo(address _to, string memory) public virtual override {
        uint256 quantity = 1;
        require(
            nextTokenIdToMint() + quantity <= nextTokenIdToLazyMint,
            "Not enough lazy minted tokens."
        );

        _safeMint(_to, quantity, "");
    }

    /**
     *  This function returns who is authorized to lazy mint NFTs on your contract.
     *
     *  As an EXAMPLE, we'll only allow the contract deployer to lazy mint NFTs.
     *
     *  You MUST complete the body of this function to use the `LazyMint` extension.
     */
    function _canLazyMint() internal view virtual override returns (bool) {
        return msg.sender == deployer;
    }
}