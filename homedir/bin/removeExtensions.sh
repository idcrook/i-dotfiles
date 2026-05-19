#!/bin/bash -x

# Get the profile name from the first argument, default to "Default"
PROFILE="${1:-Default}"

# Get the list of extensions
extensions=$(code --profile "$PROFILE" --list-extensions)

if [ -z "$extensions" ]; then
  echo "No extensions found for profile '$PROFILE'."
  exit 0
fi

echo "The following extensions will be uninstalled from the '$PROFILE' profile:"
echo "$extensions"

read -p "Are you sure you want to uninstall all these extensions? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
  echo "Operation cancelled."
  exit 0
fi

# Uninstall each extension
while IFS= read -r ext; do
  echo "Uninstalling $ext..."
  code --profile "$PROFILE" --uninstall-extension "$ext"
done <<< "$extensions"

echo "All extensions have been uninstalled from the '$PROFILE' profile."
