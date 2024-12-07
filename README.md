# Nonce Program Guide

The nonce_program assigns unique nonce numbers for each transfer, starting from 0u128. Each user address has their own nonce counter. Only one transfer will be successful for each unique nonce number, thus preventing accidental double spending. Any new transfer must use a new unique nonce number that is incremented automatically by the program.

## Usage Instructions

1. Query the current nonce for your address:
   ```bash
   curl https://api.explorer.provable.com/v1/mainnet/program/nonce_program.aleo/mapping/current_nonce/<ADDRESS>
   ```
   - If the address has never used the nonce_program before, `null` will be returned, indicating you should start with `0u128`
   - Otherwise, use the number returned from the query

2. Call the `transfer_public` transition with the following arguments:
   - `<ADDRESS>`: The recipient's Aleo address
   - `<VALUE_IN_U64>`: The amount to transfer
   - `<NONCE_IN_U128>`: The nonce value obtained from step 1

3. Example using Leo CLI: `leo execute --program nonce_program.aleo transfer_public <ADDRESS> <VALUE_IN_U64> <NONCE_IN_U128> --broadcast`
   - Any attempt of using same nonce number or number other than the program returned will fail
