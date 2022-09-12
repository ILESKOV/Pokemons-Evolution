const hre = require("hardhat")
require("dotenv").config()
const { INITIAL_LEVEL_SUPPLY, LEVEL_TOKEN_PRICE, STONES_TOKEN_PRICE, MINT_POKEMON_FEE, UPGRADE_IN_LEVEL_FEE } =
    process.env

async function main() {
    const level = await hre.ethers.getContractFactory("Level")
    const Level = await level.deploy(INITIAL_LEVEL_SUPPLY, LEVEL_TOKEN_PRICE)

    console.log("Level deployed to:", Level.address)

    const stones = await hre.ethers.getContractFactory("Stones")
    const Stones = await stones.deploy(STONES_TOKEN_PRICE)

    console.log("Stones deployed to:", Stones.address)

    const pokemons = await hre.ethers.getContractFactory("Pokemons")
    const Pokemons = await pokemons.deploy(MINT_POKEMON_FEE, UPGRADE_IN_LEVEL_FEE, Level.address, Stones.address)

    console.log("Pokemons deployed to:", Pokemons.address)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
