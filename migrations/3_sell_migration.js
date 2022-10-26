const Seller = artifacts.require("Seller");

module.exports = function (deployer) {
  deployer.deploy(Seller,'0xd9145CCE52D386f254917e481eB44e9943F39138');
};
