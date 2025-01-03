# Brick Generator

CAD files to generate various Lego parts. In reality, to get accurate bricks, extremely high precision moulding is used (sub 10 micron accuracy), which is above the grade of most affordable 3D printers. However, with some fiddling with numbers, it's likely possible to get a given printer/material to consistently generate very usable bricks.

Currently, scripts are developed for OpenSCAD: https://openscad.org/

## Printer and Resin

All scripts in this repo are tuned to generate high quality, usable bricks for the Elegoo Mars 5 Ultra. However each contains configuration options at the top of the file that can be tweaked to experiment with the right config for you! 

On the Mars 5 Ultra, I use the following settings:
- ABS Like V3 resin
- Layer exposure: 3.4s
- Layer size: 0.05
- Bottom exposure: 90s
- Supports as in `chitusupports_elegoo_mars_5_ultra.crgx`

With testing, I have found the ABS like resin to be most suitable, with the water soluable resin very unpredictable. 

## Cleaning up the bricks

Most printers require at least some form of supports, even if it's just to help the pieces come safely off the build plate. It's absolutely critical with lego that supports are gently sanded off, as the left overs can easily contribute 50 microns worth of depth, resulting in useless bricks..

I also highly recommend a decent pair of digital calipers to help you compare your bricks to those of real lego and verify s.

## Finding the right settings

If you want to get perfect bricks for your printer, the best bet is to use the OpenSCAD files to generate lots of variants of each brick and print them all at once, then test and repeat.

One helpful trick is to use OpenSCAD to either add or cut text into your brick that describes its properties:

```
    translate([0, -14, 0])
    linear_extrude(5)
    text(inner_hole_size, halign="center", valign="top");
```

Using this approach, its easy to print 20 slight variations on the same brick and settle on the best combination. 

## Printing horizontal holes

Technic bricks can be tricky as they often have holes or studs at different orientations, which forces you into creating overhangs in some form. There are 2 general approaches to solve this:
- All my scripts have support in some form for expanding the size of horizontal holes independently. Sometimes this little tweak is all that's needed, but it can result in connectors failing to 'click' into place.
- After printing, twizzle a 4.8mm drill bit around inside the hole to even it out. Some of my scripts have an option to add scaffolding inside the hole, which is worth using if drilling, as it helps maintain a perfect cylinder.

On an SLA printer, cleaning out the hole can be done pre-cure when the plastic is malleable.

Generally, to get good horizontal holes expect a small amount of post processing - either with a drill bit, or even just twiddling around a lego axle until it moves fairly freely.

