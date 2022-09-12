//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.15;

import "./interfaces/IERC20Burnable.sol";
import "./interfaces/IERC1155Burnable.sol";
import "./PokemonStorage.sol";

/**
 * @title Pokemons contract.
 * NOTE: The contract allows to mint any pokemon, as well as evolve them following the rules
 * from the official game outside the blockchain.
 */
contract Pokemons is PokemonStorage {
    uint256 private _mintFee;
    uint256 private _evolveLevelFee;
    uint256 private _totalSupply;
    uint256 private _maxSupply;
    IERC20Burnable private _level;
    IERC1155Burnable private _stones;

    /**
     * @dev Emitted when the owner withdraw ether from the contract.
     * @param owner owner address.
     * @param amount amount of ether.
     */
    event WithdrawalOfOwner(address owner, uint256 indexed amount);

    /**
     * @dev Emitted when the owner of the contract call setMaxSupply().
     * @param newMaxSupply new _maxSupply.
     */
    event MaxSupplyUpdated(uint256 newMaxSupply);

    /**
     * @dev Emitted when the owner of the contract call setMintFee().
     * @param newFeePrice new fee for minting pokemons.
     */
    event MintFeeUpdated(uint256 newFeePrice);

    /**
     * @dev Emitted when the owner of the contract call setEvolveLevelFee().
     * @param evolveFeeUpdated new fee for evolving pokemons.
     */
    event EvolveFeeUpdated(uint256 evolveFeeUpdated);

    /**
     * @dev Emitted when the owner of the contract call setNewLevelContract().
     * @param level new `Level` instance.
     */
    event NewLevelContract(IERC20Burnable level);

    /**
     * @dev Emitted when the owner of the contract call setNewStonesContract().
     * @param stones new `Stones` instance.
     */
    event NewStonesContract(IERC1155Burnable stones);

    /**
     * @dev Emitted when new token minted.
     * @param tokenId token Id.
     * @param mintTime block.timestamp of mint.
     * @param owner address of the owner of the token.
     */
    event NewPokemon(uint256 indexed tokenId, uint256 mintTime, address owner);

    /**
     * @dev Emitted when evolveWithLevel() occured.
     * @param tokenId token Id.
     * @param newTokenId token Id of new Token.
     * @param evolutionTime block.timestamp of evolution.
     * @param owner address of the owner of the token.
     */
    event EvolvedWithLevel(uint256 indexed tokenId, uint256 indexed newTokenId, uint256 evolutionTime, address owner);

    /**
     * @dev Emitted when evolveWithStone() occured.
     * @param tokenId token Id.
     * @param newTokenId token Id of new Token.
     * @param stoneId Id of the stone erc-1155 token that was used to evolve the pokemon.
     * @param evolutionTime block.timestamp of evolution.
     * @param owner address of the owner of the token.
     */
    event EvolvedWithStone(
        uint256 indexed tokenId,
        uint256 indexed newTokenId,
        uint256 stoneId,
        uint256 evolutionTime,
        address owner
    );

    /**
     * @dev Sets up the mint fee, the Evolve fee, and both IERC20Burnable IERC1155Burnable instances.
     * @param mintFee_ initial mint price for mintPokemon().
     * @param evolveLevelFee_ initial fee for Evolves in Level tokens.
     * @param maxSupply_ initial max Supply for tokens.
     * @param level_ address of Level erc-20 standard contract.
     * @param stones_ address of Stones erc-1155 standard contract.
     */
    constructor(
        uint256 mintFee_,
        uint256 evolveLevelFee_,
        uint256 maxSupply_,
        address level_,
        address stones_
    ) {
        require(mintFee_ > 0, "Mint Fee cannot be 0");
        require(evolveLevelFee_ > 0, "Evolve Level Fee cannot be 0");
        require(maxSupply_ > 0, "Max supply cannot be zero");
        require(level_ != address(0), "ERC-20 cannot be zero address");
        require(stones_ != address(0), "ERC-1155 cannot be zero address");
        _mintFee = mintFee_;
        _evolveLevelFee = evolveLevelFee_;
        _maxSupply = maxSupply_;
        _level = IERC20Burnable(level_);
        _stones = IERC1155Burnable(stones_);
    }

    /**
     * @dev This is a function to mint Pokémon tokens dependig on pseudo randomness.
     * One of 905 different Pokémon is pseudo - randomly selected and minted to the user.
     * The mint costs ether and the price of the mint is set by the owner.
     *
     * Requirements:
     *
     * - `msg.value` must be higher or equal to `_mintFee`.
     * - Users can mint tokens until the `_maxSupply` value is reached.
     *
     * Emits a {NewPokemon} event.
     */
    function mintPokemon() external payable {
        require(_totalSupply <= _maxSupply, "Collection reached max supply");
        require(msg.value >= _mintFee, "Mint fee required");
        uint256 pseudoRandom = (uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) %
            905) + 1;
        _totalSupply++;
        _mint(msg.sender, pseudoRandom, 1, "");
        emit NewPokemon(pseudoRandom, block.timestamp, msg.sender);
    }

    /**
     * @dev This is a function for Pokémon evolution. Contract has data about every
     * real Level type and Stone type evolutions.
     *
     * Requirements:
     *
     * - Users can evolve Pokemons until the `_maxSupply` value is reached.
     * - The caller must be the owner of the token specified as a parameter.
     * - If such an evolution option exists, the user must buy level/stone tokens depending on the type of evolution.
     * - The user must buy and approve one `stone` type token for this contract if the evolutionWithStone() occured.
     * - The user must buy and approve `_evolveLevelFee` amount of `level` tokens for this contract if
     * the evolveWithLevel() occured.
     *
     * @param pokemonNumber_ pokemon id to be evolved.
     *
     * Emits a {EvolvedWithStone} or {EvolvedWithLevel} event.
     */
    function evolvePokemon(uint256 pokemonNumber_) external {
        require(_totalSupply <= _maxSupply, "Collection reached max supply");
        require(balanceOf(msg.sender, pokemonNumber_) > 0, "Caller not the owner");
        (uint256 whichMethodOfEvolve, uint256 newPokemonId) = checkAvailableEvolve(pokemonNumber_);
        if (whichMethodOfEvolve < 14) {
            evolveWithStone(pokemonNumber_, newPokemonId, whichMethodOfEvolve);
        } else if (whichMethodOfEvolve == 14) {
            evolveWithLevel(pokemonNumber_);
        } else revert("Token cannot be updated");
    }

    /**
     * @dev This is a function for Pokémon evolution with erc-1155 standart `stone` token.
     * Each Pokémon is unique and various evolution options are stored in the "PokemonStorage" contract.
     * Using this method, the user pays with erc-1155 `stone` tokens, which are eventually burned.
     * See {PokemonStorage - isThunderEvolveAvailable(), isMoonEvolveAvailable()...}.
     *
     * Requirements:
     *
     * - Users can evolve Pokemons until the `_maxSupply` value is reached.
     * - Users required to buy specific `stone`. User can check which `stone` is required calling checkAvailableEvolve().
     * - Users required to approve one specific `stone` for this contract in order to pay for the evolution.
     *
     * @param pokemonNumber_ pokemon id to be evolved.
     * @param newPokemonId_ id of new pokemon to be minted.
     * @param whichStoneToUse_ required stone to evolve `pokemonNumber_`.
     *
     * Emits a {EvolvedWithStone} event.
     */
    function evolveWithStone(
        uint256 pokemonNumber_,
        uint256 newPokemonId_,
        uint256 whichStoneToUse_
    ) private {
        _stones.burn(msg.sender, whichStoneToUse_, 1);
        _mint(msg.sender, newPokemonId_, 1, "");
        _totalSupply++;
        emit EvolvedWithStone(pokemonNumber_, newPokemonId_, whichStoneToUse_, block.timestamp, msg.sender);
    }

    /**
     * @dev This is a function for Pokémon evolution with erc-20 standart `_maxSupply` token.
     * Each Pokémon is unique and various evolution options are stored in the "PokemonStorage" contract.
     * Using this method, the user pays with erc-20 `level` tokens, which are eventually burned.
     * See {PokemonStorage - isEvolveNotAvailable()}.
     *
     * Requirements:
     *
     * - Users can evolve Pokemons until the `_maxSupply` value is reached.
     * - Users required to buy `level` tokens of `_evolveLevelFee` amount.
     * - Users required to approve `level` tokens of `_evolveLevelFee` amount for this contract
     *
     * @param pokemonNumber_ pokemon id to be evolved.
     *
     * Emits a {EvolvedWithLevel} event.
     */
    function evolveWithLevel(uint256 pokemonNumber_) private {
        _level.burnFrom(msg.sender, _evolveLevelFee);
        uint256 newPokemonId = pokemonNumber_ + 1;
        _mint(msg.sender, newPokemonId, 1, "");
        _totalSupply++;
        emit EvolvedWithLevel(pokemonNumber_, newPokemonId, block.timestamp, msg.sender);
    }

    /**
     * @dev This is a function to check if evolution is available, and if so, which one.
     * Function return Id of stone or data saying that `level` evolution is available or data saying
     * that this Pokémon cannot be evolved.
     * @param pokemonNumber_ pokemon Id to get evolution data.
     */
    function checkAvailableEvolve(uint256 pokemonNumber_) public view returns (uint256, uint256) {
        if (true == isEvolveNotAvailable(pokemonNumber_)) {
            return (15, 0);
        } else if (isThunderEvolveAvailable(pokemonNumber_) != 0) {
            return (0, isThunderEvolveAvailable(pokemonNumber_));
        } else if (isMoonEvolveAvailable(pokemonNumber_) != 0) {
            return (1, isMoonEvolveAvailable(pokemonNumber_));
        } else if (isFireEvolveAvailable(pokemonNumber_) != 0) {
            return (2, isFireEvolveAvailable(pokemonNumber_));
        } else if (isLeafEvolveAvailable(pokemonNumber_) != 0) {
            return (3, isLeafEvolveAvailable(pokemonNumber_));
        } else if (isSunEvolveAvailable(pokemonNumber_) != 0) {
            return (4, isSunEvolveAvailable(pokemonNumber_));
        } else if (isWaterEvolveAvailable(pokemonNumber_) != 0) {
            return (5, isWaterEvolveAvailable(pokemonNumber_));
        } else if (isBlackAuguriteEvolveAvailable(pokemonNumber_) != 0) {
            return (6, isBlackAuguriteEvolveAvailable(pokemonNumber_));
        } else if (isShinyEvolveAvailable(pokemonNumber_) != 0) {
            return (7, isShinyEvolveAvailable(pokemonNumber_));
        } else if (isDuskEvolveAvailable(pokemonNumber_) != 0) {
            return (8, isDuskEvolveAvailable(pokemonNumber_));
        } else if (isRazorClawEvolveAvailable(pokemonNumber_) != 0) {
            return (9, isRazorClawEvolveAvailable(pokemonNumber_));
        } else if (isPeatBlockEvolveAvailable(pokemonNumber_) != 0) {
            return (10, isPeatBlockEvolveAvailable(pokemonNumber_));
        } else if (isTartAppleEvolveAvailable(pokemonNumber_) != 0) {
            return (11, isTartAppleEvolveAvailable(pokemonNumber_));
        } else if (isCrackedPotEvolveAvailable(pokemonNumber_) != 0) {
            return (12, isCrackedPotEvolveAvailable(pokemonNumber_));
        } else if (isOvalEvolveAvailable(pokemonNumber_) != 0) {
            return (13, isOvalEvolveAvailable(pokemonNumber_));
        } else return (14, 16);
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

    /**
     * @dev Set new `_maxSupply`. New max Supply required to be equal or higher
     * than _totalSupply. Can only be called by the owner of the contract.
     * @param maxSupply_ new max Supply of tokens.
     *
     * Emits a {MaxSupplyUpdated} event.
     */
    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        require(maxSupply_ > 0, "Max supply cannot be zero");
        require(maxSupply_ >= _totalSupply, "Max supply cannot be lower than total supply");
        _maxSupply = maxSupply_;
        emit MaxSupplyUpdated(_maxSupply);
    }

    /**
     * @dev Set new `_mintFee`. Function can only be called by the owner of the contract.
     * Users are required to pay this fee whenever they want call mintPokemon() function.
     * Function can only be called by the owner of the contract.
     * @param newMintFee_ new mint pokemon fee.
     *
     * Emits a {MintFeeUpdated} event.
     */
    function setMintFee(uint256 newMintFee_) external onlyOwner {
        require(newMintFee_ > 0, "Mint Fee cannot be zero");
        _mintFee = newMintFee_;
        emit MintFeeUpdated(_mintFee);
    }

    /**
     * @dev Set new `_evolveLevelFee`. Function can only be called by the owner of the contract.
     * Users are required to pay this fee whenever they want call evolvePokemon() function.
     * @param evolveLevelFee_ new evolve pokemon fee.
     *
     * Emits a {EvolveFeeUpdated} event.
     */
    function setEvolveLevelFee(uint256 evolveLevelFee_) external onlyOwner {
        require(evolveLevelFee_ > 0, "Evolve Fee cannot be zero");
        _evolveLevelFee = evolveLevelFee_;
        emit EvolveFeeUpdated(_evolveLevelFee);
    }

    /**
     * @dev Set new `_level` contract instance. Can only be called by the owner of the contract.
     * New `_level` contract instance required not to be address(0)
     * @param level_ new `Level` instance.
     *
     * Emits a {NewLevelContract} event.
     */
    function setNewLevelContract(address level_) external onlyOwner {
        require(level_ != address(0), "Level cannot be zero address");
        _level = IERC20Burnable(level_);
        emit NewLevelContract(_level);
    }

    /**
     * @dev Set new `_stones` contract instance. Can only be called by the owner of the contract.
     * New `_stones` contract instance required not to be address(0)
     * @param stones_ new `Stones` instance.
     *
     * Emits a {NewStonesContract} event.
     */
    function setNewStonesContract(address stones_) external onlyOwner {
        require(stones_ != address(0), "Stones cannot be zero address");
        _stones = IERC1155Burnable(stones_);
        emit NewStonesContract(_stones);
    }

    /**
     * @dev Returns max supply.
     */
    function getMaxSupply() public view returns (uint256) {
        return _maxSupply;
    }

    /**
     * @dev Returns the Pokemon mint fee.
     */
    function getMintFee() external view returns (uint256) {
        return _mintFee;
    }

    /**
     * @dev Returns the Evolve fee in `level` tokens.
     */
    function getEvolveLevelFee() external view returns (uint256) {
        return _evolveLevelFee;
    }

    /**
     * @dev Returns address of the Level contract.
     */
    function getLevelAddress() external view returns (IERC20Burnable) {
        return _level;
    }

    /**
     * @dev Returns address of the Stones contract.
     */
    function getStonesAddress() external view returns (IERC1155Burnable) {
        return _stones;
    }

    /**
     * @dev Returns the actual total supply so far.
     */
    function getTotalSupply() public view returns (uint256) {
        return _totalSupply;
    }
}
