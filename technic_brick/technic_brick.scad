$fn=100;

include <../common/hole.scad>;

//-------------------------------------------------------------
// Constants for default setup 
//-------------------------------------------------------------

// How many holes in the brick.
HOLES = 3;

// Dimensions of the brick body. Adjust these if
// the overall brick size doesn't match a real brick
// size in height or depth.
BRICK_HEIGHT = 9.6;
BRICK_DEPTH = 7.8;

// Padding between neighbouring bricks. Adjust if bricks
// don't match a real brick in width.
BRICK_PADDING = 0.1;

// Size of interior shell wall
SHELL = 1.5;

// Dimensions of stud on top of brick. Adjust if a real
// brick doesn't fit correctly on top of the printed one.
STUD_HEIGHT = 1.7;
STUD_DIAMETER = 4.8;

// Dimensions of pin on underside. Adjust if printed brick
// doesn't fit correctly on top of a real brick.
PIN_DIAMETER = 3;

// Main inner hole diameter. Make larger if a connector
// or axle are too tight. Make smaller if connector comes 
// out too easily or axle is too wobbly. Measured value
// is 4.8.
INNER_HOLE_DIAMETER = 5.2;

// Diameter and depth of the outer chamfer for a hole. If
// connectors fit fine but don't push all the way in, one of 
// these is likely too small - normally the outer diameter. 
OUTER_HOLE_DIAMETER = 6.3;
HOLE_CHAMFER = 0.8;

// Spacing between holes. This shouldn't be changed unless
// deliberately attempting to create none-standard bricks. 
SPACING = 8;

translate([0,0,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL
);

//normal inner hole with scaffold
translate([0,15,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL,
    hole_scaffold=true
);

translate([0,30,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER-0.1,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL
);

//normal inner hole with scaffold
translate([0,45,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER-0.1,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL,
    hole_scaffold=true
);

translate([0,60,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER-0.2,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL
);

//normal inner hole with scaffold
translate([0,75,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER-0.2,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL,
    hole_scaffold=true
);

translate([0,90,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER+0.1,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL
);

//normal inner hole with scaffold
translate([0,105,0])
brick(
    spacing=SPACING,
    holes=HOLES,
    height=BRICK_HEIGHT,
    depth=BRICK_DEPTH,
    padding=BRICK_PADDING,
    stud_height=STUD_HEIGHT,
    stud_diameter=STUD_DIAMETER,
    pin_diameter=PIN_DIAMETER,
    inner_hole_diameter=INNER_HOLE_DIAMETER+0.1,
    outer_hole_diameter=OUTER_HOLE_DIAMETER,
    hole_chamfer=HOLE_CHAMFER,
    shell=SHELL,
    hole_scaffold=true
);

/*
for(i=[0:2]) {
    holes = HOLES+i*2;
    translate([calc_brick_width(SPACING, holes, BRICK_PADDING)*0.5, i*20, 0])
    brick(
        spacing=SPACING,
        holes=holes,
        height=BRICK_HEIGHT,
        depth=BRICK_DEPTH,
        padding=BRICK_PADDING,
        stud_height=STUD_HEIGHT,
        stud_diameter=STUD_DIAMETER,
        pin_diameter=PIN_DIAMETER,
        inner_hole_diameter=INNER_HOLE_DIAMETER,
        outer_hole_diameter=OUTER_HOLE_DIAMETER,
        hole_chamfer=HOLE_CHAMFER,
        shell=SHELL
    );
}
*/

//-------------------------------------------------------------
// Internal functions 
//-------------------------------------------------------------

function calc_brick_width(spacing, holes, padding) = spacing * (holes + 1) - padding * 2;

module brick(spacing, holes, height, depth, padding, stud_height, stud_diameter, pin_diameter, inner_hole_diameter, outer_hole_diameter, hole_chamfer, shell, hole_scaffold) {
    difference() {
        union() {
            union() {
                brick_body(spacing, holes, height, depth, padding, shell);

                // Underside pins + containing cylinder for hole
                translate([-spacing * (holes - 1) * 0.5,0,0])
                union() {
                    for(i = [0:holes-1]) {
                        translate([i*spacing,0,0])
                        union() {
                            rotate([90,0,0])
                            cylinder(h=depth-0.01, d=outer_hole_diameter+0.2, center=true);
                            
                            cylinder(h=height, d=pin_diameter, center=true);
                        }                                               
                    }
                }             
            }
            
            translate([-spacing * (holes - 1 + 1) * 0.5,0,height*0.5])
            union() {
                for(i = [0:holes]) {
                    translate([i*spacing, 0, 0])
                    stud(stud_height, stud_diameter, pin_diameter);
                }
            }            
        }
        
                
        translate([-calc_brick_width(spacing, holes, padding)*0.5+0.5, 0, height*0.4])
        scale(0.3)
        rotate([90,0,-90])
        union() {
            linear_extrude(5)
            text(str(inner_hole_diameter), halign="center", valign="top");
            
            st = hole_scaffold ? "S" : "N";
            translate([0, -14, 0])
            linear_extrude(5)
            text(st, halign="center", valign="top");
        }        

        translate([-spacing * (holes - 1) * 0.5,0,0])
        union() {
            for(i = [0:holes-1]) {
                // Main inner hole.
                translate([i*spacing,0,0]) 
                rotate([90,0,0])
                common_hole(inner_hole_diameter, outer_hole_diameter, depth, hole_chamfer, scaffold=hole_scaffold);              
            }
        }
    }
}

// Main body of the brick.
module brick_body(spacing, holes, height, depth, padding, shell) {
    bw = calc_brick_width(spacing, holes, padding);
    difference() {
        cube([bw, depth, height], center=true);
        
        translate([0,0,-shell])
        cube([bw-shell*2, depth-shell*2, height], center=true);
    }
}

module stud(stud_height, stud_diameter, pin_diameter) {
    translate([0,0,stud_height*0.5])
    difference() {
        cylinder(h = stud_height, d = stud_diameter, center=true);
        cylinder(h = stud_height*2, d = pin_diameter, center=true);
    }
}
