// const hre = require("hardhat")
// const ethers = require("hardhat");
require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()

async function main() {
  const hello = await ethers.getContractFactory("Lending");
  const lending = await hello.deploy("0xeb7A892BB04A8f836bDEeBbf60897A7Af1Bf5d7F");

  await lending.deployed();
  console.log(lending.address)

  // console.log(
  //   `Lock with 1 ETH and unlock timestamp ${unlockTime} deployed to ${lock.address}`
  // );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// const hre = require("hardhat");

// async function main() {
//   console.log("deploying...");
//   const MarketInteractions = await hre.ethers.getContractFactory(
//     "Lending"
//   );
//   const marketInteractions = await MarketInteractions.deploy(
//     "0xeb7A892BB04A8f836bDEeBbf60897A7Af1Bf5d7F"
//   );

//   await marketInteractions.deployed();

//   console.log(
//     "MarketInteractions loan contract deployed: ",
//     marketInteractions.address
//   );
// }

// main().catch((error) => {
//   console.error(error);
//   process.exitCode = 1;
// });