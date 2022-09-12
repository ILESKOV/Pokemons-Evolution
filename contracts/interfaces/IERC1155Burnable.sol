//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

/**
 * @dev Interface of the ERC1155Burnable extension.
 */
interface IERC1155Burnable is IERC1155 {
    /**
     * @dev Destroys `value` amount of `id` tokens from the `account`.
     *
     * See {ERC1155-_burn}.
     */
    function burn(
        address account,
        uint256 id,
        uint256 value
    ) external;

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {_burn}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     */
    function burnBatch(
        address account,
        uint256[] memory ids,
        uint256[] memory values
    ) external;
}
