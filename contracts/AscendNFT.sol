// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; 

contract AscendNFT is ERC721Enumerable, Ownable {
    
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    string public baseExtension = ".json";
    bool[3] isUsed = [false, false, false];
    uint256 public cost = 0.05 ether;
    uint256 public maxSupply = 3;

    constructor() ERC721("AscendNFT", "ANFT") {}

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmSpR6SZ2MH1fk7PPcoewuLFENCNYwjJD4dy9wy1PPPeUQ/";
    }
    
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(currentBaseURI, Strings.toString(tokenId), baseExtension))
            : "";
    }

    event nftUsedEvent(
        uint256 nftUsedId,
        bool nftUsed
    );

    function mint(uint256 _mintAmount) public payable {
        uint256 supply = totalSupply();
        require(_mintAmount > 0);
        require(supply + _mintAmount <= maxSupply);

        if (msg.sender != owner()) {
        require(msg.value >= cost * _mintAmount);
        }

        for (uint256 i = 0; i <= _mintAmount-1; i++) {
        _safeMint(msg.sender, supply + i);
        }
    }

    function canjearNFT(uint256 tokenId) public onlyOwner {
        require(isUsed[tokenId] == false, "Este NFT ya fue canjeado, no se puede usar mas.");
        isUsed[tokenId] = true;
        emit nftUsedEvent(tokenId, isUsed[tokenId]);
    }
}