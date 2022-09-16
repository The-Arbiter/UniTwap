#!/usr/bin/env bash
set -e

[[ "$(cast chain --rpc-url="$ETH_RPC_URL")" == "goerli" ]] || { echo "Please set a Goerli ETH_RPC_URL"; exit 1; }

for ARGUMENT in "$@"
do
    KEY=$(echo "$ARGUMENT" | cut -f1 -d=)
    VALUE=$(echo "$ARGUMENT" | cut -f2 -d=)

    case "$KEY" in
            match)      MATCH="$VALUE" ;;
            block)      BLOCK="$VALUE" ;;
            *)
    esac
done


if [[ -z "$MATCH" && -z "$BLOCK" ]]; then
    echo "Using 0.6.12, change in script/test-forge.sh if not required"
    echo "Using max verbosity"
    forge test --fork-url "$ETH_RPC_URL" --use 0.6.12 -vv
elif [[ -z "$BLOCK" ]]; then
    forge test --fork-url "$ETH_RPC_URL" --match "$MATCH" -vvv
elif [[ -z "$MATCH" ]]; then
    forge test --fork-url "$ETH_RPC_URL" --fork-block-number "$BLOCK"
else
    forge test --fork-url "$ETH_RPC_URL" --match "$MATCH" --fork-block-number "$BLOCK" -vvv
fi
