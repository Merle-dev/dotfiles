#!/bin/bash

while [ true ]; do
    pscircle --output="psc.png" --output-width=3690 --output-height=2160 --dot-color-min=582080FF --background-image="/home/merle/Pictures/wallpapers/bar.png" 
    swww img "psc.png" --transition-type none
    sleep 1
done
