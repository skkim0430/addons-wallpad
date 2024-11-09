#!/bin/bash

CONFIG_FILE="/data/options.json"
CONFIG_RS485="/share/kocom/rs485.conf"

# Check if the configuration files exist
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: Configuration file '$CONFIG_FILE' not found."
  exit 1
fi

# Read the JSON configuration
json_config=$(cat "$CONFIG_FILE")

# Clear the output file
> "$CONFIG_RS485"

# Iterate over the JSON keys, excluding "Advanced" and any other unwanted keys
for key in $(echo "$json_config" | jq -r 'keys_unsorted[] | select(. != "Advanced")'); do
  # Write the section header
  echo "[$key]" >> "$CONFIG_RS485"

  # Extract and format key-value pairs
  echo "$json_config" | jq -r --arg key "$key" '.[$key] | to_entries[] | "\(.key)=\(.value|tostring)"' | sed 's/false/False/g; s/true/True/g' >> "$CONFIG_RS485"
done
