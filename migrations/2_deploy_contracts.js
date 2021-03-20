const Animal = artifacts.require("FightingAnimals");

module.exports = function (deployer) {
  deployer.deploy(Animal);
};
