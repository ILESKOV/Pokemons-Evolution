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

    await Pokemons.connect(wallet1).mintPokemon({
        value: ethers.utils.parseEther("0.05"),
    })
    await Pokemons.connect(wallet1).mintPokemon({
        value: ethers.utils.parseEther("0.05"),
    })
})
describe("uri test", function () {
    it("return correct uri", async () => {
        expect(await Pokemons.connect(wallet1).uri(777)).to.equal(
            "ipfs://bafybeidhzhc5wjpdvqjldvl5pkbq4lxf2udwkltfx5qzo6gn327xpidpue/777"
        )
    })
})
