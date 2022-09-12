const { expect } = require("chai")
const { BigNumber } = require("ethers")
const { ethers } = require("hardhat")

describe("tests of checkAvailableEvolve function", function () {
    beforeEach(async function () {
        ;[owner, wallet1, wallet2] = await ethers.getSigners()

        level = await ethers.getContractFactory("Level", owner)
        Level = await level.deploy("1000000000000000000000", "2000000000000000")

        stones = await ethers.getContractFactory("Stones", owner)
        Stones = await stones.deploy("50000000000000000")

        pokemons = await ethers.getContractFactory("Pokemons", owner)
        Pokemons = await pokemons.deploy("50000000000000", "16000000000000000000", 4, Level.address, Stones.address)
    })

    it("should return id of thunder stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(603))[0]).to.equal("0")
    })
    it("should return id of moon stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(33))[0]).to.equal("1")
    })
    it("should return id of fire stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(58))[0]).to.equal("2")
    })
    it("should return id of leaf stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(102))[0]).to.equal("3")
    })
    it("should return id of sun stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(191))[0]).to.equal("4")
    })
    it("should return id of water stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(515))[0]).to.equal("5")
    })
    it("should return id of black augurite for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(123))[0]).to.equal("6")
    })
    it("should return id of shiny stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(315))[0]).to.equal("7")
    })
    it("should return id of dusk stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(200))[0]).to.equal("8")
    })
    it("should return id of razor claw for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(215))[0]).to.equal("9")
    })
    it("should return id of peat block for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(217))[0]).to.equal("10")
    })
    it("should return id of tart apple for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(840))[0]).to.equal("11")
    })
    it("should return id of cracked pot for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(854))[0]).to.equal("12")
    })
    it("should return id of oval stone for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(440))[0]).to.equal("13")
    })
    it("should return id of level Evolve for the pokemon required this type of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(27))[0]).to.equal("14")
    })
    it("should return id of not availability of Evolve", async () => {
        expect((await Pokemons.checkAvailableEvolve(28))[0]).to.equal("15")
    })
})
