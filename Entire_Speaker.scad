// Ryan Jacobson and Daniel Mohaghegh
// 3D speaker box module
// The adding of parts occurs in a weird way.
// I should change it so all of the solid prts that stay (like the box) are in one module and then all of the parts that need to be subtracted simultaneously should be in a different module
// It's currently in a weird order

// compileParts() takes all of the individual shapes and compiles them together

// Height = 44
//
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

