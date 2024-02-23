import { ethers } from "hardhat";

async function main() {
    const votablePollFactoryContract = "0x5FbDB2315678afecb367f032d93F642f64180aa3";

    const VotablePollFactory = await ethers.getContractAt("IVotablePollFactory", votablePollFactoryContract);

    const createVotablePoll = await VotablePollFactory.createPoll();
    await createVotablePoll.wait();

    const clones = await VotablePollFactory.fetchDeployedPolls();

    console.log(clones)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});