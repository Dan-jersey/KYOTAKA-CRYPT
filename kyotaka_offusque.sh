#!/bin/bash

clear
echo -e "\033[1;31m"
echo "╔════════════════════════════════════╗"
echo "║        𝙺𝚈𝙾𝚃𝙰𝙺𝙰 𝙲𝚁𝚈𝙿𝚃 𝙼𝙾𝙳𝙴        ║"
echo "╚════════════════════════════════════╝"
echo -e "\033[0m"

read -p $'\033[1;36mMode ? (offusque/desoffusque) > \033[0m' mode
[[ "$mode" != "offusque" && "$mode" != "desoffusque" ]] && echo -e "\033[1;31mInvalide.\033[0m" && exit 1

read -p $'\033[1;36mType (js/css/html) > \033[0m' type
[[ "$type" != "js" && "$type" != "css" && "$type" != "html" ]] && echo -e "\033[1;31mType invalide.\033[0m" && exit 1

echo -e "\033[1;33mColle ton code, termine avec une ligne contenant uniquement : EOF\033[0m"

code=""
while IFS= read -r line; do
  [[ "$line" == "EOF" ]] && break
  code+="$line"$'\n'
done

mkdir -p /sdcard/KYOTAKA
filename="kyotaka_${mode}.${type}"
filepath="/sdcard/KYOTAKA/$filename"

if [[ "$mode" == "offusque" ]]; then
  minified=$(echo "$code" | tr -d '\n\r\t' | sed 's/  */ /g' | sed 's/ *{ */{/g' | sed 's/ *} */}/g' | sed 's/ *; */;/g' | sed 's/ *, */,/g')
  echo "$minified" | base64 > "$filepath"
else
  base64 -d <<< "$code" | fold -w 80 > "$filepath"
fi

echo -e "\033[1;32mCode $mode avec succès !\033[0m"
echo -e "\033[1;32mFichier créé : $filepath\033[0m"