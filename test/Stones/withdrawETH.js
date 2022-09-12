const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")
const utils = ethers.utils

let owner, Token

beforeEach(async () => {
    ;[owner, wallet1, wallet2] = await ethers.getSigners()
    provider = ethers.getDefaultProvider()

    stones = await ethers.getContractFactory("Stones", owner)
    Stones = await stones.deploy("50000000000000000")

    await Stones.connect(wallet1).buyStone(3, {
        value: ethers.utils.parseEther("0.05"),
    })
    await Stones.connect(wallet1).buyStone(3, {
        value: ethers.utils.parseEther("0.05"),
    })
})
describe("withdrawETH tests", function () {
    describe("negative tests", function () {
        it("should revert if not owner is caller", async () => {
            await expect(Stones.connect(wallet1).withdrawETH(BigNumber.from("1000000000000000000"))).to.be.revertedWith(
                "Ownable: caller is not the owner"
            )
        })
        it("should revert if owner request too much ETH", async () => {
            await expect(Stones.withdrawETH(BigNumber.from("10000000000000000000"))).to.be.revertedWith(
                "Not enough ETH"
            )
        })
    })
    describe("positive tests", function () {
        it("should check amount of ether chanched after owner withdrawed ETH", async () => {
            await Stones.withdrawETH(BigNumber.from("30000000000000000"))
            expect(await ethers.provider.getBalance(Stones.address)).to.equal("70000000000000000")
        })
        it("should emit an WithdrawalOfOwner event", async () => {
            await expect(Stones.withdrawETH(BigNumber.from("100000000000000000")))
                .to.emit(Stones, "WithdrawalOfOwner")
                .withArgs(owner.address, BigNumber.from("100000000000000000"))
        })
    })
})
