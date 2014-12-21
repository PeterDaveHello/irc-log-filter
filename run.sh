#!/bin/bash
SOURCE="~/irclogs/" #irssi irc log directory
OUTPUT="filtered-irclogs" #filtered irc log output
SERVER="IRC-SERVER-NAME" #eg. freenode
CHANNEL="IRC-CHANNEL-NAME" #eg. debian

mkdir -p $(eval echo "$OUTPUT")

if [ "$1" = "all" ];then
    DATES="`ls $(eval echo $SOURCE) | grep ^irc-$SERVER-#$CHANNEL\ $SERVER | sed '$d' | rev | cut -c -8 | rev`"
    for DATE in $DATES
    do
        cat "$(eval echo "$SOURCE\irc-$SERVER-#$CHANNEL $SERVER")$DATE" | grep -E -v '(^[0-9]{2}:[0-9]{2} -!- |^--- |^[0-9]{2}:[0-9]{2} !)' >> $(eval echo $OUTPUT)/$DATE
    done
else
    if [ "`uname`" = "FreeBSD" ];then
        YESTERDAY=`date -v-1d "+%Y%m%d"`
    else
        YESTERDAY=`date +%Y%m%d --date="yesterday"`
    fi
    FILE="$(eval echo "$SOURCE")`ls $(eval echo "$SOURCE") | grep irc-$SERVER-#$CHANNEL\ $SERVER$YESTERDAY`"
    cat "$FILE" | grep -E -v '(^[0-9]{2}:[0-9]{2} -!- |^--- |^[0-9]{2}:[0-9]{2} !)' > $(eval echo "$OUTPUT")/$YESTERDAY
fi
