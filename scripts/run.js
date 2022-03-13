const main = async () => {
  const nftContractFactory = await hre.ethers.getContractFactory("EpicNFT");
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log("Contract deployed to:", nftContract.address);

  // Call Mint function
  let txn = await nftContract.mintEpicNFT();
  // Wait for txn mined
  await txn.wait();

  //Mint another NFT
  txn = await nftContract.mintEpicNFT();
  //wait for mined
  await txn.wait();
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
