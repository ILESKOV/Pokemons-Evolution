const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("setMaxSupply function tests", function () {
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
            await expect(Pokemons.connect(wallet1).setMaxSupply(7)).to.be.revertedWith(
                "Ownable: caller is not the owner"
            )
        })
        it("should revert if tokens price intendent to set to zero", async function () {
            await expect(Pokemons.setMaxSupply(0)).to.be.revertedWith("Max supply cannot be zero")
        })
        it("should revert max supply lower than total supply", async function () {
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await expect(Pokemons.setMaxSupply(1)).to.be.revertedWith("Max supply cannot be lower than total supply")
        })
    })
    describe("positive tests", function () {
        it("should change max supply successfully", async function () {
            await Pokemons.setMaxSupply(7)
            expect(await Pokemons.getMaxSupply()).to.equal(7)
        })
        it("should return Total Supply successfully", async () => {
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            expect(await Pokemons.getTotalSupply()).to.equal(2)
        })
        it("should emit an MaxSupplyUpdated event", async () => {
            await expect(Pokemons.setMaxSupply(7)).to.emit(Pokemons, "MaxSupplyUpdated").withArgs(7)
        })
    })
})
