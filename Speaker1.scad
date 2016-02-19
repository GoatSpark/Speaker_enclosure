// 3D speaker box module

// This module creates our hollow box
module makeBox() {
    difference() {cube([5, 4, 7], false); 
                  translate([0.2, 0.2, 0.2]) 
                  cube([4.6, 3.6, 6.6]);};
}

// This module creates the hole for the driver
module driverHole() {
    translate([2.75, .25, 3]) rotate([90, 0, 0]) cylinder(0.5, 1.53, 1.53, false);
}
// This module adds the hole to the hollow box
module makeHole() {
    $fn = 100;
    difference() {makeBox(); driverHole(); };
}

makeHole();
  