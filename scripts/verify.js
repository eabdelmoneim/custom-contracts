const hre = require("hardhat");
require("@nomiclabs/hardhat-etherscan");

async function main() {
    await verify("0xCA8cD800381601C65E4F63af4c594550A9C52E6c", [123]);
}

async function verify(address, args) {
    try {
      return await hre.run("verify:verify", {
        address: address,
        constructorArguments: args,
      });
    } catch (e) {
      console.log(address, args, e);
    }
}

main()
.then(() => process.exit(0))
.catch((e) => {
    console.error(e)
    process.exit(1)
});