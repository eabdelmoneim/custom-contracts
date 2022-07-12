// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import './ERC721A.sol';
import '@thirdweb-dev/contracts/feature/interface/IMintableERC721.sol';
import "@thirdweb-dev/contracts/feature/PermissionsEnumerable.sol";
import "@thirdweb-dev/contracts/feature/Royalty.sol";

/// @title Azuki contract that can be fully used in the thirdweb dashboard
contract AzukiWithMinting is ERC721A, IMintableERC721, PermissionsEnumerable, Royalty {

  // DEFINE YOUR ROLE
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");  
    address private owner;

    constructor(string memory name, string memory symbol) ERC721A(name, symbol) {
       
         owner = msg.sender;
        // initialize permissions
        _setupRole(DEFAULT_ADMIN_ROLE, owner);
        _setupRole(MINTER_ROLE, owner);
        _setupRole("pauser", owner);
    }


    mapping(uint256 => string) private uris;

    function _canSetRoyaltyInfo() internal override returns (bool) {
        return msg.sender == owner;
    }

    /// Modified Azuki mint function to accept a URI, and work in our dashboard
    function mintTo(address to, string calldata uri) external returns (uint256) {
        uint256 id = _currentIndex;
        _safeMint(to, 1);
        uris[id] = uri;
        emit TokensMinted(to, id, uri);
        return id;
    }

    /// Modified tokenURI to return more than just base URI
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return uris[tokenId];
    }
}
