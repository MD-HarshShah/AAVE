require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks:{
    polygon_mumbai: {
    url: "https://polygon-mumbai.g.alchemy.com/v2/I_qu-j_NdqowJJXi3zJcUQPe6z4Yf9id",
    accounts: [process.env.PRIVATE_KEY]
  }
 }
};
