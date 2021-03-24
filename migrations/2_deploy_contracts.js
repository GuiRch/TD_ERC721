//const Animal = artifacts.require("FightingAnimals");

// Deploy to testnet
//const data = require('../secret.json');

//module.exports = function (deployer, network, accounts) {
  //deployer.deploy(Animal, 10, 1000000, {from: data.address});
//};
  
const Animal = artifacts.require("FightingAnimals");

module.exports = function (deployer) {
  deployer.deploy(Animal);
};