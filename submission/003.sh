# How many new outputs were created by block 123,456?
#Set a variable with the block height.
BLOCK_HEIGHT=123456

#Get block hash
BLOCK_HASH=$(bitcoin-cli getblockhash "$BLOCK_HEIGHT")

#Get block information
BLOCK_INFO=$(bitcoin-cli getblock "$BLOCK_HASH")

#Get a list of transactions
transactions=$(echo "$BLOCK_INFO" | jq -r '.tx[]')

#Set variable to sum outputs of all transactions
total_outputs=0

for transaction in $transactions; do

    #Get the raw transactions with verbosity 1 (JSON format).
    raw_transaction_data=$(bitcoin-cli getrawtransaction "$transaction" 1)
    
    #Get the length (vout) of each transaction
    transaction_output_length=$(echo "$raw_transaction_data" | jq -r ".vout | length")

    #Add the count of the outputs
    total_outputs=$((total_outputs + transaction_output_length))
done

#Show in terminal
echo "$total_outputs"