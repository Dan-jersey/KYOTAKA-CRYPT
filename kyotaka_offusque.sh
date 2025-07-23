#!/bin/bash

clear
echo -e "\033[1;31m"
echo "╔════════════════════════════════════╗"
echo "║        𝙺𝚈𝙾𝚃𝙰𝙺𝙰 𝙲𝚁𝚈𝙿𝚃 𝙲𝙾𝙳𝙴       ║"
echo "╚════════════════════════════════════╝"
echo -e "\033[0m"

read -p $'\033[1;36m(offusque / desoffusque) > \033[0m' mode
[[ "$mode" != "offusque" && "$mode" != "desoffusque" ]] && { echo -e "\033[1;31mInvalide.\033[0m"; exit 1; }

read -p $'\033[1;36m(js / css / html) > \033[0m' type
[[ "$type" != "js" && "$type" != "css" && "$type" != "html" ]] && { echo -e "\033[1;31mInvalide.\033[0m"; exit 1; }

echo -e "\033[1;33mColle ton code puis appuie deux fois sur Entrée :\033[0m"

code=""
while IFS= read -r line; do
  [[ -z "$line" ]] && break
  code+="$line"$'\n'
done

filename="/sdcard/kyotaka_code_${mode}.${type}"

if [[ "$mode" == "offusque" ]]; then
  if [[ "$type" == "html" ]]; then
    echo "$code" | base64 > "$filename"
  else
    minified=$(echo "$code" | tr -d '\n\r\t' | sed 's/  */ /g' | sed 's/ *{ */{/g' | sed 's/ *} */}/g' | sed 's/ *; */;/g' | sed 's/ *, */,/g')
    echo "$minified" | base64 > "$filename"
  fi
else
  base64 -d "$filename" > "/sdcard/kyotaka_decoded.${type}"
fi

echo -e "\033[1;32mCode $mode avec succès.\033[0m"
echo -e "\033[1;32mFichier : /sdcard/kyotaka_code_${mode}.${type}\033[0m"