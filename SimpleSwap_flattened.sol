
// SPDX-License-Identifier: MIT

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC-20 standard as defined in the ERC.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts (last updated v5.1.0) (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.20;


/**
 * @dev Interface for the optional metadata functions from the ERC-20 standard.
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/interfaces/draft-IERC6093.sol


// OpenZeppelin Contracts (last updated v5.1.0) (interfaces/draft-IERC6093.sol)
pragma solidity ^0.8.20;

/**
 * @dev Standard ERC-20 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-20 tokens.
 */
interface IERC20Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC20InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC20InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `spender`’s `allowance`. Used in transfers.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     * @param allowance Amount of tokens a `spender` is allowed to operate with.
     * @param needed Minimum amount required to perform a transfer.
     */
    error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC20InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `spender` to be approved. Used in approvals.
     * @param spender Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC20InvalidSpender(address spender);
}

/**
 * @dev Standard ERC-721 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-721 tokens.
 */
interface IERC721Errors {
    /**
     * @dev Indicates that an address can't be an owner. For example, `address(0)` is a forbidden owner in ERC-20.
     * Used in balance queries.
     * @param owner Address of the current owner of a token.
     */
    error ERC721InvalidOwner(address owner);

    /**
     * @dev Indicates a `tokenId` whose `owner` is the zero address.
     * @param tokenId Identifier number of a token.
     */
    error ERC721NonexistentToken(uint256 tokenId);

    /**
     * @dev Indicates an error related to the ownership over a particular token. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param tokenId Identifier number of a token.
     * @param owner Address of the current owner of a token.
     */
    error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC721InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC721InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param tokenId Identifier number of a token.
     */
    error ERC721InsufficientApproval(address operator, uint256 tokenId);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC721InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC721InvalidOperator(address operator);
}

/**
 * @dev Standard ERC-1155 Errors
 * Interface of the https://eips.ethereum.org/EIPS/eip-6093[ERC-6093] custom errors for ERC-1155 tokens.
 */
interface IERC1155Errors {
    /**
     * @dev Indicates an error related to the current `balance` of a `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     * @param balance Current balance for the interacting account.
     * @param needed Minimum amount required to perform a transfer.
     * @param tokenId Identifier number of a token.
     */
    error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);

    /**
     * @dev Indicates a failure with the token `sender`. Used in transfers.
     * @param sender Address whose tokens are being transferred.
     */
    error ERC1155InvalidSender(address sender);

    /**
     * @dev Indicates a failure with the token `receiver`. Used in transfers.
     * @param receiver Address to which tokens are being transferred.
     */
    error ERC1155InvalidReceiver(address receiver);

    /**
     * @dev Indicates a failure with the `operator`’s approval. Used in transfers.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     * @param owner Address of the current owner of a token.
     */
    error ERC1155MissingApprovalForAll(address operator, address owner);

    /**
     * @dev Indicates a failure with the `approver` of a token to be approved. Used in approvals.
     * @param approver Address initiating an approval operation.
     */
    error ERC1155InvalidApprover(address approver);

    /**
     * @dev Indicates a failure with the `operator` to be approved. Used in approvals.
     * @param operator Address that may be allowed to operate on tokens without being their owner.
     */
    error ERC1155InvalidOperator(address operator);

    /**
     * @dev Indicates an array length mismatch between ids and values in a safeBatchTransferFrom operation.
     * Used in batch transfers.
     * @param idsLength Length of the array of token identifiers
     * @param valuesLength Length of the array of token amounts
     */
    error ERC1155InvalidArrayLength(uint256 idsLength, uint256 valuesLength);
}

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v5.3.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.20;





/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC-20
 * applications.
 */
