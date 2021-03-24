# TD_ERC721
Guillaume RICHER - Pierre-Louis QUANDALLE - Marie APPOLAIRE

## Create an ERC721 token contrac

```
constructor() public ERC721("CryptoPoulpe", "PLP") {
        //_numToken = 0;
    }
```

Le contrat est crée comme étant 'Ownable', permettant d'implémenter des fonctions accessibles exclusivement par un compte (le propriétaire).


## Implement a registerBreeder() function

```
function registerBreeder( address _address) public onlyOwner{
        registedBreeder[_address] = true;
        emit registerNewBreeder(_address);
    }
```
Cette fonction n'est accessible que par le propriétaire, elle permet d'ajouter un éleveur à la liste des éleveurs enregistrés.
Nous avons également implémenter une fonction *unregisteredBreeder* permettant de retirer un éleveur de la liste, et *isRegistered* permettant de voir si la personne fait déjà partie de la liste d'éleveurs enregistrés.


## Implement a declareAnimal() function

Nous avons créer des Cryptopoulpes ayant plusieurs caractéristiques : son niveau de chance, d'intelligence, un nombre de tentacules, une couleur et un niveau de rareté.

```
enum Color{green, red, blue, yellow, purple, pink}
    enum Rarity{normal, rare, epic, legendary, godlike}

    struct CryptoPoulpe{
        uint256 chance; // luckyness of our cryptopoulpe
        uint256 smart; // intelligence of our cryptopoulpe
        uint256 tentacule; // Item Level
        Color color; // color of the crypto poulpe
        Rarity rarity;  // 1 = normal, 2 = rare, 3 = epic, 4 = legendary
    }
```

Celles-ci sont choisies au hasard dans la fonction *createAnimal()*, la couleur et la rareté parmi plusieurs possibilités prédéfinies.

```
function createAnimal() private returns(bool){
        Color color = Color(random(uint(Color.GROUND)));
        Rarity rarity = Rarity(random(uint(Rarity.GROUND)));
        uint256 chance = random(100);
        uint256 smart = random(20);
        uint256 tentacule = random(10);
        CryptoPoulpe memory randomCryptoPoulpe = CryptoPoulpe(chance, smart, tentacule, color, rarity);

    }
```

Le cryptopoulpe est enfin crée avec la fonction *declareAnimal()*, qui associe un nouveau cryptopoulpe à un éleveur.


```
function declareAnimal(address receiver, string calldata tokenURI) external onlyOwner returns (uint256) {
        createAnimal();
        _tokenIds.increment();

        uint256 newAnimal = _tokenIds.current();
        _mint(receiver, newAnimal);
        _setTokenURI(newAnimal, tokenURI);

        return newAnimal;
    }
```


## Implement a deadAnimal() function

Cette fonction supprime un animal

```
function deadAnimal(uint256 tokenID) external onlyOwner {
        _burn(tokenID);
    }
```


## Implement a breedAnimal() function

Cette fonction crée un nouveau cryptopoulpe à partir de 2 cryptopoulpes "parents". Les caractéristiques du cryptopoulpe "enfant" sont choisis au hasard entre celles des parents pour la couleur et la rareté, et est la moyenne de celles des parents pour le niveau de chance, d'intelligence et le nombre de tentacules.
