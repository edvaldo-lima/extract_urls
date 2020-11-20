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
#   v1.1 11/17/2020, Edvaldo:
#         - Using configuration file (conf.cf) to pass parameters dinamically.
#         - Using parser.sh to parse the conf.cf file used by ./extract_urls.sh.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17
# ------------------------------------------------------------------------ #
#
# ------------------------------- VARIÁVEIS -------------------------------#
CONFIGURATION_FILE="conf.cf"
USE_UPPERCASE=
USE_COLORS=
TED_URLS="ted_urls.txt"
VERDE="\033[32;1;1m"

eval $(./parser.sh $CONFIGURATION_FILE)


[ "$(echo $CONF_USE_UPPERCASE)" = "1" ] && USE_UPPERCASE="1"
[ "$(echo $CONF_USE_COLORS)" = "1" ] && USE_COLORS="1"


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
  [ "$USE_UPPERCASE" = "1" ]   && MESSAGE="$(echo ${ted_urls} | tr a-z A-Z)"
  [ ! "$USE_UPPERCASE" = "1" ] && MESSAGE="$(echo ${ted_urls})"
  [ "$USE_COLORS" = "1" ]      && MESSAGE="$(echo -e ${VERDE}$MESSAGE)"
  echo -e "$MESSAGE"
done < "$TED_URLS"
