// 3D speaker box module
// The adding of parts occurs in a weird way.
// I should change it so all of the solid prts that stay (like the box) are in one module and then all of the parts that need to be subtracted simultaneously should be in a different module
// It's currently in a weird order

// compileParts() takes all of the individual shapes and compiles them together
module compileParts() {
    // addTerminal();
    // driverHole();
    // makeBox();
    addScrews();
}

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

module insideBox() {
    translate([0.2, 0.2, 0.2]) cube([4.6, 3.6, 6.6]);
}

// makeBox() creates 5x7x4 hollow box
module makeBox() {
    difference() {cube([5, 4, 7], false); 
                  translate([0.2, 0.2, 0.2]) 
                  cube([4.6, 3.6, 6.6]);};
}

// driverHole() creates the hole for the driver
module driverHole() {
    $fn = 100;
    translate([2.75, .25, 3]) rotate([90, 0, 0]) cylinder(0.5, 1.53, 1.53, false);
}

// DdriverScrews() creates the screw hole shape
module driverScrews() {
    $fn = 100;
    translate([1.77, .25, 0]) rotate([90, 0, 0]) cylinder(0.5, 0.046875, 0.046875, false);
}

// addDriver() adds the hole to the hollow box
module addDriver() {
    $fn = 100;
    difference() {makeBox(); driverHole(); };
}

// terminal() makes the speaker terminal shape
module terminal() {
    translate([2, 3.5, 3]) cube([1, 1, 1], false);
}
  
// addTerminal() adds the speaker terminal hole to the box
module addTerminal() {
    difference() {addDriver(); terminal(); };
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

module terminalHoles() {
    $fn = 100;
    translate([0.6, 0.25, 0.6]) rotate([90, 0, 0])
    cylinder(0.5, 0.046875, 0.046875, false);
}

module centerTermHoles() {
    terminalHoles();
    translate([0, 0, -1.2]) terminalHoles();
    translate([-1.2, 0, -1.2]) terminalHoles();
    translate([-1.2, 0, 0]) terminalHoles();
}
module addScrews1() {
    // driverscrews
   difference() {addTerminal(); translate([2.75, 0, 3])centerScrews(); }; 
}

// Terminal screws
module addScrews2() {
    difference() {addScrews1(); translate([2.5, 4, 3.5]) centerTermHoles(); };
}

// compileParts();
//driverHole();
// centerScrews();
// addScrews2();
// translate([2.5, 4, 3]) centerTermHoles();
minusParts();