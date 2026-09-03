#!/bin/bash
# keeps the screen recordings small enough to send on discord

gpu-screen-recorder -w screen -c mp4 -f 30 -r 15 -bm cbr -q 4000 -k av1 -ac opus -ab 48k -o ~/Videos/replays -a 'default_output'
