const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("buyLevelTokens function tests", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        level = await ethers.getContractFactory("Level", owner)
        Level = await level.deploy("1000000000000000000000", "50000000000000000")
    })
    describe("negative tests", function () {
        it("should revert if buyer call function without ether", async function () {
            await expect(Level.connect(wallet1).buyLevelTokens()).to.be.revertedWith("Not enough ETH to buy tokens")
        })
        it("should revert if buyer specify not enough amount of ether", async function () {
            await expect(
                Level.connect(wallet1).buyLevelTokens({
                    value: ethers.utils.parseEther("0.049"),
                })
            ).to.be.revertedWith("Not enough ETH to buy tokens")
        })
    })
    describe("positive tests", function () {
        it("should mint successfully 1 token", async function () {
            await Level.connect(wallet1).buyLevelTokens({
                value: ethers.utils.parseEther("0.05"),
            })
            expect(await Level.balanceOf(wallet1.address)).to.equal("1000000000000000000")
        })
        it("should mint successfully 5 tokens", async function () {
            await Level.connect(wallet2).buyLevelTokens({
                value: ethers.utils.parseEther("0.27"),
            })
            expect(await Level.balanceOf(wallet2.address)).to.equal("5000000000000000000")
        })
        it("should emit an LevelTokensBuyed event", async () => {
            await expect(
                Level.connect(wallet1).buyLevelTokens({
                    value: ethers.utils.parseEther("0.05"),
                })
            )
                .to.emit(Level, "LevelTokensBuyed")
                .withArgs(wallet1.address, "1000000000000000000")
        })
    })
})
