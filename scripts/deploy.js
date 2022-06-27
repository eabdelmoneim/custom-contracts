const hre = require("hardhat");
require("@nomiclabs/hardhat-etherscan");

async function main() {
    const checkVerify = await hre.ethers.getContractFactory("CheckVerify").then(f => f.deploy(123));
    console.log("Deploying CheckVerify \ntransaction: ", checkVerify.deployTransaction.hash, "\naddress: ", checkVerify.address);
    await checkVerify.deployTransaction.wait();

    // await verify(checkVerify.address, [123]);
}

// async function verify(address, args) {
//     try {
//       return await hre.run("verify:verify", {
//         address: address,
//         constructorArguments: args,
//       });
//     } catch (e) {
//       console.log(address, args, e);
//     }
// }

main()
.then(() => process.exit(0))
.catch((e) => {
    console.error(e)
    process.exit(1)
});