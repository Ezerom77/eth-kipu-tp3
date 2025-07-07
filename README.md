# SimpleSwap - ERC20 Token Exchange Contract

## UPDATE 7/7/2025

- Segun la corrección recibida, se ajustalos Long Strings por Short Strings
- Se simplifico para trabajar con dos tokens y no como router

- Token A:
- Token B:
- contract address:

## Description

As part of the 3thTP of Eth-Kipu Course, SimpleSwap is a simplified implementation similar to Uniswap, but without depending on its protocol. This contract allows users to swap ERC20 tokens, add and remove liquidity from token pairs, and query prices and exchange amounts.

## Features

- ERC20 token swapping
- Adding and removing liquidity from token pairs
- Price calculation based on the x\*y=k formula
- No exchange fees
- Support for swaps through multiple token pairs
- Deadline verification to prevent late transactions
- Use of the OpenZeppelin library for ERC20 functionality
- ERC20 liquidity tokens to represent participation in pools

## Project Structure

- **SimpleSwap.sol**: Main implementation of the exchange contract
- **ISimpleSwap.sol**: Interface that defines the contract's functions and events
- **TokenGeneratos.sol**: Auxiliary contract for generating test ERC20 tokens

## Main Functionalities

### 1. Add Liquidity

```solidity
function addLiquidity(
    address tokenA,
    address tokenB,
    uint amountADesired,
    uint amountBDesired,
    uint amountAMin,
    uint amountBMin,
    address to,
    uint deadline
) external returns (uint amountA, uint amountB, uint liquidity);
```

Allows users to add liquidity to a token pair. The contract calculates the optimal amounts based on existing reserves and issues liquidity tokens as proof of participation.

### 2. Remove Liquidity

```solidity
function removeLiquidity(
    address tokenA,
    address tokenB,
    uint liquidity,
    uint amountAMin,
    uint amountBMin,
    address to,
    uint deadline
) external returns (uint amountA, uint amountB);
```

Allows users to withdraw their liquidity by burning liquidity tokens and receiving the corresponding tokens.

### 3. Swap Tokens

```solidity
function swapExactTokensForTokens(
    uint amountIn,
    uint amountOutMin,
    address[] calldata path,
    address to,
    uint deadline
) external returns (uint[] memory amounts);
```

Allows swapping an exact amount of input tokens for a minimum amount of output tokens.

### 4. Query Price

```solidity
function getPrice(
    address tokenA,
    address tokenB
) external view returns (uint price);
```

Returns the price of one token in terms of another.

### 5. Calculate Output Amount

```solidity
function getAmountOut(
    uint amountIn,
    uint reserveIn,
    uint reserveOut
) external pure returns (uint amountOut);
```

Calculates the amount of tokens that will be received in an exchange, based on the constant product formula x\*y=k.

### 6. Query Reserves

```solidity
function getReserves(
    address tokenA,
    address tokenB
) external view returns (uint reserveA, uint reserveB);
```

Returns the current reserves of a token pair.

## Implemented Improvements

1. **Deadline Modifier**: A `ensureDeadline` modifier has been implemented to verify that transactions are executed before the specified time limit.

```solidity
modifier ensureDeadline(uint deadline) {
    require(deadline >= block.timestamp, "Time Expired");
    _;
}
```

2. **NatSpec Documentation**: The code includes complete documentation following the NatSpec standard.

3. **Separate Interface**: The interface definition has been separated into an independent file (ISimpleSwap.sol).

## Exchange Formula

The contract uses the constant product formula (x\*y=k) without fees:

```
(reserveIn + amountIn) * (reserveOut - amountOut) = reserveIn * reserveOut
```

Solving for amountOut:

```
amountOut = (amountIn * reserveOut) / (reserveIn + amountIn)
```

## How to Use

1. **Deploy the contracts**:

   - Deploy the SimpleSwap contract
   - Deploy test ERC20 tokens using TokenGeneratos

2. **Approve the SimpleSwap contract**:

   - Users must approve the SimpleSwap contract to transfer their tokens

3. **Add liquidity**:

   - Call the `addLiquidity` function to create a new token pair or add to an existing one

4. **Perform swaps**:

   - Call the `swapExactTokensForTokens` function to swap tokens

5. **Remove liquidity**:
   - Call the `removeLiquidity` function to withdraw tokens and burn liquidity tokens

## Security

The contract implements several security measures:

- Deadline verification to prevent late transactions
- Token ordering to ensure consistency in pairs
- Minimum amount checks to protect against price slippage
- Use of the OpenZeppelin library for ERC20 functionality

## Dependencies

- OpenZeppelin Contracts (ERC20, IERC20)

## Author

Ezerom77
