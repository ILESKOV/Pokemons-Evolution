const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("tests of Stones contract constructor", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        stones = await ethers.getContractFactory("Stones", owner)
    })
    describe("negative test", function () {
        it("should revert if stone price is set to zero", async function () {
            await expect(stones.deploy(0)).to.be.revertedWith("Stones price cannot be 0")
        })
    })
    describe("positive tests", function () {
        it("should mint thunder tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 0)).to.equal("10")
        })
        it("should mint moon tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 1)).to.equal("11")
        })
        it("should mint fire tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 2)).to.equal("12")
        })
        it("should mint leaf tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 3)).to.equal("13")
        })
        it("should mint sun tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 4)).to.equal("14")
        })
        it("should mint water tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 5)).to.equal("15")
        })
        it("should mint black augurite tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 6)).to.equal("16")
        })
        it("should mint shiny tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 7)).to.equal("16")
        })
        it("should mint dusk tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 8)).to.equal("15")
        })
        it("should mint razor claw tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 9)).to.equal("14")
        })
        it("should mint peat block tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 10)).to.equal("13")
        })
        it("should mint tart apple tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 11)).to.equal("12")
        })
        it("should mint cracked pot tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 12)).to.equal("11")
        })
        it("should mint oval tokens to the owner", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).balanceOf(owner.address, 13)).to.equal("10")
        })
        it("should properly set stone price", async function () {
            Stones = await stones.deploy("50000000000000000")
            expect(await Stones.connect(wallet1).getStonePrice()).to.equal("50000000000000000")
        })
    })
})
