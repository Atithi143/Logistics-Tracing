const Buyer = artifacts.require("Buyer");

module.exports = function (deployer) {
  deployer.deploy(Buyer,"0x43688BFA17af954C3a72e571502C9F3A7fAb296a","0xe94954b90C7E4b94da5C0f404799A49Fc71F34F0");
}; 
