$fn=70;

diameter  = 5;
height=36;
module shaft(tolerance)
{
    
    translate([0,0,-height/2])
    cylinder(h=height,d=diameter+tolerance,center=true);
}


module shaftSupport(tolerance)
{
    diameter_support=6;    
    translate([0,0,-height/2])
    cylinder(h=height,d=diameter+diameter_support+tolerance,center=true);
}



tolerance=1.5;
difference()
{
difference()
{
shaftSupport(tolerance);
translate([0,5,-30])
rotate([90,0,0])
color("green")
cylinder(h=7,d=3,center=true);
}
    shaft(tolerance);
}

//cube(22,center=true);



cube_size = 22;

// Create the cube
//cube([cube_size, cube_size, cube_size]);

// Difference operation

translate([0,tolerance,cube_size/2])
rotate([180,0,0])
difference() {
    // Original cube
    cube([cube_size, cube_size, cube_size], center=true);
    // Create the cutting shape
    translate([-cube_size, -cube_size, -cube_size])
    rotate([45, 0, 0]) // Rotates around the X-axis
    cube([cube_size * 3, cube_size * 3, cube_size * 3],center=true);
}
