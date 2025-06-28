// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./ISimpleSwap.sol";

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
