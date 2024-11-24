# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`

TRANSACTION="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

get_raw_trasaction=$(bitcoin-cli getrawtransaction "$TRANSACTION" 1)

witness_field_script=$(echo "$get_raw_trasaction" | jq -r '
  .vin[] | .txinwitness[2]
')

decoded_script=$(bitcoin-cli decodescript "$witness_field_script")

public_key=$(echo "$decoded_script" | jq -r '.asm | split(" ")[1]' )

echo "$public_key" 