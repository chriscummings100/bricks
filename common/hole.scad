
module common_hole(inner_diameter, outer_diameter, depth, chamfer, scaffold = false) {
    difference() {
        union(){
            
            // Main inner hole.
            cylinder(h=depth, d=inner_diameter, center=true);
            
            // Outer chamfer at top and bottom.
            translate([0,0,depth*0.5])
                cylinder(h=chamfer*2, d=outer_diameter, center=true);
            translate([0,0,-depth*0.5])
                cylinder(h=chamfer*2, d=outer_diameter, center=true);
        }
        if(scaffold) {
            translate([0,0,depth*0.15]) 
            rotate([90,0,0]) 
            union() {
                cylinder(h=outer_diameter, d=0.3, center=true);
                translate([-inner_diameter*0.25,0,0]) 
                cylinder(h=outer_diameter, d=0.3, center=true);
                translate([inner_diameter*0.25,0,0]) 
                cylinder(h=outer_diameter, d=0.3, center=true);
                translate([0,0,-inner_diameter*0.15]) 
                rotate([0,90,0])
                cylinder(h=outer_diameter, d=0.3, center=true);
            }
            translate([0,0,depth*-0.15]) 
            rotate([90,0,0]) 
            union() {
                cylinder(h=outer_diameter, d=0.3, center=true);
                translate([-inner_diameter*0.25,0,0]) 
                cylinder(h=outer_diameter, d=0.3, center=true);
                translate([inner_diameter*0.25,0,0]) 
                cylinder(h=outer_diameter, d=0.3, center=true);
                translate([0,0,-inner_diameter*0.15]) 
                rotate([0,90,0])
                cylinder(h=outer_diameter, d=0.3, center=true);
            }
        }
    }
}