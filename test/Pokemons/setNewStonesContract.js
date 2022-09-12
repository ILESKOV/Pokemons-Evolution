const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("setNewStonesContract function tests", function () {
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
            await expect(
                Pokemons.connect(wallet1).setNewStonesContract("0x1D669e9794c2de0d487092932cbA527f9bBc8138")
            ).to.be.revertedWith("Ownable: caller is not the owner")
        })
        it("should revert if Stones intendent to set to zero address", async function () {
            await expect(
                Pokemons.setNewStonesContract("0x0000000000000000000000000000000000000000")
            ).to.be.revertedWith("Stones cannot be zero address")
        })
    })
    describe("positive tests", function () {
        it("should change Stones instance successfully", async function () {
            await Pokemons.setNewStonesContract("0x1D669e9794c2de0d487092932cbA527f9bBc8138")
            expect(await Pokemons.getStonesAddress()).to.equal("0x1D669e9794c2de0d487092932cbA527f9bBc8138")
        })
        it("should emit an NewStonesContract event", async () => {
            await expect(Pokemons.setNewStonesContract("0x1D669e9794c2de0d487092932cbA527f9bBc8138"))
                .to.emit(Pokemons, "NewStonesContract")
                .withArgs("0x1D669e9794c2de0d487092932cbA527f9bBc8138")
        })
    })
})
