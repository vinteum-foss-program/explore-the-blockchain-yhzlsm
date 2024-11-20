# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

# Set extended public key
EXTENDED_PUBLIC_KEY=xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2

# Set index
INDEX=100

# Get descriptor infos
descriptor_info=$(bitcoin-cli getdescriptorinfo "tr($EXTENDED_PUBLIC_KEY/$INDEX)")

# Extract the descriptor with checksum
descriptor=$(echo "$descriptor_info" | jq -r '.descriptor')

# Derive the address from descriptor
taproot_address=$(bitcoin-cli deriveaddresses "$descriptor")

# Parse the address
taproot_address_parsed=$(echo "$taproot_address" | jq -r '.[0]')

# Show in the terminal
echo "$taproot_address_parsed"