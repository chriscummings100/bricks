# Brick Generator

This repo contains cad files to generate various Lego parts. In reality, to get accurate bricks, extremely high precision moulding is used (sub 10 micron accuracy), which is above the grade of most affordable 3D printers. However, with some fiddling with numbers, it's likely possible to get a given printer/material to consistently generate very usable bricks.

All scripts in this repo are tuned to generate high quality, usable bricks for the Elegoo Mars 5 Ultra using their ABS-like resin. However each contains configuration options at the top of the file that can be tweaked to experiment with the right config for you! 

Currently, scripts are developed for OpenSCAD: https://openscad.org/

## Technic Beams

 `beams.scad` generates technic beams of any length. Configurable options:
 - `HOLES`: How many holes in the beam
 - `BEAM_DIAMETER`: Diameter of the beam (mm)
 - `BEAM_DEPTH`: Depth of the beam (mm)
 - `INNER_HOLE_DIAMETER`: Diameter of the hole through which a connector/axle fits (mm)
 - `OUTER_HOLE_DIAMETER`: Diameter of the small chamfer around the hole that allows the connector to clip in. (mm)
 - `HOLE_CHAMFER`: Depth of the chamfer (mm)
 - `SPACING`: Spacing between holes (mm)

 The 2 beam properties should be adjusted if the overall size of the printed beam doesn't match the lego version.

 The inner hole diameter should be adjusted if lego axles / connectors are too tight/loose when inserted into the beam.

 The outer hole diameter and chamfer should be adjusted if connectors slide in but can't go all the way, or fail to 'click' into place.

 Spacing shouldn't be adjusted unless aiming to create none-standard bricks.



