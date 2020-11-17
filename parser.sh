#!/usr/bin/env bash

CONFIGURATION_FILE="$1"

# ------------------------------- TESTES --------------------------------------#
[ ! -e "$CONFIGURATION_FILE" ] && echo "ERROR. Configuration file does not exist." && exit 1
[ ! -r "$CONFIGURATION_FILE" ] && echo "ERROR. No access to configuration file."   && exit 1
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y # lynx not installed
# ---------------------------------------------------------------------------- #

while read -r line
do
  [ "$(echo $line | cut -c1)" = "#" ] && continue # if it's comment, continue
  [ ! "$line" ] && continue # if it's a blank ine, continue

  key="$(echo $line | cut -d = -f 1)"
  value="$(echo $line | cut -d = -f 2)"

  echo "CONF_$key=$value"
done < "$CONFIGURATION_FILE"
