# Brick Generator

CAD files to generate various Lego parts. In reality, to get accurate bricks, extremely high precision moulding is used (sub 10 micron accuracy), which is above the grade of most affordable 3D printers. However, with some fiddling with numbers, it's likely possible to get a given printer/material to consistently generate very usable bricks.

All scripts in this repo are tuned to generate high quality, usable bricks for the Elegoo Mars 5 Ultra. However each contains configuration options at the top of the file that can be tweaked to experiment with the right config for you! 

Currently, scripts are developed for OpenSCAD: https://openscad.org/

On the Mars 5 Ultra, I use the following settings:
- ABS Like V3 resin
- Layer exposure: 3.4s
- Layer size: 0.05
- Bottom exposure: 90s
- Supports as in `chitusupports_elegoo_mars_5_ultra.crgx`

With testing, I have found the ABS like resin to be most suitable, with the water soluable resin very unpredictable. 



