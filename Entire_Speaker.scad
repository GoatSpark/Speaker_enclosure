// Ryan Jacobson and Daniel Mohaghegh
// 3D speaker box module
// The adding of parts occurs in a weird way.
// I should change it so all of the solid prts that stay (like the box) are in one module and then all of the parts that need to be subtracted simultaneously should be in a different module
// It's currently in a weird order

// compileParts() takes all of the individual shapes and compiles them together
module compileExterior() {
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

module plusInterior() {
    translate([0, 1, 0]) verticalPlane();
    translate([0, 3, 0]) verticalPlane();
    translate([0, 0, 1]) horizontalPlane();
    translate([0, 0, 5]) horizontalPlane();    
    
}
    
    
    
module verticalPlane() {
    cube([5,.2,7]);
}

module horizontalPlane() {
    cube([5, 4, .2]);
}

module verticalCylinder(xval) {
    translate([xval, 2.25, .5])
    cylinder(5, .4, .4, false);
}

module horizontalHoles(xdim, zdim) {
    translate([xdim, 3.5, zdim])
    rotate([90, 0, 0])
    cylinder(3, .3, .3, false);
}

module minusInterior() {
    $fn = 100;
    
    rotate([90, 0, 0])
    translate([2.75, 3, -3.5])
    cylinder(3, 1.6, 1.6, false);
    
    verticalCylinder(1.25);
    verticalCylinder(3.25);
    horizontalHoles(1.25, 6);
    horizontalHoles(4, 6);
    horizontalHoles(1.25, .6);
    horizontalHoles(4, .7);
}

module compileInterior() {
    difference() {plusInterior(); minusInterior();};
}
//compileInterior();

module compileFinal() {
    union() {compileInterior(); compileExterior();};
}  

// ***************************************************************
// ***************************************************************

module frontPanel() {
    cube([16, 0.75, 44]);
}

module speakerHole(xspeak, zspeak, radspeak) {
    rotate ([90, 0, 0]) translate([xspeak, zspeak, -4]) cylinder(5, radspeak, radspeak, false);
}

module exteriorBox() {
    union() {frontPanel(); cube([16, 13, 27]);};
}
    
    

module subBoxInnard() {
    $fn = 100;
    
    union() {difference() {exteriorBox(); union() {translate([.75, .75, .75]) cube([14.5, 11.5, 25.5]); speakerHole(8, 6.75, 5.5); speakerHole(8, 19.5, 5.5);};}; translate([0, 0, 12.5]) cube([16, 13, .75]);};
    
    
}

module final() {
    $fn = 100;
    difference() {subBoxInnard(); speakerHole(9.5, 35, 5); speakerHole(2.5, 39, 2); speakerHole(2.5, 31, 2); speakerHole(2.5, 35, 1);};
}

final();

