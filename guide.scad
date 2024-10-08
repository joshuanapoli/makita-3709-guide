use <MCAD/shapes.scad>

// makita 3709
// guide for following linear part
guide_size=37;

guide_diameter=12;
guide_height=15;
guide_spacing=guide_size+guide_diameter;


// plate is attached by four screws
// 90x82mm square plate
// attached by four screws in square pattern with 70x62mm pattern

plate_length=90;
plate_width=82;
plate_height=5.5;

screw_layout_length=70;
screw_layout_width=62;
screw_recess_diameter=8.5;
screw_through_diameter=5;

main_hole_diameter=35;
main_hole_offset=4;

air_guide_diameter=22;

notch_length=28;

screw_layout=[
    [-screw_layout_length/2,-screw_layout_width/2],
    [ screw_layout_length/2,-screw_layout_width/2],
    [-screw_layout_length/2, screw_layout_width/2],
    [ screw_layout_length/2, screw_layout_width/2]];

guide_layout=[
    [-guide_spacing/2,-screw_layout_width/2,-guide_height],
    [ guide_spacing/2,-screw_layout_width/2,-guide_height],
    [-guide_spacing/2, screw_layout_width/2,-guide_height],
    [ guide_spacing/2, screw_layout_width/2,-guide_height]];

difference() {
    union() {
        roundedBox(plate_length, plate_width, plate_height, 5);
        for(v = guide_layout) translate(v) cylinder(d=guide_diameter, h=guide_height);
        translate([0,main_hole_offset,-8]) cylinder(d1=guide_size,d2=main_hole_diameter+30,h=8);
    }

    for(v = screw_layout) {
        translate(v) {
            translate([0,0,-10]) cylinder(d=screw_recess_diameter, h=10);
            translate([0,0,-5]) cylinder(d=screw_through_diameter, h=10);
        }
    }
    translate([0,main_hole_offset,-20]) cylinder(d=main_hole_diameter, h=40);
    translate([0,0,6]) rotate([75,0]) cylinder(d=air_guide_diameter,h=40);
translate([0,plate_width/2,0]) roundedBox(notch_length, 2, 2*plate_height, 0.25);
}
