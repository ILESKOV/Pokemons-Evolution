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
describe("withdrawETH tests", function () {
    describe("negative tests", function () {
        it("should revert if not owner is caller", async () => {
            await expect(
                Pokemons.connect(wallet1).withdrawETH(BigNumber.from("1000000000000000000"))
            ).to.be.revertedWith("Ownable: caller is not the owner")
        })
        it("should revert if owner request too much ETH", async () => {
            await expect(Pokemons.withdrawETH(BigNumber.from("10000000000000000000"))).to.be.revertedWith(
                "Not enough ETH"
            )
        })
    })
    describe("positive tests", function () {
        it("should check amount of ether chanched after owner withdrawed ETH", async () => {
            await Pokemons.withdrawETH(BigNumber.from("30000000000000000"))
            expect(await ethers.provider.getBalance(Pokemons.address)).to.equal("70000000000000000")
        })
        it("should emit an WithdrawalOfOwner event", async () => {
            await expect(Pokemons.withdrawETH(BigNumber.from("100000000000000000")))
                .to.emit(Pokemons, "WithdrawalOfOwner")
                .withArgs(owner.address, BigNumber.from("100000000000000000"))
        })
    })
})
