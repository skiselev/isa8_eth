// ISA Bracket - Compatible with Keystone Electronics 9202
//
// Copyright (C) Sergey Kiselev <skiselev@gmail.com>
// Losely based on work by Arne Schmitz <arne.schmitz@me.com>

br_width = 18.4;
br_height = 120.02;
br_thick = 1.2;
tolerance = 0.1;

cut_bottom_width = 4.11;
cut_bottom_height = 7.5;

br_height_wo_tongue = 112.78;
tongue_height = (br_height - br_height_wo_tongue);
tongue_width = 10.2;
tongue_cut_width = (br_width-tongue_width)/2;

tab_width=18.8;
tab_length=11.4;

cut_left_height=6;
cut_left_width=2.8;

append_right_height=2.5; // 3.2;
append_right_width=cut_left_width+tab_width-br_width;

tab_hole_diameter = 4.4;
tab_hole_y = tab_length+br_thick-6.35;
tab_hole_z = cut_left_width+tab_width-3.2;

pcb_mount_length = 8.9;
pcb_mount_width = 6.1;
pcb_mount_thick = 1;
pcb_mount_1_x = 31.75;
pcb_mount_2_x = pcb_mount_1_x + 56.52;

pcb_hole_y = 5.33;
pcb_hole_diameter = 2.8;

eth_height = 16.25; // 0.64"
eth_width = 14.2; // 0.56"
eth_center_x = pcb_mount_1_x + 1.125 * 25.4;
eth_offset_z = 2;

// Bracket orientation: laying down on PCB mounts in card's (X-Y) plane
// Origin - top (ISA card oriented vertically) inside (closer to the PCB) corner

union() {
    difference() {
        // blank bracket
        blank_bracket();
        // cutout for the Ethernet connector
        eth_cutout();
    }
    // first PCB mount
    translate([pcb_mount_1_x,0,0]) {
        pcb_mount();
    }
    // second PCB mount
    translate([pcb_mount_2_x,0,0]) {
        pcb_mount();
    }
    // bottom reinforcement
    translate([cut_left_height+cut_left_width,0,0]) {
        rotate([0,0,270]) {
            rounded_cube2(3.5,pcb_mount_2_x+12.065-cut_left_height-cut_left_width,pcb_mount_thick,1);
        }
    }
    // top reinforcement
    translate([cut_left_height+cut_left_width,-1,br_width-1]) {
        cube ([pcb_mount_2_x+12.065-cut_left_height-cut_left_width,1,1]);
        translate([0,1,-1]) {
            rotate([45,0,0]) {
                cube([pcb_mount_2_x+12.065-cut_left_height-cut_left_width,sqrt(2),sqrt(2)]);
            }
        }
    }
}

module blank_bracket() {
    translate([0,0,0]) {
        difference() {
            union() {
                // the main bracket sheet
                cube([br_height_wo_tongue,br_thick,br_width]);
                // appendix - top right
                translate([0,0,br_width]) {
                    cube([append_right_height,br_thick,append_right_width]);
                }
                translate([append_right_height-append_right_width,0,br_width]) {
                    rotate([0,45,0]) {
                        cube([append_right_width*sqrt(2),br_thick,append_right_width*sqrt(2)]);
                    }
                }
                // mounting tab
                translate([-br_thick,0,cut_left_width]) {
                    //cube([br_thick,tab_length+br_thick,tab_width]);
                    rotate([90,0,90]) {
                        rounded_cube2(tab_length+br_thick,tab_width,br_thick,2);
                    }
                    translate([0,br_thick+tab_length-6.35,cut_left_width+tab_width]) {
                    }
                }
            }
            // cut corner towards the tongue (closer to PCB)
            translate([br_height_wo_tongue-tongue_cut_width,-tolerance,0]){
                rotate([0,45,0]) {
                    cube([tongue_cut_width*sqrt(2),br_thick+tolerance*2,tongue_cut_width*sqrt(2)]);
                }
            }
            // cut corner towards the tongue (farther from PCB)
            translate([br_height_wo_tongue-tongue_cut_width,-tolerance,br_width]){
                rotate([0,45,0]) {
                    cube([tongue_cut_width*sqrt(2),br_thick+tolerance*2,tongue_cut_width*sqrt(2)]);
                }
            }
            // cutout - top left
            translate([-tolerance,-tolerance,-tolerance]) {
                cube([cut_left_height+tolerance,br_thick+tolerance*2,cut_left_width+tolerance]);
            }
            translate([cut_left_height-cut_left_width,-tolerance,0]) {
                rotate([0,45,0]) {
                    cube([cut_left_width*sqrt(2),br_thick+tolerance*2,cut_left_width*sqrt(2)]);
                }
            }
            // mounting tab - slot for the screw
            translate([-br_thick-tolerance,tab_hole_y,tab_hole_z]) {
                rotate([0,90,0]) {
                    cylinder(d=tab_hole_diameter,h=br_thick+tolerance*2,$fn=64);
                }
                translate([0,-tab_hole_diameter/2,0]) {
                    cube([br_thick+tolerance*2,tab_hole_diameter,3.2+tolerance]);
                }
            }
        }
    }
    // the tongue
    translate([br_height_wo_tongue,br_thick,tongue_cut_width]) {
        //cube([tongue_height,br_thick,tongue_width]);
        rotate([90,0,0]) {
            rounded_cube2(tongue_height,tongue_width,br_thick,2);
        }
    }
}

module pcb_mount() {
    difference () {
        translate([-pcb_mount_width/2,0,0]) {
            rotate([0,0,270]) {
                rounded_cube2(pcb_mount_length,pcb_mount_width,1,pcb_mount_thick);
            }
        }
        translate([0,-pcb_hole_y,-tolerance]) {
            cylinder(d=pcb_hole_diameter,h=pcb_mount_thick+tolerance*2,$fn=64);
        }
    }
}

// Cutout for Ethernet modular connector
module eth_cutout() {
      translate([eth_center_x-eth_height/2,-tolerance,eth_offset_z]) {
          cube([eth_height,br_thick+tolerance*2,eth_width]);
      }
}

// rounded_cube2 - draws a "cube" with two rounded corners
// it is assumed that the cube lays in the X-Y plane
// and the rounded corner is in Z axis
module rounded_cube2(x,y,z,r) {
    union() {
        cube([x-r,y,z]);
        hull() {
            translate([x-r,r,0]) {
                cylinder(r=r,h=z,$fn=64);
            }
            translate([x-r,y-r,0]) {
                cylinder(r=r,h=z,$fn=64);
            }
        }
    }
}