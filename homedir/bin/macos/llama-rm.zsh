#!/usr/bin/env zsh
# qui 17 set 2026 00:14:45 -03

# converted to zsh/macOS using antigravity
# from BASH script found at:
#   https://gist.github.com/nerun/86f967b1d24315e49a21b11cbeb89847

choice="$1"
cache="$HOME/.cache/huggingface/hub"

if [[ -z "$choice" ]]; then
    echo "Usage: ${0:t} MODEL_NUMBER"
    llama-cli -cl
    exit 1
fi

cache_list=$(
    { llama-cli -cl 2>/dev/null || llama cli -cl 2>/dev/null; } |
    sed -E -e '1d' -e 's/^[[:space:]]+//'
)

entry=$(printf '%s\n' "$cache_list" | grep -E "^${choice}\. ")

if [[ -z "$entry" ]]; then
    cache_count=$(printf '%s\n' "$cache_list" | grep -c .)

    echo "There's no model #$choice in cache list. The cache only contains $cache_count models."
    exit 1
fi

# Remove "<number>. " from the beginning.
model_quant=$(printf '%s\n' "$entry" | sed -E 's/^[0-9]+\. //')

# Everything before the last ":" is the Hugging Face repository.
repo="${model_quant%:*}"

# Everything after the last ":" is the quantization.
quant="${model_quant##*:}"

# Hugging Face cache directory for this repository.
model_root="$cache/models--${repo//\//--}"

if [[ ! -d "$model_root" ]]; then
    echo "Model root directory not found:"
    echo "$model_root"
    exit 1
fi

# Locate the GGUF symlink corresponding to the selected quantization.
matches=( ${(f)"$(find "$model_root/snapshots" -type l -print | grep -iF -- "$quant")"} )

count=${#matches[@]}

if (( count != 1 )); then
    echo "I was expecting 1 matching file for $repo:$quant, but found $count."
    echo "Aborting to avoid deleting the wrong file."

    if (( count > 0 )); then
        print -l -- "${matches[@]}"
    fi

    exit 1
fi

# Zsh arrays are 1-indexed by default (unlike Bash which is 0-indexed).
model_to_del="${matches[1]}"

# Check whether another quantization of the same repository is cached.
other_quants=$(
    printf '%s\n' "$cache_list" |
    sed -E 's/^[0-9]+\. //' |
    grep -F -- "${repo}:" |
    grep -vFx -- "$model_quant"
)

if [[ -n "$other_quants" ]]; then
    # :A resolves symlinks natively in Zsh (replaces 'readlink -f', which fails on macOS BSD readlink)
    blob="${model_to_del:A}"

    rm -- "$blob"
    rm -- "$model_to_del"

    echo "$repo:$quant was successfully removed."
    echo "Other quantizations of the same model remain cached:"
    printf '%s\n' "$other_quants"
else
    rm -r -- "$model_root"

    echo "$repo:$quant was successfully removed."
    echo "No other quantizations remain, so the model's cache directory was also removed."
fi

# Note: on macOS default BSD ls, use -G instead of --color if GNU coreutils ls is not installed
ls -l --color "$cache" 2>/dev/null || ls -lG "$cache"
