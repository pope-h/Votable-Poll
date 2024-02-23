import { ethers } from "hardhat";

async function main() {
  const votablePollFactory = await ethers.deployContract("VotablePollFactory");
  await votablePollFactory.waitForDeployment();

  console.log(`votablePollFactory deployed to ${votablePollFactory.target}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
