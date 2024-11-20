# What is the hash of block 654,321?
# Set a variable with the block height
BLOCK_HEIGHT=$654321
# Execute the command to get the block hash
BLOCK_HASH=$(bitcoin-cli getblockhash "$BLOCK_HEIGHT")
# Show the variable on the terminal
echo "$BLOCK_HASH"
