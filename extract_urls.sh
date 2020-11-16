#!/usr/bin/env bash
#
# extract_urls.sh - Extracts URLs from a website.
#
# Autor:      Edvaldo Lima
# Manutenção: Edvaldo Lima
#
# ------------------------------------------------------------------------ #
#  Extracts URLs from a website https://www.ted.com/talks
#
#  Exemplos:
#      $ ./extract_urls.sh
#      On this example the program webscrape the website and return only the
#      URLs of the talks.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 11/13/2020, Edvaldo:
#         - Built a regex to webscrape the page and extract only urls of talks.
#   v1.0 11/13/2020, Edvaldo:
#         - Colored the urls extacted.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17
# ------------------------------------------------------------------------ #
#
# ------------------------------- VARIÁVEIS -------------------------------#
TED_URLS="ted_urls.txt"
VERDE="\033[32;1;1m"
# ------------------------------------------------------------------------ #
#
# ------------------------------- TESTES ----------------------------------#
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y # lynx not installed
# ------------------------------------------------------------------------ #
# ------------------------------- EXECUÇÃO ------------------------------------#
for i in {1..10} # loop through first 10 pages and save results to a file.
do
  lynx -source "https://www.ted.com/talks?language=en&page=$i&sort=popular" |
  grep "href='/talks/" |
  sed "s/^.*href='/https\:\/\/www\.ted\.com/;s/?.*$/\/transcript/" |
  uniq
done > ted_urls.txt

while read -r ted_urls # Read the text file and displays  the urls in green on the screen
do
  echo -e "$VERDE${ted_urls}"
done < "$TED_URLS"
