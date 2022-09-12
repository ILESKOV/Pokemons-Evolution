const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("setStonePrice function tests", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        stones = await ethers.getContractFactory("Stones", owner)
        Stones = await stones.deploy("50000000000000000")
    })
    describe("negative tests", function () {
        it("should revert if caller not the owner of the contract", async function () {
            await expect(Stones.connect(wallet1).setStonePrice("70000000000000000")).to.be.revertedWith(
                "Ownable: caller is not the owner"
            )
        })
        it("should revert if stone price intendent to set to zero", async function () {
            await expect(Stones.setStonePrice(0)).to.be.revertedWith("New token price cannot be zero")
        })
    })
    describe("positive tests", function () {
        it("should change stone price successfully", async function () {
            await Stones.setStonePrice("70000000000000000")
            expect(await Stones.getStonePrice()).to.equal("70000000000000000")
        })
        it("should emit an StonePriceUpdated event", async () => {
            blockNumAfter = await ethers.provider.getBlockNumber()
            blockAfter = await ethers.provider.getBlock(blockNumAfter)
            timestampAfter = blockAfter.timestamp
            await expect(Stones.setStonePrice("70000000000000000"))
                .to.emit(Stones, "StonePriceUpdated")
                .withArgs("70000000000000000", timestampAfter + 1)
        })
    })
})
