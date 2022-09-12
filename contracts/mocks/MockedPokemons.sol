//SPDX-License-Identifier: Unlicense
// mocked version of Pokemons contract - *only* used in tests.
pragma solidity 0.8.15;

import "../Pokemons.sol";

/**
 * @title MockedPokemons contract.
 * NOTE: This contract is Mock of Pokemons contract and only for testing purposes.
 * @dev Contract implement mintPokemons()- version of  mintRandomPokemon()
 * from Pokemons contract but without pseudo-randomness.
 */
contract MockedPokemons is Pokemons {
    /**
     * @dev Constructor the same as in Pokemons.
     * @param mintFee_ initial mint price for mintPokemons().
     * @param upgradeLevelFee_ initial fee for upgrades in Level tokens.
     * @param maxSupply_ initial max Supply for tokens.
     * @param level_ address of Level erc-20 standard contract.
     * @param stones_ address of Stones erc-1155 standard contract.
     */
    constructor(
        uint256 mintFee_,
        uint256 upgradeLevelFee_,
        uint256 maxSupply_,
        address level_,
        address stones_
    ) Pokemons(mintFee_, upgradeLevelFee_, maxSupply_, level_, stones_) {}

    /**
     * @dev The user can simply specify the ID of the token to be minted without paying a fee.
     * @param id_ Id of the pokemon to be minted.
     */
    function mintPokemons(uint256 id_) external payable {
        _mint(msg.sender, id_, 1, "");
        emit NewPokemon(id_, block.timestamp, msg.sender);
    }
}
