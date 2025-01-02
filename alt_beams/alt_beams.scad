$fn=100;

//-------------------------------------------------------------
// Constants for default setup 
//-------------------------------------------------------------

// How many holes in the beam.
HOLES = 5;

// Dimensions of the beam body. Adjust these if
// the overall beam size doesn't match a real beam
// size. Measured values are 7.35 and 7.8 respectively.
BEAM_DIAMETER = 7.2;
BEAM_DEPTH = 7.7;

// Main inner hole diameter. Make larger if a connector
// or axle are too tight. Make smaller if connector comes 
// out too easily or axle is too wobbly. Measured value
// is 4.8.
INNER_HOLE_DIAMETER = 5;

// Diameter and depth of the outer chamfer for a hole. If
// connectors fit fine but don't push all the way in, one of 
// these is likely too small - normally the outer diameter. 
OUTER_HOLE_DIAMETER = 6.3;
HOLE_CHAMFER = 0.8;

// Spacing between holes. This shouldn't be changed unless
// deliberately attempting to create none-standard bricks. 
SPACING = 8;

//-------------------------------------------------------------
// Create the default beam
//-------------------------------------------------------------

for(i=[0:5]) {
    translate([0,i*10,0])
    beam(
        num_holes=HOLES+i*2,
        beam_diameter=BEAM_DIAMETER,
        beam_depth=BEAM_DEPTH,
        spacing=SPACING,
        inner_hole_diameter=INNER_HOLE_DIAMETER,
        outer_hole_diameter=OUTER_HOLE_DIAMETER,
        hole_chamfer=HOLE_CHAMFER
    );
}

//-------------------------------------------------------------
// Internal functions 
//-------------------------------------------------------------

module hole_cavity(beam_diameter, spacing, outer_diameter, depth) {
    difference() {
        cw = 1.5;
        epsilon = 0.01;
        diam = beam_diameter;
        translate([-spacing*0.5+cw*0.5,0,0])
        union() {
            translate([0,0,-depth*0.75])
            cube([cw+epsilon, outer_diameter, depth], center=true);
            translate([0,0,depth*0.75])
            cube([cw+epsilon, outer_diameter, depth], center=true);
        }
        cylinder(h=depth*2, d=spacing*0.9, center=true);
    }     
}

// The holes to cut for a given segment.
module hole_shape(beam_diameter, spacing, inner_diameter, outer_diameter, depth, chamfer, cavity) {
    rotate([90,0,0])
    union(){
        
        // Main inner hole.
        cylinder(h=depth, d=inner_diameter, center=true);
        
        // Outer chamfer at top and bottom.
        translate([0,0,depth*0.5])
            cylinder(h=chamfer*2, d=outer_diameter, center=true);
        translate([0,0,-depth*0.5])
            cylinder(h=chamfer*2, d=outer_diameter, center=true);
        
        if(cavity) {
            // The cuts that make up the additional cavity
            // between the holes.
            hole_cavity(
                beam_diameter = beam_diameter,
                spacing = spacing, 
                outer_diameter = outer_diameter,
                depth = depth);      
            scale([-1,1,1])
            hole_cavity(
                beam_diameter = beam_diameter,
                spacing = spacing, 
                outer_diameter = outer_diameter,
                depth = depth);                    
        }
    }
}

// Main body of the beam.
module beam_body(spacing, diameter, holes, depth) {
    bw = spacing * (holes - 1);
    union() {
        cube([bw, depth, diameter], center=true);

        translate([-bw*0.5,0,0])
        rotate([90,0,0])
        cylinder(h=depth, d=diameter, center=true);

        translate([bw*0.5,0,0])
        rotate([90,0,0])
        cylinder(h=depth, d=diameter, center=true);
    }
    
}

// Construct a single beam.
module beam(num_holes, beam_diameter, beam_depth, spacing, inner_hole_diameter, outer_hole_diameter, hole_chamfer, face="up") {
   
    face_up = face=="up";
    r = face_up ? 90 : 0;

    rotate([r,0,0])        
    difference() {
        difference() {
            beam_body(
                spacing = spacing, 
                diameter = beam_diameter, 
                holes = num_holes, 
                depth = beam_depth);

            
            for(i=[0:num_holes]) {
                if( (i%2)==0) {
                    translate([-spacing*(num_holes-1)/2+i*spacing,0,0])
                    hole_shape(
                        beam_diameter = beam_diameter,
                        spacing = spacing,
                        inner_diameter = inner_hole_diameter,
                        outer_diameter = outer_hole_diameter,
                        depth = beam_depth,
                        chamfer = hole_chamfer,
                        cavity = true);
                }
            }
            
            for(i=[0:num_holes]) {
                if( (i%2)==1) {
                    translate([-spacing*(num_holes-1)/2+i*spacing,0,0])
                    union() {
                        rotate([90,0,0])
                        hole_shape(
                            beam_diameter = beam_diameter,
                            spacing = spacing,
                            inner_diameter = inner_hole_diameter,
                            outer_diameter = outer_hole_diameter,
                            depth = beam_depth,
                            chamfer = hole_chamfer,
                            cavity = false);
                        
                        rotate([90,0,0])
                        difference() {
                            cw = spacing;
                            epsilon = 0.01;
                            diam = beam_diameter;
                            union() {
                                translate([0,0,-beam_depth*0.75])
                                cube([cw+epsilon, outer_hole_diameter, beam_depth], center=true);
                                translate([0,0,beam_depth*0.75])
                                cube([cw+epsilon, outer_hole_diameter, beam_depth], center=true);
                            }
                            rotate([90,0,0])
                            cylinder(h=beam_depth*2, d=spacing*0.9, center=true);
                        }                            
                    }
                }
            }
            
        }         
    }


} 
