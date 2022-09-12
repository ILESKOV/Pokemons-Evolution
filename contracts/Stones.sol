// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Stones contract.
 * NOTE: The contract of the erc-1155 standard "Stones" NFT tokens.
 */
contract Stones is ERC1155Burnable, Ownable {
    uint256 public constant THUNDER_STONE = 0;
    uint256 public constant MOON_STONE = 1;
    uint256 public constant FIRE_STONE = 2;
    uint256 public constant LEAF_STONE = 3;
    uint256 public constant SUN_STONE = 4;
    uint256 public constant WATER_STONE = 5;
    uint256 public constant BLACK_AUGURITE = 6;
    uint256 public constant SHINY_STONE = 7;
    uint256 public constant DUSK_STONE = 8;
    uint256 public constant RAZOR_CLAW = 9;
    uint256 public constant PEAT_BLOCK = 10;
    uint256 public constant TART_APPLE = 11;
    uint256 public constant CRACKED_POT = 12;
    uint256 public constant OVAL_STONE = 13;
    uint256 private _stonePrice;

    /**
     * @dev Emitted when buyStone() occure.
     * @param owner owner of the minted tokens.
     * @param stoneId Id of minted tokens.
     * @param amount amount of minted tokens.
     */
    event StoneBuyed(address owner, uint256 indexed stoneId, uint256 indexed amount);

    /**
     * @dev Emitted when setStonePrice() occure.
     * @param newStonePrice new price for `stone` type tokens.
     * @param timeOfChanging time when update occur.
     */
    event StonePriceUpdated(uint256 newStonePrice, uint256 timeOfChanging);

    /**
     * @dev Emitted when the owner withdraw ether from the contract.
     * @param owner owner address.
     * @param amount amount of ether.
     */
    event WithdrawalOfOwner(address owner, uint256 indexed amount);

    /**
     * @dev Sets up the stone price and mint initial tokens to the owner.
     * @param stonePrice_ initial mint price for stones tokens.
     */
    constructor(uint256 stonePrice_) ERC1155("https://game.example/api/item/{id}.json") {
        require(stonePrice_ > 0, "Stones price cannot be 0");
        _mint(msg.sender, THUNDER_STONE, 10, "");
        _mint(msg.sender, MOON_STONE, 11, "");
        _mint(msg.sender, FIRE_STONE, 12, "");
        _mint(msg.sender, LEAF_STONE, 13, "");
        _mint(msg.sender, SUN_STONE, 14, "");
        _mint(msg.sender, WATER_STONE, 15, "");
        _mint(msg.sender, BLACK_AUGURITE, 16, "");
        _mint(msg.sender, SHINY_STONE, 16, "");
        _mint(msg.sender, DUSK_STONE, 15, "");
        _mint(msg.sender, RAZOR_CLAW, 14, "");
        _mint(msg.sender, PEAT_BLOCK, 13, "");
        _mint(msg.sender, TART_APPLE, 12, "");
        _mint(msg.sender, CRACKED_POT, 11, "");
        _mint(msg.sender, OVAL_STONE, 10, "");
        _stonePrice = stonePrice_;
    }

    /**
     * @dev This is a function for buying `stone` type tokens.
     *
     * Requirements:
     *
     * - providing ether(`msg.value`) must be equal or higher than `_stonePrice`.
     *
     * @param stoneId Id of stone to be minted.
     *
     * Emits a {StoneBuyed} event.
     */
    function buyStone(uint256 stoneId) external payable {
        require(msg.value >= _stonePrice, "Not enough ETH to buy stone");
        uint256 amount = (msg.value / _stonePrice);
        _mint(msg.sender, stoneId, amount, "");
        emit StoneBuyed(msg.sender, stoneId, amount);
    }

    /**
     * @dev Set new `_stonePrice`.
     * @param newStonePrice_ new price for `stone` type tokens.
     *
     * Emits a {StonePriceUpdated} event.
     */
    function setStonePrice(uint256 newStonePrice_) external onlyOwner {
        require(newStonePrice_ > 0, "New token price cannot be zero");
        _stonePrice = newStonePrice_;
        emit StonePriceUpdated(_stonePrice, block.timestamp);
    }

    /**
     * @dev Returns the stone price.
     */
    function getStonePrice() external view returns (uint256) {
        return _stonePrice;
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
