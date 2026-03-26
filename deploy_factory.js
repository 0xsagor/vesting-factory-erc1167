const hre = require("hardhat");

async function main() {
  // 1. Deploy Implementation Logic
  const Logic = await hre.ethers.getContractFactory("VestingLogic");
  const logic = await Logic.deploy();
  await logic.waitForDeployment();
  const logicAddr = await logic.getAddress();

  // 2. Deploy Factory pointing to Logic
  const Factory = await hre.ethers.getContractFactory("VestingFactory");
  const factory = await Factory.deploy(logicAddr);
  await factory.waitForDeployment();

  console.log(`Vesting Logic: ${logicAddr}`);
  console.log(`Vesting Factory: ${await factory.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
