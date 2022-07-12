const hre = require('hardhat');
require('@nomiclabs/hardhat-etherscan');

async function main() {
  await verify('0xA97687539B05739C5df1350c291D0839a225Cca1', []);
}

async function verify(address, args) {
  try {
    return await hre.run('verify:verify', {
      address: address,
      constructorArguments: args,
      contract: 'contracts/ERC721withAsciiArt.sol:ERC721withAsciiArt',
    });
  } catch (e) {
    console.log(address, args, e);
  }
}

main()
  .then(() => process.exit(0))
  .catch((e) => {
    console.error(e);
    process.exit(1);
  });
