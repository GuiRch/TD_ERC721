pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
//import "@openzeppelin/contracts/token/ERC721/IERC721Metadata.sol";

contract FightingAnimals is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() public ERC721("CryptoPoulpe", "PLP") {}

    mapping( address => bool) registedBreeder;
    event registerNewBreeder( address indexed account);
    event unregisterOldBreeder( address indexed account);

    modifier onlyWhitelisted() {
        require(isRegistered(msg.sender));
        _;
    }

    function registerBreeder( address _address) public onlyOwner{ // add a breeder to the list of registered breeder
        registedBreeder[_address] = true;
        emit registerNewBreeder(_address);
    }

    function unregisterBreeder(address _address) public onlyOwner{// remove breeder from the list of registered breader
        registedBreeder[_address] = false;
        emit unregisterOldBreeder(_address);
    }

    function isRegistered(address _address) public view returns(bool) {
        return registedBreeder[_address];
    }


    function awardItem(address player, string memory tokenURI)
        public
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(player, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }

    struct CryptoPoulpe{
        string name; // Name of the Item
        string color;
        uint tentacule; // Item Level
        uint rarityLevel;  // 1 = normal, 2 = rare, 3 = epic, 4 = legendary
    }

    // here the function to create a new animal 
    function declareAnimal(address receiver, string memory tokenURI) external onlyOwner returns (uint256){
        _tokenIds.increment();

        uint256 newAnimal = _tokenIds.current();
        _mint(receiver, newAnimal);
        _setTokenURI(newAnimal, tokenURI);

        return newAnimal;
    }

    function deadAniaml(uint256 tokenID) external onlyOwner {
        _burn(tokenID);
    }

    function breedAnimal(address breeder, uint256 tokenId) public {

    }
}