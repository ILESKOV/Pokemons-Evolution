const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("tests of Level contract constructor", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        level = await ethers.getContractFactory("Level", owner)
    })
    describe("negative tests", function () {
        it("should revert if owner set initial supply to zero", async function () {
            await expect(level.deploy(0, "50000000000000000")).to.be.revertedWith("Initial supply cannot be 0")
        })
        it("should revert if owner set token price to zero", async function () {
            await expect(level.deploy("1000000000000000000000", 0)).to.be.revertedWith("Price cannot be 0")
        })
    })
    describe("positive tests", function () {
        it("should assign token price properly", async function () {
            Level = await level.deploy("1000000000000000000000", "50000000000000000")
            expect(await Level.connect(wallet1).getTokenPrice()).to.equal("50000000000000000")
        })
        it("should mint initial tokens to the owner", async function () {
            Level = await level.deploy("1000000000000000000000", "50000000000000000")
            expect(await Level.connect(wallet1).balanceOf(owner.address)).to.equal("1000000000000000000000")
        })
        it("should set owner properly", async function () {
            Level = await level.deploy("1000000000000000000000", "50000000000000000")
            expect(await Level.owner()).to.equal(owner.address)
        })
    })
})
