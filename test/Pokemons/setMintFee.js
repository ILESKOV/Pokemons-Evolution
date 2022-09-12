const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("setMintFee function tests", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        level = await ethers.getContractFactory("Level", owner)
        Level = await level.deploy("1000000000000000000000", "2000000000000000")

        stones = await ethers.getContractFactory("Stones", owner)
        Stones = await stones.deploy("50000000000000000")

        pokemons = await ethers.getContractFactory("Pokemons", owner)
        Pokemons = await pokemons.deploy("50000000000000", "16000000000000000000", 4, Level.address, Stones.address)
    })
    describe("negative tests", function () {
        it("should revert if caller not the owner of the contract", async function () {
            await expect(Pokemons.connect(wallet1).setMintFee("70000000000000")).to.be.revertedWith(
                "Ownable: caller is not the owner"
            )
        })
        it("should revert if mint fee intendent to set to zero", async function () {
            await expect(Pokemons.setMintFee(0)).to.be.revertedWith("Mint Fee cannot be zero")
        })
    })
    describe("positive tests", function () {
        it("should change mint fee successfully", async function () {
            await Pokemons.setMintFee("70000000000000")
            expect(await Pokemons.getMintFee()).to.equal("70000000000000")
        })
        it("should emit an MintFeeUpdated event", async () => {
            await expect(Pokemons.setMintFee("70000000000000"))
                .to.emit(Pokemons, "MintFeeUpdated")
                .withArgs("70000000000000")
        })
    })
})
