# strip out iBooks citation
sed -E -e 's/^[ ]?[0-9]* //g' | sed -E -e 's/“[ ]?[0-9]?[ ]?//g' | sed -E -e 's/”$//g'  | sed -E -e 's/^(Excerpt From).*//g'
