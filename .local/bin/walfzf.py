#!/usr/bin/env python

# helps me select pywal colorschemes

import os
import subprocess
import argparse

CS_DIR = "/usr/lib/python3.10/site-packages/pywal/colorschemes/"


def list_themes(Dark=False):
    Dark = "dark" if Dark else "light"
    themes = os.scandir(os.path.join(CS_DIR, Dark))
    return [t for t in themes if os.path.isfile(t.path)]



parser = argparse.ArgumentParser(description="colorscheme picker")
parser.add_argument("-l","--light", action="store_true",help="display light colorschemes")
parser.add_argument("-f","--fzf", action="store_true", help="use fzf")

args = parser.parse_args()

darkOrLight="Dark"
if args.light:
    darkOrLight="Light"

cmd="rofi -dmenu -i -p '" + darkOrLight + " Themes' -theme launchers/text/style_4.rasi"

if args.fzf:
    cmd="fzf"

process = subprocess.Popen(cmd,shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE,text=True)
arg=""
if args.light:
    print("\033[1;32mLight Themes\033[0m:")
    light_themes = [t.name.replace(".json","") for t in list_themes()]
    for t in light_themes:
        process.stdin.write(t + '\n')
        arg=" -l "
else:
    print("\033[1;32mDark Themes\033[0m:")
    dark_themes = [t.name.replace(".json","")  for t in  list_themes(Dark=True)]
    for t in dark_themes:
        process.stdin.write(t + '\n')

isTheme = process.communicate()[0]
if isTheme:
    os.system("wal " + arg + " --theme " +  isTheme)
    os.system("xdotool key Super_L+F2")

