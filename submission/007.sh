# Only one single output remains unspent from block 123,321. What address was it sent to?

# Set a variable with the block height
BLOCK_HEIGHT=123321

# Get block hash from spender
block_hash=$(bitcoin-cli getblockhash "$BLOCK_HEIGHT")

# Get block information with verbosity 3 (Access to prevout data)
block_info=$(bitcoin-cli getblock "$block_hash" 2)

# Extract and create an array with txid and the vout length
transactions=$(echo "$block_info" | jq -r '
  [.tx[] | {txid: .txid, vout_length: (.vout | length)}]
')

for transaction in $(echo "$transactions" | jq -c '.[]'); do

    txid=$(echo "$transaction" | jq -r '.txid')
    vout_length=$(echo "$transaction" | jq -r '.vout_length')
    
    for i in $(seq 0 $vout_length); do
        txout_info=$(bitcoin-cli gettxout "$txid" "$i")
        if [ -n "$txout_info" ]; then
            address=$(echo "$txout_info" | jq -r '.scriptPubKey.address')
            echo "$address"
            break
        fi
    done
done


