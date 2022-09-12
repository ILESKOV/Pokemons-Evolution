# Solidity API

## Level

### _tokenPrice

```solidity
uint256 _tokenPrice
```

### LevelTokensBuyed

```solidity
event LevelTokensBuyed(address owner, uint256 amount)
```

_Emitted when buyLevelTokens() occure._

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | owner of the minted tokens. |
| amount | uint256 | amount of the minted tokens. |

### TokenPriceUpdated

```solidity
event TokenPriceUpdated(uint256 newTokenPrice, uint256 timeOfChanging)
```

_Emitted when setTokenPrice() occure._

| Name | Type | Description |
| ---- | ---- | ----------- |
| newTokenPrice | uint256 | new price for 1 token with 18 decimals. |
| timeOfChanging | uint256 | time when update occur. |

### WithdrawalOfOwner

```solidity
event WithdrawalOfOwner(address owner, uint256 amount)
```

_Emitted when the owner withdraw ether from the contract._

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | owner address. |
| amount | uint256 | amount of ether. |

### constructor

```solidity
constructor(uint256 initialSupply_, uint256 tokenPrice_) public
```

_Sets up `_tokenPrice` and mint `initialSupply_` to the owner._

| Name | Type | Description |
| ---- | ---- | ----------- |
| initialSupply_ | uint256 | amount of tokens to be minted to the owner of the contract. |
| tokenPrice_ | uint256 | price for 1 token with 18 decimals. |

### buyLevelTokens

```solidity
function buyLevelTokens() external payable
```

_This is a function for buying `level` type tokens.

Requirements:

- providing ether(`msg.value`) must be equal or higher than `_tokenPrice`.

Emits a {LevelTokensBuyed} event._

### setTokenPrice

```solidity
function setTokenPrice(uint256 newTokenPrice_) external
```

_Set new `_tokenPrice`._

| Name | Type | Description |
| ---- | ---- | ----------- |
| newTokenPrice_ | uint256 | new price for 1 token with 18 decimals. Emits a {TokenPriceUpdated} event. |

### getTokenPrice

```solidity
function getTokenPrice() external view returns (uint256)
```

_Returns the token price._

### withdrawETH

```solidity
function withdrawETH(uint256 amount) external
```

_Owner can withdraw Ether from contract.

Emits a {WithdrawalOfOwner} event._

## PokemonStorage

### _latestInEvolution

```solidity
mapping(uint256 => bool) _latestInEvolution
```

### _thunderEvolutions

```solidity
mapping(uint256 => uint256) _thunderEvolutions
```

### _moonEvolutions

```solidity
mapping(uint256 => uint256) _moonEvolutions
```

### _fireEvolutions

```solidity
mapping(uint256 => uint256) _fireEvolutions
```

### _leafEvolutions

```solidity
mapping(uint256 => uint256) _leafEvolutions
```

### _sunEvolutions

```solidity
mapping(uint256 => uint256) _sunEvolutions
```

### _waterEvolutions

```solidity
mapping(uint256 => uint256) _waterEvolutions
```

### _blackAuguriteEvolutions

```solidity
mapping(uint256 => uint256) _blackAuguriteEvolutions
```

### _shinyEvolutions

```solidity
mapping(uint256 => uint256) _shinyEvolutions
```

### _duskEvolutions

```solidity
mapping(uint256 => uint256) _duskEvolutions
```

### _razorClawEvolutions

```solidity
mapping(uint256 => uint256) _razorClawEvolutions
```

### _peatBlockEvolutions

```solidity
mapping(uint256 => uint256) _peatBlockEvolutions
```

### _tartAppleEvolutions

```solidity
mapping(uint256 => uint256) _tartAppleEvolutions
```

### _crackedPotEvolutions

```solidity
mapping(uint256 => uint256) _crackedPotEvolutions
```

### _ovalEvolutions

```solidity
mapping(uint256 => uint256) _ovalEvolutions
```

### isEvolveNotAvailable

```solidity
function isEvolveNotAvailable(uint256 pokemonNumber) public view returns (bool)
```

_Returns bool about availability of evolution._

### isThunderEvolveAvailable

```solidity
function isThunderEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a thunder stone._

### isMoonEvolveAvailable

```solidity
function isMoonEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a moon stone._

### isFireEvolveAvailable

```solidity
function isFireEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a fire stone._

### isLeafEvolveAvailable

```solidity
function isLeafEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a leaf stone._