abstract contract ERC20 is Context, IERC20, IERC20Metadata, IERC20Errors {
    mapping(address account => uint256) private _balances;

    mapping(address account => mapping(address spender => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * Both values are immutable: they can only be set once during construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `value`.
     */
    function transfer(address to, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, value);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `value` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 value) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, value);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Skips emitting an {Approval} event indicating an allowance update. This is not
     * required by the ERC. See {xref-ERC20-_approve-address-address-uint256-bool-}[_approve].
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `value`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `value`.
     */
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _transfer(address from, address to, uint256 value) internal {
        if (from == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(from, to, value);
    }

    /**
     * @dev Transfers a `value` amount of tokens from `from` to `to`, or alternatively mints (or burns) if `from`
     * (or `to`) is the zero address. All customizations to transfers, mints, and burns should be done by overriding
     * this function.
     *
     * Emits a {Transfer} event.
     */
    function _update(address from, address to, uint256 value) internal virtual {
        if (from == address(0)) {
            // Overflow check required: The rest of the code assumes that totalSupply never overflows
            _totalSupply += value;
        } else {
            uint256 fromBalance = _balances[from];
            if (fromBalance < value) {
                revert ERC20InsufficientBalance(from, fromBalance, value);
            }
            unchecked {
                // Overflow not possible: value <= fromBalance <= totalSupply.
                _balances[from] = fromBalance - value;
            }
        }

        if (to == address(0)) {
            unchecked {
                // Overflow not possible: value <= totalSupply or value <= fromBalance <= totalSupply.
                _totalSupply -= value;
            }
        } else {
            unchecked {
                // Overflow not possible: balance + value is at most totalSupply, which we know fits into a uint256.
                _balances[to] += value;
            }
        }

        emit Transfer(from, to, value);
    }

    /**
     * @dev Creates a `value` amount of tokens and assigns them to `account`, by transferring it from address(0).
     * Relies on the `_update` mechanism
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead.
     */
    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidReceiver(address(0));
        }
        _update(address(0), account, value);
    }

    /**
     * @dev Destroys a `value` amount of tokens from `account`, lowering the total supply.
     * Relies on the `_update` mechanism.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * NOTE: This function is not virtual, {_update} should be overridden instead
     */
    function _burn(address account, uint256 value) internal {
        if (account == address(0)) {
            revert ERC20InvalidSender(address(0));
        }
        _update(account, address(0), value);
    }

    /**
     * @dev Sets `value` as the allowance of `spender` over the `owner`'s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     *
     * Overrides to this logic should be done to the variant with an additional `bool emitEvent` argument.
     */
    function _approve(address owner, address spender, uint256 value) internal {
        _approve(owner, spender, value, true);
    }

    /**
     * @dev Variant of {_approve} with an optional flag to enable or disable the {Approval} event.
     *
     * By default (when calling {_approve}) the flag is set to true. On the other hand, approval changes made by
     * `_spendAllowance` during the `transferFrom` operation set the flag to false. This saves gas by not emitting any
     * `Approval` event during `transferFrom` operations.
     *
     * Anyone who wishes to continue emitting `Approval` events on the`transferFrom` operation can force the flag to
     * true using the following override:
     *
     * ```solidity
     * function _approve(address owner, address spender, uint256 value, bool) internal virtual override {
     *     super._approve(owner, spender, value, true);
     * }
     * ```
     *
     * Requirements are the same as {_approve}.
     */
    function _approve(address owner, address spender, uint256 value, bool emitEvent) internal virtual {
        if (owner == address(0)) {
            revert ERC20InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert ERC20InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        if (emitEvent) {
            emit Approval(owner, spender, value);
        }
    }

    /**
     * @dev Updates `owner`'s allowance for `spender` based on spent `value`.
     *
     * Does not update the allowance value in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Does not emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 value) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance < type(uint256).max) {
            if (currentAllowance < value) {
                revert ERC20InsufficientAllowance(spender, currentAllowance, value);
            }
            unchecked {
                _approve(owner, spender, currentAllowance - value, false);
            }
        }
    }
}

// File: ISimpleSwap.sol


pragma solidity ^0.8.0;

/// @title ISimpleSwap
/// @notice Interface for the token exchange contract
/// @dev Defines the main functions to interact with the SimpleSwap contract
interface ISimpleSwap {
    /// @notice Event emitted when liquidity is added to a token pair
    /// @param tokenA Address of the first token
    /// @param tokenB Address of the second token
    /// @param amountA Amount of the first token added
    /// @param amountB Amount of the second token added
    /// @param liquidity Amount of liquidity tokens issued
    event LiquidityAdded(
        address indexed tokenA,
        address indexed tokenB,
        uint256 amountA,
        uint256 amountB,
        uint256 liquidity
    );

    /// @notice Event emitted when liquidity is removed from a token pair
    /// @param tokenA Address of the first token
    /// @param tokenB Address of the second token
    /// @param amountA Amount of the first token withdrawn
    /// @param amountB Amount of the second token withdrawn
    /// @param liquidity Amount of liquidity tokens burned
    event LiquidityRemoved(
        address indexed tokenA,
        address indexed tokenB,
        uint256 amountA,
        uint256 amountB,
        uint256 liquidity
    );

    /// @notice Event emitted when a token swap is performed
    /// @param tokenIn Address of the input token
    /// @param tokenOut Address of the output token
    /// @param amountIn Amount of the input token
    /// @param amountOut Amount of the output token
    event Swap(
        address indexed tokenIn,
        address indexed tokenOut,
        uint256 amountIn,
        uint256 amountOut
    );

    /// @notice Adds liquidity to a token pair
    /// @dev Transfers tokens from the user to the contract and issues liquidity tokens
    /// @param tokenA Address of the first token
    /// @param tokenB Address of the second token
    /// @param amountADesired Desired amount of the first token
    /// @param amountBDesired Desired amount of the second token
    /// @param amountAMin Minimum acceptable amount of the first token
    /// @param amountBMin Minimum acceptable amount of the second token
    /// @param to Address of the recipient of the liquidity tokens
    /// @param deadline Timestamp limit for the transaction
    /// @return amountA Effective amount of the first token added
    /// @return amountB Effective amount of the second token added
    /// @return liquidity Amount of liquidity tokens issued
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB, uint256 liquidity);

    /// @notice Removes liquidity from a token pair
    /// @dev Burns liquidity tokens and returns the corresponding tokens
    /// @param tokenA Address of the first token
    /// @param tokenB Address of the second token
    /// @param liquidity Amount of liquidity tokens to burn
    /// @param amountAMin Minimum acceptable amount of the first token
    /// @param amountBMin Minimum acceptable amount of the second token
    /// @param to Address of the recipient of the tokens
    /// @param deadline Timestamp limit for the transaction
    /// @return amountA Amount of the first token returned
    /// @return amountB Amount of the second token returned
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    /// @notice Swaps an exact amount of input tokens for output tokens
    /// @dev Supports swaps through multiple token pairs
    /// @param amountIn Exact amount of input tokens
    /// @param amountOutMin Minimum amount of output tokens to receive
    /// @param path Path of tokens for the swap (input token, output token)
    /// @param to Address of the recipient of the output tokens
    /// @param deadline Timestamp limit for the transaction
    /// @return amounts Array with the input and output amounts
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    /// @notice Gets the price of a token in terms of another
    /// @dev The price is expressed with 18 decimals
    /// @param tokenA Address of the first token
    /// @param tokenB Address of the second token
    /// @return price Price of tokenA in terms of tokenB
    function getPrice(
        address tokenA,
        address tokenB
    ) external view returns (uint256 price);

    /// @notice Calculates the amount of tokens to receive in a swap
    /// @dev Uses the formula x*y=k without fees
    /// @param amountIn Amount of input tokens
    /// @param reserveIn Reserve of the input token
    /// @param reserveOut Reserve of the output token
    /// @return amountOut Amount of tokens to receive
    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    /// @notice Gets the current reserves of a token pair
    /// @param tokenA Address of the first token
    /// @param tokenB Address of the second token
    /// @return reserveA Reserve of the first token
    /// @return reserveB Reserve of the second token
    function getReserves(
        address tokenA,
        address tokenB
    ) external view returns (uint256 reserveA, uint256 reserveB);
}

// File: SimpleSwap.sol


pragma solidity ^0.8.0;




/// @title SimpleSwap TP3
/// @author Ezerom77
/// @notice Contract for exchanging ERC20 tokens similar to Uniswap
/// @dev Implements functionalities to add/remove liquidity and swap tokens
contract SimpleSwap is ERC20, ISimpleSwap {
    /// @notice Mapping to store the reserves of each token
    mapping(address => uint256) public reserves;

    /// @notice Mapping to verify if a token pair exists
    mapping(address => mapping(address => bool)) public pairExists;

    /// @notice Modifier to verify that the transaction is executed before the deadline
    /// @param deadline Timestamp limit for the transaction
    modifier ensureDeadline(uint256 deadline) {
        require(deadline >= block.timestamp, "Time Expired");
        _;
    }

    /// @notice Contract constructor
    /// @dev Initializes the ERC20 token for liquidity tokens
    constructor() ERC20("Liquidity", "SWL") {}

    /// @inheritdoc ISimpleSwap
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        override
        ensureDeadline(deadline)
        returns (uint256 amountA, uint256 amountB, uint256 liquidity)
    {
        require(tokenA != tokenB, "Error: SAME TOKEN");

        // Ordenar tokens para asegurar consistencia
        if (tokenA > tokenB) {
            (tokenA, tokenB) = (tokenB, tokenA);
            (amountADesired, amountBDesired) = (amountBDesired, amountADesired);
            (amountAMin, amountBMin) = (amountBMin, amountAMin);
        }

        // Calcular cantidades óptimas
        if (!pairExists[tokenA][tokenB]) {
            // Primer depósito para este par
            pairExists[tokenA][tokenB] = true;
            amountA = amountADesired;
            amountB = amountBDesired;
        } else {
            // Par existente, calcular proporciones
            uint256 reserveA = reserves[tokenA];
            uint256 reserveB = reserves[tokenB];

            if (reserveA == 0 || reserveB == 0) {
                amountA = amountADesired;
                amountB = amountBDesired;
            } else {
                uint256 amountBOptimal = quote(
                    amountADesired,
                    reserveA,
                    reserveB
                );
                if (amountBOptimal <= amountBDesired) {
                    require(
                        amountBOptimal >= amountBMin,
                        "Error: INSUFFICIENT_B_AMOUNT"
                    );
                    amountA = amountADesired;
                    amountB = amountBOptimal;
                } else {
                    uint256 amountAOptimal = quote(
                        amountBDesired,
                        reserveB,
                        reserveA
                    );
                    require(
                        amountAOptimal <= amountADesired,
                        "Error: EXCESSIVE_INPUT_AMOUNT"
                    );
                    require(
                        amountAOptimal >= amountAMin,
                        "Error: INSUFFICIENT_A_AMOUNT"
                    );
                    amountA = amountAOptimal;
                    amountB = amountBDesired;
                }
            }
        }

        // Transferir tokens al contrato
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);

        // Actualizar reservas
        reserves[tokenA] = reserves[tokenA] + amountA;
        reserves[tokenB] = reserves[tokenB] + amountB;

        // Calcular liquidez a emitir
        uint256 totalSupply = totalSupply();
        if (totalSupply == 0) {
            // Primera vez que se agrega liquidez
            liquidity = sqrt(amountA * amountB);
        } else {
            // Calcular liquidez proporcional
            liquidity = min(
                (amountA * totalSupply) / reserves[tokenA],
                (amountB * totalSupply) / reserves[tokenB]
            );
        }

        require(liquidity > 0, "Error: INSUFFICIENT_LIQUIDITY_MINTED");

        // Emitir tokens de liquidez
        _mint(to, liquidity);

        emit LiquidityAdded(tokenA, tokenB, amountA, amountB, liquidity);

        return (amountA, amountB, liquidity);
    }

    /// @inheritdoc ISimpleSwap
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        override
        ensureDeadline(deadline)
        returns (uint256 amountA, uint256 amountB)
    {
        require(deadline >= block.timestamp, "Time Expired");
        require(tokenA != tokenB, "Error: IDENTICAL_ADDRESSES");

        // Ordenar tokens para consistencia
        if (tokenA > tokenB) {
            (tokenA, tokenB) = (tokenB, tokenA);
            (amountAMin, amountBMin) = (amountBMin, amountAMin);
        }

        require(pairExists[tokenA][tokenB], "Error: PAIR_DOES_NOT_EXIST");

        // Calcular cantidades a devolver
        uint256 totalSupply = totalSupply();
        amountA = (liquidity * reserves[tokenA]) / totalSupply;
        amountB = (liquidity * reserves[tokenB]) / totalSupply;

        require(amountA >= amountAMin, "Error: INSUFFICIENT_A_AMOUNT");
        require(amountB >= amountBMin, "Error: INSUFFICIENT_B_AMOUNT");

        // Quemar tokens de liquidez
        _burn(msg.sender, liquidity);

        // Actualizar reservas
        reserves[tokenA] = reserves[tokenA] - amountA;
        reserves[tokenB] = reserves[tokenB] - amountB;

        // Transferir tokens al usuario
        IERC20(tokenA).transfer(to, amountA);
        IERC20(tokenB).transfer(to, amountB);

        emit LiquidityRemoved(tokenA, tokenB, amountA, amountB, liquidity);

        return (amountA, amountB);
    }

    /// @inheritdoc ISimpleSwap
    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    )
        external
        override
        ensureDeadline(deadline)
        returns (uint256[] memory amounts)
    {
        require(path.length >= 2, "Error: INVALID_PATH");

        amounts = new uint256[](path.length);
        amounts[0] = amountIn;

        // Transferir token de entrada al contrato
        IERC20(path[0]).transferFrom(msg.sender, address(this), amountIn);

        // Realizar el swap para cada par en el path
        for (uint256 i = 0; i < path.length - 1; i++) {
            address tokenIn = path[i];
            address tokenOut = path[i + 1];

            // Ordenar tokens para consistencia
            address token0 = tokenIn;
            address token1 = tokenOut;

            if (token0 > token1) {
                (token0, token1) = (token1, token0);
            }

            require(pairExists[token0][token1], "Error: PAIR_DOES_NOT_EXIST");

            uint256 reserveIn = reserves[tokenIn];
            uint256 reserveOut = reserves[tokenOut];

            // Calcular cantidad de salida
            uint256 amountOut = getAmountOut(amounts[i], reserveIn, reserveOut);
            amounts[i + 1] = amountOut;

            // Actualizar reservas
            reserves[tokenIn] = reserves[tokenIn] + amounts[i];
            reserves[tokenOut] = reserves[tokenOut] - amountOut;

            // Transferir token de salida al destinatario si es el último swap
            if (i == path.length - 2) {
                IERC20(tokenOut).transfer(to, amountOut);
            }

            emit Swap(tokenIn, tokenOut, amounts[i], amountOut);
        }

        require(
            amounts[path.length - 1] >= amountOutMin,
            "Error: INSUFFICIENT_OUTPUT_AMOUNT"
        );

        return amounts;
    }

    /// @inheritdoc ISimpleSwap
    function getPrice(
        address tokenA,
        address tokenB
    ) external view override returns (uint256 price) {
        // Ordenar tokens para consistencia
        if (tokenA > tokenB) {
            (tokenA, tokenB) = (tokenB, tokenA);
            // Invertir el precio al final
            uint256 reserveA = reserves[tokenA];
            uint256 reserveB = reserves[tokenB];
            require(
                reserveA > 0 && reserveB > 0,
                "Error: INSUFFICIENT_LIQUIDITY"
            );
            return (reserveB * 1e18) / reserveA; // Precio con 18 decimales
        } else {
            uint256 reserveA = reserves[tokenA];
            uint256 reserveB = reserves[tokenB];
            require(
                reserveA > 0 && reserveB > 0,
                "Error: INSUFFICIENT_LIQUIDITY"
            );
            return (reserveB * 1e18) / reserveA; // Precio con 18 decimales
        }
    }

    /// @inheritdoc ISimpleSwap
    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) public pure override returns (uint256 amountOut) {
        require(amountIn > 0, "Error: INSUFFICIENT_INPUT_AMOUNT");
        require(
            reserveIn > 0 && reserveOut > 0,
            "Error: INSUFFICIENT_LIQUIDITY"
        );

        // Fórmula de Uniswap sin fees: x * y = k
        // (reserveIn + amountIn) * (reserveOut - amountOut) = reserveIn * reserveOut
        // Despejando amountOut:
        // amountOut = reserveOut - (reserveIn * reserveOut) / (reserveIn + amountIn)

        uint256 numerator = amountIn * reserveOut;
        uint256 denominator = reserveIn + amountIn;
        amountOut = numerator / denominator;

        return amountOut;
    }

    /// @inheritdoc ISimpleSwap
    function getReserves(
        address tokenA,
        address tokenB
    ) external view returns (uint256 reserveA, uint256 reserveB) {
        // Ordenar tokens para consistencia
        if (tokenA > tokenB) {
            (tokenA, tokenB) = (tokenB, tokenA);
        }

        require(pairExists[tokenA][tokenB], "Error: PAIR_DOES_NOT_EXIST");

        reserveA = reserves[tokenA];
        reserveB = reserves[tokenB];

        return (reserveA, reserveB);
    }

    /// @notice Calculates the proportion between tokens based on reserves
    /// @dev Helper function to calculate optimal amounts
    /// @param amountA Amount of token A
    /// @param reserveA Reserve of token A
    /// @param reserveB Reserve of token B
    /// @return amountB Equivalent amount of token B
    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) internal pure returns (uint256 amountB) {
        require(amountA > 0, "Error: INSUFFICIENT_AMOUNT");
        require(reserveA > 0 && reserveB > 0, "Error: INSUFFICIENT_LIQUIDITY");
        amountB = (amountA * reserveB) / reserveA;
        return amountB;
    }

    /// @notice Returns the minimum value between two numbers
    /// @param x First number
    /// @param y Second number
    /// @return z The minimum value between x and y
    function min(uint256 x, uint256 y) internal pure returns (uint256 z) {
        z = x < y ? x : y;
    }

    /// @notice Calculates the square root of a number
    /// @dev Method to calculate square root
    /// @param y Number for which the square root will be calculated
    /// @return z The square root of y
    function sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }
}
