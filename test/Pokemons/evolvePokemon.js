const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("tests of evolvePokemon function", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        level = await ethers.getContractFactory("Level", owner)
        Level = await level.deploy("1000000000000000000000", "2000000000000000")

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
        it("should revert if user not the owner of the token", async function () {
            await expect(MockedPokemons.connect(wallet1).evolvePokemon(158)).to.be.revertedWith("Caller not the owner")
        })
        it("should revert if the user does not have a stone for the pokemon to evolve", async function () {
            await MockedPokemons.connect(wallet1).mintPokemons(271, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await expect(MockedPokemons.connect(wallet1).evolvePokemon(271)).to.be.revertedWith(
                "ERC1155: caller is not token owner nor approved"
            )
        })
        it("should revert if the user does not approve tokens", async function () {
            await MockedPokemons.connect(wallet1).mintPokemons(7, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await expect(MockedPokemons.connect(wallet1).evolvePokemon(7)).to.be.revertedWith(
                "ERC20: insufficient allowance"
            )
        })
        it("should revert if this pokemon is the last in the chain of evolution", async function () {
            await MockedPokemons.connect(wallet1).mintPokemons(470, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await expect(MockedPokemons.connect(wallet1).evolvePokemon(470)).to.be.revertedWith(
                "Token cannot be updated"
            )
        })
    })
    describe("positive tests", function () {
        it("should evolve Gloom pokemon to Vileplum with LEAF_STONE", async () => {
            await MockedPokemons.connect(wallet1).mintPokemons(44, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Stones.connect(wallet1).buyStone(3, {
                value: ethers.utils.parseEther("0.05"),
            })
            await Stones.connect(wallet1).setApprovalForAll(MockedPokemons.address, true)
            await MockedPokemons.connect(wallet1).evolvePokemon(44)
            expect(await MockedPokemons.balanceOf(wallet1.address, 45)).to.equal("1")
        })
        it("should emit an EvolvedWithStone event", async () => {
            await MockedPokemons.connect(wallet1).mintPokemons(44, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Stones.connect(wallet1).buyStone(3, {
                value: ethers.utils.parseEther("0.05"),
            })
            await Stones.connect(wallet1).setApprovalForAll(MockedPokemons.address, true)

            blockNumAfter = await ethers.provider.getBlockNumber()
            blockAfter = await ethers.provider.getBlock(blockNumAfter)
            timestampAfter = blockAfter.timestamp
            await expect(MockedPokemons.connect(wallet1).evolvePokemon(44))
                .to.emit(MockedPokemons, "EvolvedWithStone")
                .withArgs(44, 45, 3, timestampAfter + 1, wallet1.address)
        })
        it("should burn LEAF_STONE after upgrading", async () => {
            await MockedPokemons.connect(wallet1).mintPokemons(44, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Stones.connect(wallet1).buyStone(3, {
                value: ethers.utils.parseEther("0.05"),
            })
            await Stones.connect(wallet1).setApprovalForAll(MockedPokemons.address, true)
            await MockedPokemons.connect(wallet1).evolvePokemon(44)
            expect(await Stones.balanceOf(wallet1.address, 3)).to.equal("0")
        })
        it("should evolve Charmander pokemon to Charmeleon with Level tokens", async () => {
            await MockedPokemons.connect(wallet1).mintPokemons(4, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Level.connect(wallet1).buyLevelTokens({
                value: ethers.utils.parseEther("0.5"),
            })
            await Level.connect(wallet1).approve(MockedPokemons.address, "50000000000000000000")
            await MockedPokemons.connect(wallet1).evolvePokemon(4)
            expect(await MockedPokemons.balanceOf(wallet1.address, 5)).to.equal("1")
        })
        it("should check Level tokens was burnt", async () => {
            await Level.connect(wallet1).buyLevelTokens({
                value: ethers.utils.parseEther("0.5"),
            })
            await MockedPokemons.connect(wallet1).mintPokemons(4, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Level.connect(wallet1).approve(MockedPokemons.address, "50000000000000000000") //
            await MockedPokemons.connect(wallet1).evolvePokemon(4)
            expect(await Level.balanceOf(wallet1.address)).to.equal("234000000000000000000")
        })
        it("should evolve Charmeleon pokemon to Charizard with Level tokens", async () => {
            await MockedPokemons.connect(wallet1).mintPokemons(4, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Level.connect(wallet1).buyLevelTokens({
                value: ethers.utils.parseEther("0.5"),
            })
            await Level.connect(wallet1).approve(MockedPokemons.address, "50000000000000000000") //
            await MockedPokemons.connect(wallet1).evolvePokemon(4)
            await MockedPokemons.connect(wallet1).evolvePokemon(5)
            expect(await MockedPokemons.balanceOf(wallet1.address, 6)).to.equal("1")
        })
        it("should check Level tokens was burnt", async () => {
            await Level.connect(wallet1).buyLevelTokens({
                value: ethers.utils.parseEther("0.5"),
            })
            await MockedPokemons.connect(wallet1).mintPokemons(4, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Level.connect(wallet1).approve(MockedPokemons.address, "50000000000000000000") //
            await MockedPokemons.connect(wallet1).evolvePokemon(4)
            await MockedPokemons.connect(wallet1).evolvePokemon(5)
            expect(await Level.balanceOf(wallet1.address)).to.equal("218000000000000000000")
        })
        it("should evolve Wartortle pokemon to Blastoise with Level tokens", async () => {
            await MockedPokemons.connect(wallet1).mintPokemons(8, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Level.connect(wallet1).buyLevelTokens({
                value: ethers.utils.parseEther("0.5"),
            })
            await Level.connect(wallet1).approve(MockedPokemons.address, "50000000000000000000")
            await MockedPokemons.connect(wallet1).evolvePokemon(8)
            expect(await MockedPokemons.balanceOf(wallet1.address, 9)).to.equal("1")
        })
        it("should emit an EvolvedWithLevel event", async () => {
            await Level.connect(wallet1).buyLevelTokens({
                value: ethers.utils.parseEther("0.5"),
            })
            await MockedPokemons.connect(wallet1).mintPokemons(4, {
                value: ethers.utils.parseEther("0.0005"),
            })
            await Level.connect(wallet1).approve(MockedPokemons.address, "50000000000000000000")
            blockNumAfter = await ethers.provider.getBlockNumber()
            blockAfter = await ethers.provider.getBlock(blockNumAfter)
            timestampAfter = blockAfter.timestamp
            await expect(MockedPokemons.connect(wallet1).evolvePokemon(4))
                .to.emit(MockedPokemons, "EvolvedWithLevel")
                .withArgs(4, 5, timestampAfter + 1, wallet1.address)
        })
    })
})
