var { ethers } = require("ethers");

var provider = new ethers.InfuraProvider();

console.log(provider);

var newBlock = (blockNumber) => {
  console.log("new block: ", blockNumber);
  provider.getBlock(blockNumber).then(console.log);
};

provider.on("block", newBlock);
// provider.off("block", newBlock);
