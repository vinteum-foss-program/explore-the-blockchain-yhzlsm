# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

# Get 4 inputs of the transaction
# Create 1-of-4 mulsig address

# Set transaction ID
TRANSACTION=37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517

# Get the raw transaction with verbosity 1 (JSON format).
get_raw_transaction=$(bitcoin-cli getrawtransaction "$TRANSACTION" 1)

# Get inputs from transaction
get_transaction_inputs=$(echo "$get_raw_transaction" | jq -c '.vin[]')

# Set an empty array
address_array=()

# Interate over the inputs
for input in $get_transaction_inputs; do

    # Get the addresses from the txinwitness field
    tx_in_witness=$(echo "$input" | jq -r ".txinwitness[1]")

    # Add the address to the array
    address_array+=("$tx_in_witness")
done

# Format the address as JSON array
address_array_formated=$(printf '"%s",' "${address_array[@]}" | sed 's/,$//')

# Create multisig address
create_multisig=$(bitcoin-cli createmultisig 1 "["$address_array_formated"]")

# Extract multisig address
multisig_address=$(echo "$create_multisig" | jq -r ".address")

# Show in the terminal
echo "$multisig_address"