### isSunEvolveAvailable

```solidity
function isSunEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a sun stone._

### isWaterEvolveAvailable

```solidity
function isWaterEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a water stone._

### isBlackAuguriteEvolveAvailable

```solidity
function isBlackAuguriteEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a black augurite._

### isShinyEvolveAvailable

```solidity
function isShinyEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a shiny stone._

### isDuskEvolveAvailable

```solidity
function isDuskEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a dusk stone._

### isRazorClawEvolveAvailable

```solidity
function isRazorClawEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a razor claw._

### isPeatBlockEvolveAvailable

```solidity
function isPeatBlockEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a peat block._

### isTartAppleEvolveAvailable

```solidity
function isTartAppleEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a tart apple._

### isCrackedPotEvolveAvailable

```solidity
function isCrackedPotEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a cracked pot._

### isOvalEvolveAvailable

```solidity
function isOvalEvolveAvailable(uint256 pokemonNumber) public view returns (uint256)
```

_Returns data about the possibility of evolution with a oval stone_

### uri

```solidity
function uri(uint256 tokenId) public pure returns (string)
```

_Returns uri of each token._

### constructor

```solidity
constructor() public
```

_Stores data on all `stone` type evolving opportunities and all latest Pokémons in
the chain of evolution._

## Pokemons

### _mintFee

```solidity
uint256 _mintFee
```

### _evolveLevelFee

```solidity
uint256 _evolveLevelFee
```

### _totalSupply

```solidity
uint256 _totalSupply
```

### _maxSupply

```solidity
uint256 _maxSupply
```

### _level

```solidity
contract IERC20Burnable _level
```

### _stones

```solidity
contract IERC1155Burnable _stones
```

### WithdrawalOfOwner

```solidity
event WithdrawalOfOwner(address owner, uint256 amount)
```

_Emitted when the owner withdraw ether from the contract._

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | owner address. |
| amount | uint256 | amount of ether. |

### MaxSupplyUpdated

```solidity
event MaxSupplyUpdated(uint256 newMaxSupply)
```

_Emitted when the owner of the contract call setMaxSupply()._

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMaxSupply | uint256 | new _maxSupply. |

### MintFeeUpdated

```solidity
event MintFeeUpdated(uint256 newFeePrice)
```

_Emitted when the owner of the contract call setMintFee()._

| Name | Type | Description |
| ---- | ---- | ----------- |
| newFeePrice | uint256 | new fee for minting pokemons. |

### EvolveFeeUpdated

```solidity
event EvolveFeeUpdated(uint256 evolveFeeUpdated)
```

_Emitted when the owner of the contract call setEvolveLevelFee()._

| Name | Type | Description |
| ---- | ---- | ----------- |
| evolveFeeUpdated | uint256 | new fee for evolving pokemons. |

### NewLevelContract

```solidity
event NewLevelContract(contract IERC20Burnable level)
```

_Emitted when the owner of the contract call setNewLevelContract()._

| Name | Type | Description |
| ---- | ---- | ----------- |
| level | contract IERC20Burnable | new `Level` instance. |

### NewStonesContract

```solidity
event NewStonesContract(contract IERC1155Burnable stones)
```

_Emitted when the owner of the contract call setNewStonesContract()._

| Name | Type | Description |
| ---- | ---- | ----------- |
| stones | contract IERC1155Burnable | new `Stones` instance. |

### NewPokemon

```solidity
event NewPokemon(uint256 tokenId, uint256 mintTime, address owner)
```

_Emitted when new token minted._

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | token Id. |
| mintTime | uint256 | block.timestamp of mint. |
| owner | address | address of the owner of the token. |

### EvolvedWithLevel

```solidity
event EvolvedWithLevel(uint256 tokenId, uint256 newTokenId, uint256 evolutionTime, address owner)
```

_Emitted when evolveWithLevel() occured._

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | token Id. |
| newTokenId | uint256 | token Id of new Token. |
| evolutionTime | uint256 | block.timestamp of evolution. |
| owner | address | address of the owner of the token. |

### EvolvedWithStone

```solidity
event EvolvedWithStone(uint256 tokenId, uint256 newTokenId, uint256 stoneId, uint256 evolutionTime, address owner)
```

_Emitted when evolveWithStone() occured._

| Name | Type | Description |
| ---- | ---- | ----------- |
| tokenId | uint256 | token Id. |
| newTokenId | uint256 | token Id of new Token. |
| stoneId | uint256 | Id of the stone erc-1155 token that was used to evolve the pokemon. |
| evolutionTime | uint256 | block.timestamp of evolution. |
| owner | address | address of the owner of the token. |

### constructor

```solidity
constructor(uint256 mintFee_, uint256 evolveLevelFee_, uint256 maxSupply_, address level_, address stones_) public
```

_Sets up the mint fee, the Evolve fee, and both IERC20Burnable IERC1155Burnable instances._

| Name | Type | Description |
| ---- | ---- | ----------- |
| mintFee_ | uint256 | initial mint price for mintPokemon(). |
| evolveLevelFee_ | uint256 | initial fee for Evolves in Level tokens. |
| maxSupply_ | uint256 | initial max Supply for tokens. |
| level_ | address | address of Level erc-20 standard contract. |
| stones_ | address | address of Stones erc-1155 standard contract. |

### mintPokemon

```solidity
function mintPokemon() external payable
```

_This is a function to mint Pokémon tokens dependig on pseudo randomness.
One of 905 different Pokémon is pseudo - randomly selected and minted to the user.
The mint costs ether and the price of the mint is set by the owner.

Requirements:

- `msg.value` must be higher or equal to `_mintFee`.
- Users can mint tokens until the `_maxSupply` value is reached.

Emits a {NewPokemon} event._

### evolvePokemon

```solidity
function evolvePokemon(uint256 pokemonNumber_) external
```

_This is a function for Pokémon evolution. Contract has data about every
real Level type and Stone type evolutions.

Requirements:

- Users can evolve Pokemons until the `_maxSupply` value is reached.
- The caller must be the owner of the token specified as a parameter.
- If such an evolution option exists, the user must buy level/stone tokens depending on the type of evolution.
- The user must buy and approve one `stone` type token for this contract if the evolutionWithStone() occured.
- The user must buy and approve `_evolveLevelFee` amount of `level` tokens for this contract if
the evolveWithLevel() occured._

| Name | Type | Description |
| ---- | ---- | ----------- |
| pokemonNumber_ | uint256 | pokemon id to be evolved. Emits a {EvolvedWithStone} or {EvolvedWithLevel} event. |

### evolveWithStone

```solidity
function evolveWithStone(uint256 pokemonNumber_, uint256 newPokemonId_, uint256 whichStoneToUse_) private
```

_This is a function for Pokémon evolution with erc-1155 standart `stone` token.
Each Pokémon is unique and various evolution options are stored in the "PokemonStorage" contract.
Using this method, the user pays with erc-1155 `stone` tokens, which are eventually burned.
See {PokemonStorage - isThunderEvolveAvailable(), isMoonEvolveAvailable()...}.

Requirements:

- Users can evolve Pokemons until the `_maxSupply` value is reached.
- Users required to buy specific `stone`. User can check which `stone` is required calling checkAvailableEvolve().
- Users required to approve one specific `stone` for this contract in order to pay for the evolution._

| Name | Type | Description |
| ---- | ---- | ----------- |
| pokemonNumber_ | uint256 | pokemon id to be evolved. |
| newPokemonId_ | uint256 | id of new pokemon to be minted. |
| whichStoneToUse_ | uint256 | required stone to evolve `pokemonNumber_`. Emits a {EvolvedWithStone} event. |

### evolveWithLevel

```solidity
function evolveWithLevel(uint256 pokemonNumber_) private
```

_This is a function for Pokémon evolution with erc-20 standart `_maxSupply` token.
Each Pokémon is unique and various evolution options are stored in the "PokemonStorage" contract.
Using this method, the user pays with erc-20 `level` tokens, which are eventually burned.
See {PokemonStorage - isEvolveNotAvailable()}.

Requirements:

- Users can evolve Pokemons until the `_maxSupply` value is reached.
- Users required to buy `level` tokens of `_evolveLevelFee` amount.
- Users required to approve `level` tokens of `_evolveLevelFee` amount for this contract_

| Name | Type | Description |
| ---- | ---- | ----------- |
| pokemonNumber_ | uint256 | pokemon id to be evolved. Emits a {EvolvedWithLevel} event. |

### checkAvailableEvolve

```solidity
function checkAvailableEvolve(uint256 pokemonNumber_) public view returns (uint256, uint256)
```

_This is a function to check if evolution is available, and if so, which one.
Function return Id of stone or data saying that `level` evolution is available or data saying
that this Pokémon cannot be evolved._

| Name | Type | Description |
| ---- | ---- | ----------- |
| pokemonNumber_ | uint256 | pokemon Id to get evolution data. |

### withdrawETH

```solidity
function withdrawETH(uint256 amount) external
```

_Owner can withdraw Ether from contract.

Emits a {WithdrawalOfOwner} event._

### setMaxSupply

```solidity
function setMaxSupply(uint256 maxSupply_) external
```

_Set new `_maxSupply`. New max Supply required to be equal or higher
than _totalSupply. Can only be called by the owner of the contract._

| Name | Type | Description |
| ---- | ---- | ----------- |
| maxSupply_ | uint256 | new max Supply of tokens. Emits a {MaxSupplyUpdated} event. |

### setMintFee

```solidity
function setMintFee(uint256 newMintFee_) external
```

_Set new `_mintFee`. Function can only be called by the owner of the contract.
Users are required to pay this fee whenever they want call mintPokemon() function.
Function can only be called by the owner of the contract._

| Name | Type | Description |
| ---- | ---- | ----------- |
| newMintFee_ | uint256 | new mint pokemon fee. Emits a {MintFeeUpdated} event. |

### setEvolveLevelFee

```solidity
function setEvolveLevelFee(uint256 evolveLevelFee_) external
```

_Set new `_evolveLevelFee`. Function can only be called by the owner of the contract.
Users are required to pay this fee whenever they want call evolvePokemon() function._

| Name | Type | Description |
| ---- | ---- | ----------- |
| evolveLevelFee_ | uint256 | new evolve pokemon fee. Emits a {EvolveFeeUpdated} event. |

### setNewLevelContract

```solidity
function setNewLevelContract(address level_) external
```

_Set new `_level` contract instance. Can only be called by the owner of the contract.
New `_level` contract instance required not to be address(0)_

| Name | Type | Description |
| ---- | ---- | ----------- |
| level_ | address | new `Level` instance. Emits a {NewLevelContract} event. |

### setNewStonesContract

```solidity
function setNewStonesContract(address stones_) external
```

_Set new `_stones` contract instance. Can only be called by the owner of the contract.
New `_stones` contract instance required not to be address(0)_

| Name | Type | Description |
| ---- | ---- | ----------- |
| stones_ | address | new `Stones` instance. Emits a {NewStonesContract} event. |

### getMaxSupply

```solidity
function getMaxSupply() public view returns (uint256)
```

_Returns max supply._

### getMintFee

```solidity
function getMintFee() external view returns (uint256)
```

_Returns the Pokemon mint fee._

### getEvolveLevelFee

```solidity
function getEvolveLevelFee() external view returns (uint256)
```

_Returns the Evolve fee in `level` tokens._

### getLevelAddress

```solidity
function getLevelAddress() external view returns (contract IERC20Burnable)
```

_Returns address of the Level contract._

### getStonesAddress

```solidity
function getStonesAddress() external view returns (contract IERC1155Burnable)
```

_Returns address of the Stones contract._

### getTotalSupply

```solidity
function getTotalSupply() public view returns (uint256)
```

_Returns the actual total supply so far._

## Stones

### THUNDER_STONE

```solidity
uint256 THUNDER_STONE
```

### MOON_STONE

```solidity
uint256 MOON_STONE
```

### FIRE_STONE

```solidity
uint256 FIRE_STONE
```

### LEAF_STONE

```solidity
uint256 LEAF_STONE
```

### SUN_STONE

```solidity
uint256 SUN_STONE
```

### WATER_STONE

```solidity
uint256 WATER_STONE
```

### BLACK_AUGURITE

```solidity
uint256 BLACK_AUGURITE
```

### SHINY_STONE

```solidity
uint256 SHINY_STONE
```

### DUSK_STONE

```solidity
uint256 DUSK_STONE
```

### RAZOR_CLAW

```solidity
uint256 RAZOR_CLAW
```

### PEAT_BLOCK

```solidity
uint256 PEAT_BLOCK
```

### TART_APPLE

```solidity
uint256 TART_APPLE
```

### CRACKED_POT

```solidity
uint256 CRACKED_POT
```

### OVAL_STONE

```solidity
uint256 OVAL_STONE
```

### _stonePrice

```solidity
uint256 _stonePrice
```

### StoneBuyed

```solidity
event StoneBuyed(address owner, uint256 stoneId, uint256 amount)
```

_Emitted when buyStone() occure._

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | owner of the minted tokens. |
| stoneId | uint256 | Id of minted tokens. |
| amount | uint256 | amount of minted tokens. |

### StonePriceUpdated

```solidity
event StonePriceUpdated(uint256 newStonePrice, uint256 timeOfChanging)
```

_Emitted when setStonePrice() occure._

| Name | Type | Description |
| ---- | ---- | ----------- |
| newStonePrice | uint256 | new price for `stone` type tokens. |
| timeOfChanging | uint256 | time when update occur. |

### WithdrawalOfOwner

```solidity
event WithdrawalOfOwner(address owner, uint256 amount)
```

_Emitted when the owner withdraw ether from the contract._

| Name | Type | Description |
| ---- | ---- | ----------- |
| owner | address | owner address. |
| amount | uint256 | amount of ether. |

### constructor

```solidity
constructor(uint256 stonePrice_) public
```

_Sets up the stone price and mint initial tokens to the owner._

| Name | Type | Description |
| ---- | ---- | ----------- |
| stonePrice_ | uint256 | initial mint price for stones tokens. |

### buyStone

```solidity
function buyStone(uint256 stoneId) external payable
```

_This is a function for buying `stone` type tokens.

Requirements:

- providing ether(`msg.value`) must be equal or higher than `_stonePrice`._

| Name | Type | Description |
| ---- | ---- | ----------- |
| stoneId | uint256 | Id of stone to be minted. Emits a {StoneBuyed} event. |

### setStonePrice

```solidity
function setStonePrice(uint256 newStonePrice_) external
```

_Set new `_stonePrice`._

| Name | Type | Description |
| ---- | ---- | ----------- |
| newStonePrice_ | uint256 | new price for `stone` type tokens. Emits a {StonePriceUpdated} event. |

### getStonePrice

```solidity
function getStonePrice() external view returns (uint256)
```

_Returns the stone price._

### withdrawETH

```solidity
function withdrawETH(uint256 amount) external
```

_Owner can withdraw Ether from contract.

Emits a {WithdrawalOfOwner} event._

## IERC1155Burnable

_Interface of the ERC1155Burnable extension._

### burn

```solidity
function burn(address account, uint256 id, uint256 value) external
```

_Destroys `value` amount of `id` tokens from the `account`.

See {ERC1155-_burn}._

### burnBatch

```solidity
function burnBatch(address account, uint256[] ids, uint256[] values) external
```

_xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_burn}.

Emits a {TransferBatch} event.

Requirements:

- `ids` and `amounts` must have the same length._

## IERC20Burnable

_Interface of the ERC20Burnable extension._

### burn

```solidity
function burn(uint256 amount) external
```

_Destroys `amount` tokens from the caller.

See {ERC20-_burn}._

### burnFrom

```solidity
function burnFrom(address account, uint256 amount) external
```

_Destroys `amount` tokens from `account`, deducting from the caller's
allowance.

See {ERC20-_burn} and {ERC20-allowance}.

Requirements:

- the caller must have allowance for ``accounts``'s tokens of at least
`amount`._

## MockedPokemons

_Contract implement mintPokemons()- version of  mintRandomPokemon()
from Pokemons contract but without pseudo-randomness._

### constructor

```solidity
constructor(uint256 mintFee_, uint256 upgradeLevelFee_, uint256 maxSupply_, address level_, address stones_) public
```

_Constructor the same as in Pokemons._

| Name | Type | Description |
| ---- | ---- | ----------- |
| mintFee_ | uint256 | initial mint price for mintPokemons(). |
| upgradeLevelFee_ | uint256 | initial fee for upgrades in Level tokens. |
| maxSupply_ | uint256 | initial max Supply for tokens. |
| level_ | address | address of Level erc-20 standard contract. |
| stones_ | address | address of Stones erc-1155 standard contract. |

### mintPokemons

```solidity
function mintPokemons(uint256 id_) external payable
```

_The user can simply specify the ID of the token to be minted without paying a fee._

| Name | Type | Description |
| ---- | ---- | ----------- |
| id_ | uint256 | Id of the pokemon to be minted. |

