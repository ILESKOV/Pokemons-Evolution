require("@nomiclabs/hardhat-waffle")
require("@nomiclabs/hardhat-solhint")
require("@nomiclabs/hardhat-etherscan")
require("solidity-coverage")
require("dotenv").config()
require("solidity-docgen")
require("hardhat-contract-sizer")

const PRIVATE_KEY = process.env.PRIVATE_KEY

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
    const accounts = await hre.ethers.getSigners()

    for (const account of accounts) {
        console.log(account.address)
    }
})

module.exports = {
    solidity: {
        version: "0.8.15",
        settings: {
            optimizer: {
                enabled: true,
                runs: 200,
            },
        },
    },
    contractSizer: {
        alphaSort: false,
        disambiguatePaths: true,
        runOnCompile: true,
        strict: false,
        only: [],
    },
    networks: {
        hardhat: {
            initialBaseFeePerGas: 0,
        },
        goerli: {
            url: process.env.GOERLI_API,
            accounts: [PRIVATE_KEY],
        },
        ethereum: {
            chainId: 1,
            url: process.env.MAINNET_API,
            accounts: [PRIVATE_KEY],
        },
        matic: {
            url: process.env.MUMBAI_API,
            accounts: [PRIVATE_KEY],
        },
        bsc: {
            url: process.env.BSC_TESTNET_API,
            accounts: [PRIVATE_KEY],
        },
        fuji: {
            url: process.env.AVALANCHE_FUJI_API,
            accounts: [PRIVATE_KEY],
        },
        fantom: {
            url: process.env.FANTOM_TESTNET_API,
            accounts: [PRIVATE_KEY],
        },
    },
    etherscan: {
        apiKey: process.env.POLYGONSCAN_KEY,
    },
}
