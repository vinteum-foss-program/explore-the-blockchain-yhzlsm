# Which tx in block 257,343 spends the coinbase output of block 256,128?

# Set a variable with the coinbase block 
BLOCK_HEIGHT_COINBASE=256128

# Set a variable with the spender block
BLOCK_HEIGHT_SPENDER=257343

# Get block hash from spender
block_hash_spender=$(bitcoin-cli getblockhash "$BLOCK_HEIGHT_SPENDER")

# Get block information with verbosity 3 (Access to prevout data)
block_info_spender=$(bitcoin-cli getblock "$block_hash_spender" 3)

# Get block hash from spender
block_hash_coinbase=$(bitcoin-cli getblockhash "$BLOCK_HEIGHT_COINBASE")

# Get block information with verbosity 2 (Access to transaction in JSON format)
block_info_coinbase=$(bitcoin-cli getblock "$block_hash_coinbase" 2)

# Filter coinbase transaction id (first transaction in the block) 
coinbase_transaction=$(echo "$block_info_coinbase" | jq -r '
  .tx[0].txid
')

# Compare the txid from spender that matches the coinbase txid
txid_filtered=$(echo "$block_info_spender" | jq -r --arg coinbase_txid "$coinbase_transaction" '
  .tx[] | select(.vin[]?.txid == $coinbase_txid) | .txid
')

# Show in the terminal
echo "$txid_filtered"
   