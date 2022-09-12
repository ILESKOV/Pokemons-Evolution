// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Level contract.
 * NOTE: The contract of the erc-20 standard "Level" tokens.
 */
contract Level is ERC20Burnable, Ownable {
    uint256 private _tokenPrice;

    /**
     * @dev Emitted when buyLevelTokens() occure.
     * @param owner owner of the minted tokens.
     * @param amount amount of the minted tokens.
     */
    event LevelTokensBuyed(address owner, uint256 amount);

    /**
     * @dev Emitted when setTokenPrice() occure.
     * @param newTokenPrice new price for 1 token with 18 decimals.
     * @param timeOfChanging time when update occur.
     */
    event TokenPriceUpdated(uint256 newTokenPrice, uint256 timeOfChanging);

    /**
     * @dev Emitted when the owner withdraw ether from the contract.
     * @param owner owner address.
     * @param amount amount of ether.
     */
    event WithdrawalOfOwner(address owner, uint256 indexed amount);

    /**
     * @dev Sets up `_tokenPrice` and mint `initialSupply_` to the owner.
     * @param initialSupply_ amount of tokens to be minted to the owner of the contract.
     * @param tokenPrice_ price for 1 token with 18 decimals.
     */
    constructor(uint256 initialSupply_, uint256 tokenPrice_) ERC20("Level", "LVL") {
        require(initialSupply_ > 0, "Initial supply cannot be 0");
        require(tokenPrice_ > 0, "Price cannot be 0");
        _mint(msg.sender, initialSupply_);
        _tokenPrice = tokenPrice_;
    }

    /**
     * @dev This is a function for buying `level` type tokens.
     *
     * Requirements:
     *
     * - providing ether(`msg.value`) must be equal or higher than `_tokenPrice`.
     *
     * Emits a {LevelTokensBuyed} event.
     */
    function buyLevelTokens() external payable {
        require(msg.value >= _tokenPrice, "Not enough ETH to buy tokens");
        uint256 amount = ((msg.value / _tokenPrice) * 10**18);
        _mint(msg.sender, amount);
        emit LevelTokensBuyed(msg.sender, amount);
    }

    /**
     * @dev Set new `_tokenPrice`.
     * @param newTokenPrice_ new price for 1 token with 18 decimals.
     *
     * Emits a {TokenPriceUpdated} event.
     */
    function setTokenPrice(uint256 newTokenPrice_) external onlyOwner {
        require(newTokenPrice_ > 0, "New token price cannot be zero");
        _tokenPrice = newTokenPrice_;
        emit TokenPriceUpdated(_tokenPrice, block.timestamp);
    }

    /**
     * @dev Returns the token price.
     */
    function getTokenPrice() external view returns (uint256) {
        return _tokenPrice;
    }

    /**
     * @dev Owner can withdraw Ether from contract.
     *
     * Emits a {WithdrawalOfOwner} event.
     */
    function withdrawETH(uint256 amount) external onlyOwner {
        require(amount <= address(this).balance, "Not enough ETH");
        payable(owner()).transfer(amount);
        emit WithdrawalOfOwner(msg.sender, amount);
    }
}
