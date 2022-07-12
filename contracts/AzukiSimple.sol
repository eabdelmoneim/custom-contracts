// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import './ERC721A.sol';

/// @title Pure ERC721A contract that can be used with the thirdweb SDK
contract SimpleAzuki is ERC721A {
    constructor(string memory name, string memory symbol) ERC721A(name, symbol) {}

    function mint(uint256 quantity) external payable {
        _safeMint(msg.sender, quantity);
    }
}
