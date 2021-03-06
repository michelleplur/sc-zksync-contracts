pragma solidity >=0.7.0 <0.9.0;

/**
*  @title Marketplace List
*  @dev Created in Swarm City anno 2022,
*  for the world, with love.
*  description Marketplace List Contract
*  description This is the Marketplace List contract for Swarm City marketplaces.
*  In it, "allowed" marketplaces that are advertised in the app are being stored.
*/

import "./Ownable.sol";

contract MarketplaceList is Ownable {

     struct mpListItem {
        string mpName;
        string mpMetaHash;
        address mpAddress;
        bool mpShown;
    } 

    mpListItem[] public mpListArray;

    uint public defaultTTL;

    string public name;
    
    event MarketplaceAdded(string mpName, string mpMetaHash, address mpAddress);

    function setName(string memory _name) onlyOwner external {
        name = _name;
    }

      function getName() public view returns (string memory) {
        return name;
    }
    
    function addMarketplace(string memory _mpName, string memory _mpMetaHash, address _mpAddress) onlyOwner external {
        require(bytes(_mpName).length != 0);
        mpListItem storage mplItem = mpListArray.push();
        mplItem.mpName= _mpName;
        mplItem.mpMetaHash = _mpMetaHash;
        mplItem.mpAddress = _mpAddress;
        mplItem.mpShown = true; 
        emit MarketplaceAdded(_mpName, _mpMetaHash, _mpAddress);
    }

    function readMarketplace(uint _index) view public returns (
        string memory mpName,
        string memory mpMetaHash,
        address mpAddress,
        bool mpShown) {
        mpListItem storage c = mpListArray[_index];
        return (c.mpName, c.mpMetaHash, c.mpAddress, c.mpShown);
    }

    function numberOfMarketplaces() view public returns (uint) {
        return mpListArray.length;
    }
}