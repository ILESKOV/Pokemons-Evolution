const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("tests of mint Random Pokemon function", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        level = await ethers.getContractFactory("Level", owner)
        Level = await level.deploy("1000000000000000000000", "50000000000000000")

        stones = await ethers.getContractFactory("Stones", owner)
        Stones = await stones.deploy("50000000000000000")

        pokemons = await ethers.getContractFactory("Pokemons", owner)
        Pokemons = await pokemons.deploy("50000000000000", "16000000000000000000", 4, Level.address, Stones.address)

        mockedPokemons = await ethers.getContractFactory("MockedPokemons", owner)
        MockedPokemons = await mockedPokemons.deploy(
            "50000000000000",
            "16000000000000000000",
            4,
            Level.address,
            Stones.address
        )
    })
    describe("negative tests", function () {
        it("should revert if max supply is reached", async function () {
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await Pokemons.connect(wallet1).mintPokemon({
                value: ethers.utils.parseEther("0.0005"),
            })
            await expect(
                Pokemons.connect(wallet1).mintPokemon({
                    value: ethers.utils.parseEther("0.0005"),
                })
            ).to.be.revertedWith("Collection reached max supply")
        })
        it("should revert if user call function without eth", async function () {
            await expect(Pokemons.connect(wallet1).mintPokemon()).to.be.revertedWith("Mint fee required")
        })
        it("should revert if eth amount is small to mint", async function () {
            await expect(
                Pokemons.connect(wallet1).mintPokemon({
                    value: ethers.utils.parseEther("0.000005"),
                })
            ).to.be.revertedWith("Mint fee required")
        })
    })
    describe("positive tests", function () {
        it("should mint properly token by providing token number in mocked contract", async () => {
            await MockedPokemons.connect(wallet1).mintPokemons(353, {
                value: ethers.utils.parseEther("0.0005"),
            })
            expect(await MockedPokemons.balanceOf(wallet1.address, 353)).to.equal("1")
        })
        it("should emit a NewPokemon event", async () => {
            await expect(
                Pokemons.connect(wallet1).mintPokemon({
                    value: ethers.utils.parseEther("0.0005"),
                })
            ).to.emit(Pokemons, "NewPokemon")
        })

        it("should emit a NewPokemon with args", async () => {
            blockNumAfter = await ethers.provider.getBlockNumber()
            blockAfter = await ethers.provider.getBlock(blockNumAfter)
            timestampAfter = blockAfter.timestamp
            await expect(
                MockedPokemons.connect(wallet1).mintPokemons(155, {
                    value: ethers.utils.parseEther("0.0005"),
                })
            )
                .to.emit(MockedPokemons, "NewPokemon")
                .withArgs(155, timestampAfter + 1, wallet1.address)
        })
    })
})
