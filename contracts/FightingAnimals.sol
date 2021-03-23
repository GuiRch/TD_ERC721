pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import '@openzeppelin/contracts/math/SafeMath.sol';

//import "@openzeppelin/contracts/token/ERC721/IERC721Metadata.sol";

contract FightingAnimals is ERC721, Ownable {

    using SafeMath for uint;
    using Math for uint;


    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() public ERC721("CryptoPoulpe", "PLP") {
        //_numToken = 0;
    }

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

    mapping(uint256 => CryptoPoulpe) public metadata;

    enum Color{green, red, blue, yellow, purple, pink}
    enum Rarity{normal, rare, epic, legendary, godlike}

    struct CryptoPoulpe{
        uint256 chance; // luckyness of our cryptopoulpe
        uint256 smart; // intelligence of our cryptopoulpe
        uint256 tentacule; // Item Level
        Color color; // color of the crypto poulpe
        Rarity rarity;  // 1 = normal, 2 = rare, 3 = epic, 4 = legendary
    }

    
    function createAnimal() private returns(bool){
        // this function will choose random characteritics for our new animal
        Color color = Color(random(uint(Color.GROUND)));
        Rarity rarity = Rarity(random(uint(Rarity.GROUND)));
        uint256 chance = random(100);
        uint256 smart = random(20);
        uint256 tentacule = random(10);
        CryptoPoulpe memory randomCryptoPoulpe = CryptoPoulpe(chance, smart, tentacule, color, rarity);
        //metadata[_numToken] = randomCryptoPoulpe;

    }

    // here the function to create a new animal 
    function declareAnimal(address receiver, string calldata tokenURI) external onlyOwner returns (uint256){
        createAnimal();
        _tokenIds.increment();

        uint256 newAnimal = _tokenIds.current();
        _mint(receiver, newAnimal);
        _setTokenURI(newAnimal, tokenURI);

        return newAnimal;
    }

    function deadAniaml(uint256 tokenID) external onlyOwner {
        _burn(tokenID);
    }

}