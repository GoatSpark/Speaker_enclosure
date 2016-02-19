// Ryan Jacobson and Daniel Mohaghegh
// 3D speaker box module
// The adding of parts occurs in a weird way.
// I should change it so all of the solid prts that stay (like the box) are in one module and then all of the parts that need to be subtracted simultaneously should be in a different module
// It's currently in a weird order

// compileParts() takes all of the individual shapes and compiles them together
module compileParts() {
    difference() {outsideBox(); minusParts();};
}

// Adds all the parts to be transformed into holes
module minusParts() {
    $fn = 100;
    // Inside box
    insideBox();
    
    // Driver
    driverHole();
    
    // Terminal
    terminal();
    
    // Drivers screws
    translate([2.75, 0, 3]) centerScrews();
    
    // Terminal screws
    translate([2.5, 4, 3.5]) centerTermHoles();
}

// makeBox() creates 5x7x4 box
module outsideBox() {
    cube([5, 4, 7], false); 
}

// insideBox() creates the hollow inside box shape
module insideBox() {
    translate([0.2, 0.2, 0.2]) cube([4.6, 3.6, 6.6]);
}

// driverHole() creates the hole for the driver
module driverHole() {
    $fn = 100;
    translate([2.75, .25, 3]) rotate([90, 0, 0]) cylinder(0.5, 1.53, 1.53, false);
}
// driverScrews() creates the driver screw hole shape
module driverScrews() {
    $fn = 100;
    translate([1.77, .25, 0]) rotate([90, 0, 0]) cylinder(0.5, 0.05469, 0.05469, false);
}

// centerScrews() creates 6 screw shapes and centers them around the driver hole (coordinates hard-coded)
module centerScrews() { 
    driverScrews();
    rotate([0, 60, 0]) driverScrews();
    rotate([0, 120, 0]) driverScrews();
    rotate([0, 180, 0]) driverScrews();
    rotate([0, 240, 0]) driverScrews();
    rotate([0, 300, 0]) driverScrews();
}

// terminal() makes the speaker terminal shape
module terminal() {
    translate([2, 3.5, 3]) cube([1, 1, 1], false);
}

// terminalHoles() creates the terminal screw hole shape
module terminalHoles() {
    $fn = 100;
    translate([0.6, 0.25, 0.6]) rotate([90, 0, 0])
    cylinder(0.5, 0.03906, 0.03906, false);
}

// centerTermHoles creates 4 terminal screw shapes and centers them around the terminal (coordinates hard-coded)
module centerTermHoles() {
    terminalHoles();
    translate([0, 0, -1.2]) terminalHoles();
    translate([-1.2, 0, -1.2]) terminalHoles();
    translate([-1.2, 0, 0]) terminalHoles();
}

compileParts();