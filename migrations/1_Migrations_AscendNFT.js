const AscendNFT = artifacts.require('AscendNFT')

module.exports = function (deployer) {
    deployer.deploy(AscendNFT)
}