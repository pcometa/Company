# Company Smart Contract

## Overview
The Company Smart Contract is designed to manage and distribute the profits generated from various contract interactions within a business ecosystem. This contract allows for the secure transfer and withdrawal of company profits by authorized individuals.

## Contract Specification
- **Compiler Version**: Solidity 0.8.20
- **License**: MIT
- **Imports**: Uses OpenZeppelin's IERC20 for ERC20 token interactions.

## Key Features
- Profit Withdrawal: Enables owners and heads to withdraw their share of profits.
- Operator Management: Administer operator privileges for accessing specific functions.
- Liquidity Addition: Accumulates profits from associated business operations such as sales and land contracts.
- Head and Profit Percentages: Configure the allocation of profit percentages for owners and heads.

## Constructor
- Initializes the smart contract with the address for the token contract used in profit transactions.

## Primary Functions
1. Withdraw: Withdraw allocated profits from the contract.
2. addOperator: Assign operator roles.
3. removeOperator: Revoke operator rights.
4. addLiquidity: Credit profits to the company's contract.
5. setHeadAddress: Update the head address.
6. setPercents: Define profit-sharing percentages.

For support or further inquiries, the development team can be reached at [info@pcometaearth.com](mailto:info@pcometaearth.com).
