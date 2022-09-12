const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("buyStone function tests", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        stones = await ethers.getContractFactory("Stones", owner)
        Stones = await stones.deploy("50000000000000000")
    })
    describe("negative tests", function () {
        it("should revert if buyer call function without ether", async function () {
            await expect(Stones.connect(wallet1).buyStone(3)).to.be.revertedWith("Not enough ETH to buy stone")
        })
        it("should revert if buyer specify not enough amount of ether", async function () {
            await expect(
                Stones.connect(wallet1).buyStone(3, {
                    value: ethers.utils.parseEther("0.049"),
                })
            ).to.be.revertedWith("Not enough ETH to buy stone")
        })
    })
    describe("positive tests", function () {
        it("should mint successfully 1 token", async function () {
            await Stones.connect(wallet1).buyStone(3, {
                value: ethers.utils.parseEther("0.05"),
            })
            expect(await Stones.balanceOf(wallet1.address, 3)).to.equal("1")
        })
        it("should mint successfully 4 tokens", async function () {
            await Stones.connect(wallet2).buyStone(7, {
                value: ethers.utils.parseEther("0.24"),
            })
            expect(await Stones.balanceOf(wallet2.address, 7)).to.equal("4")
        })
        it("should emit an StoneBuyed event", async () => {
            await expect(
                Stones.connect(wallet1).buyStone(3, {
                    value: ethers.utils.parseEther("0.05"),
                })
            )
                .to.emit(Stones, "StoneBuyed")
                .withArgs(wallet1.address, 3, 1)
        })
    })
})
