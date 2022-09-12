const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("setTokenPrice function tests", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        level = await ethers.getContractFactory("Level", owner)
        Level = await level.deploy("1000000000000000000000", "50000000000000000")
    })
    describe("negative tests", function () {
        it("should revert if caller not the owner of the contract", async function () {
            await expect(Level.connect(wallet1).setTokenPrice("70000000000000000")).to.be.revertedWith(
                "Ownable: caller is not the owner"
            )
        })
        it("should revert if tokens price intendent to set to zero", async function () {
            await expect(Level.setTokenPrice(0)).to.be.revertedWith("New token price cannot be zero")
        })
    })
    describe("positive tests", function () {
        it("should change token price successfully", async function () {
            await Level.setTokenPrice("70000000000000000")
            expect(await Level.getTokenPrice()).to.equal("70000000000000000")
        })
        it("should emit an TokenPriceUpdated event", async () => {
            blockNumAfter = await ethers.provider.getBlockNumber()
            blockAfter = await ethers.provider.getBlock(blockNumAfter)
            timestampAfter = blockAfter.timestamp
            await expect(Level.setTokenPrice("70000000000000000"))
                .to.emit(Level, "TokenPriceUpdated")
                .withArgs("70000000000000000", timestampAfter + 1)
        })
    })
})
