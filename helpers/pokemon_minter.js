const { ethers } = require("ethers")
require("dotenv").config()

const PRIVATE_KEY = process.env.PRIVATE_KEY
const provider = new ethers.providers.JsonRpcProvider(process.env.MUMBAI_API)

const privateKey = PRIVATE_KEY
const wallet = new ethers.Wallet(privateKey, provider)

const ABI = ["function mintPokemon() external payable"]

const address = "0xb9276ba30c6Dc4884054EE60d82A3C59CC50e2ee" // Pokemon Contract
const contract = new ethers.Contract(address, ABI, provider)

const main = async () => {
    const contractWithWallet = contract.connect(wallet)
    for (let i = 0; i < 10; i++) {
        const tx = await contractWithWallet.mintPokemon({ value: ethers.utils.parseEther("0.0025") })
        await tx.wait()

        console.log(tx)
    }
}

main()
