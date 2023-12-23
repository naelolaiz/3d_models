$fn=70;

diameter  = 5;
height=15;
module shaft(tolerance)
{
    
    translate([0,0,-height/2])
    cylinder(h=height,d=diameter+tolerance,center=true);
}


module shaftSupport(tolerance)
{
    diameter_support=4;    
    translate([0,0,-height/2])
    cylinder(h=height,d=diameter+diameter_support+tolerance,center=true);
}

module mirrorSupport(l=15)
{
points = [
    [0, 0, 0], // Point 1
    [0, l, 0], // Point 2
    [l, l, 0], // Point 3
    [l, 0, 0], // Point 4
    [0, l/2, sqrt(l*l/2)/sqrt(2) ], // Point 5
    [l, l/2, sqrt(l*l/2)/sqrt(2) ]  // Point 6
];
faces = [
    [3, 2, 1, 0],  // Base, normal upwards
    [0, 1, 4],     // Side triangle, normal outward
    [1, 2, 5, 4],  //  Side face, normal outward
    [2, 3, 5],     // Side triangle, normal outward
    [4, 5, 3, 0],  //  Side face, normal outward
];


translate([0,0,l/2/sqrt(2)])
rotate([135,0,0])
translate([-l/2,-l/2,0])
polyhedron(points, faces);
}

tolerance=0.4;

union()
{
    difference()
    {
        diameter_screw = 3;
        distance_to_border=5;
        shaftSupport(tolerance);
        translate([0,-5,distance_to_border-height+diameter_screw/2])
        rotate([90,0,0])
        color("green")
        cylinder(h=7,d=diameter_screw,center=true);
        shaft(tolerance);
    }  
    mirrorSupport(15);
}



