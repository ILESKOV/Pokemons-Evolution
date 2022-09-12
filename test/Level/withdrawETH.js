const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")
const utils = ethers.utils

let owner, Token

beforeEach(async () => {
    ;[owner, wallet1, wallet2] = await ethers.getSigners()
    provider = ethers.getDefaultProvider()

    level = await ethers.getContractFactory("Level", owner)
    Level = await level.deploy("1000000000000000000000", "50000000000000000")

    await Level.connect(wallet2).buyLevelTokens({
        value: ethers.utils.parseEther("0.05"),
    })
    await Level.connect(wallet2).buyLevelTokens({
        value: ethers.utils.parseEther("0.05"),
    })
})
describe("withdrawETH tests", function () {
    describe("negative tests", function () {
        it("should revert if not owner is caller", async () => {
            await expect(Level.connect(wallet1).withdrawETH(BigNumber.from("1000000000000000000"))).to.be.revertedWith(
                "Ownable: caller is not the owner"
            )
        })
        it("should revert if owner request too much ETH", async () => {
            await expect(Level.withdrawETH(BigNumber.from("10000000000000000000"))).to.be.revertedWith("Not enough ETH")
        })
    })
    describe("positive tests", function () {
        it("should check amount of ether chanched after owner withdrawed ETH", async () => {
            await Level.withdrawETH(BigNumber.from("30000000000000000"))
            expect(await ethers.provider.getBalance(Level.address)).to.equal("70000000000000000")
        })
        it("should emit an WithdrawalOfOwner event", async () => {
            await expect(Level.withdrawETH(BigNumber.from("100000000000000000")))
                .to.emit(Level, "WithdrawalOfOwner")
                .withArgs(owner.address, BigNumber.from("100000000000000000"))
        })
    })
})
