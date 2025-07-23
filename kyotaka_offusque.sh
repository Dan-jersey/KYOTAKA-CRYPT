#!/bin/bash

clear
echo -e "\033[1;31m"
echo "╔════════════════════════════════════╗"
echo "║        𝙺𝚈𝙾𝚃𝙰𝙺𝙰 𝙾𝙵𝙵𝚄𝚂𝚀𝚄𝙴𝚁       ║"
echo "╚════════════════════════════════════╝"
echo -e "\033[0m"

read -p $'\033[1;36mQue veux-tu faire ? (offusque / desoffusque) > \033[0m' mode
if [[ "$mode" != "offusque" && "$mode" != "desoffusque" ]]; then
  echo -e "\033[1;31mChoix invalide. Stop.\033[0m"
  exit 1
fi

read -p $'\033[1;36mType de code (js / css / html) > \033[0m' type
if [[ "$type" != "js" && "$type" != "css" && "$type" != "html" ]]; then
  echo -e "\033[1;31mType invalide. Stop.\033[0m"
  exit 1
fi

echo -e "\033[1;33mColle ton code, termine avec une ligne contenant uniquement : EOF\033[0m"

code=""
while IFS= read -r line; do
  [[ "$line" == "EOF" ]] && break
  code+="$line"$'\n'
done

filename="kyotaka_code_${mode}.${type}"

if [[ "$mode" == "offusque" ]]; then
  minified=$(echo "$code" | tr -d '\n\r\t' | sed 's/  */ /g' | sed 's/ *{ */{/g' | sed 's/ *} */}/g' | sed 's/ *; */;/g' | sed 's/ *, */,/g')
  echo "$minified" | base64 > "$filename"
else
  base64 -d "$filename" | fold -w 80 > "${filename}.decoded"
fi

echo -e "\033[1;32mTon code a été $mode avec succès !\033[0m"

if [[ "$mode" == "offusque" ]]; then
  echo -e "\033[1;32mVérifie le fichier $filename dans ton téléphone.\033[0m"
else
  echo -e "\033[1;32mVérifie le fichier ${filename}.decoded dans ton téléphone.\033[0m"
fi