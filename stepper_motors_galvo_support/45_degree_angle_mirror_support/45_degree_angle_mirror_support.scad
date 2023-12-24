$fn=70;
module mirror_support_for_stepper_motor
(   plane_side_length = 20,
    shaft_diameter = 5, 
    shaft_height = 15,
    shaft_support_wall_size = 6,
    tolerance = 0.4
)
 {  
    
    module shaft()
    {        
        translate([0,0,-shaft_height/2])
        cylinder(h=shaft_height,d=shaft_diameter+tolerance,center=true);
    }

    module shaftSupport()
    {
        translate([0,0,-shaft_height/2])
        cylinder(h=shaft_height,d=shaft_diameter+shaft_support_wall_size+tolerance,center=true);
    }

    module mirrorSupport(l=plane_side_length)
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

    color("gray")
    union()
    {
        difference()
        {
            diameter_screw = 3;
            distance_to_border = 3.5;
            shaftSupport();
            translate([0,-5,distance_to_border-shaft_height+diameter_screw/2])
            rotate([90,0,0])
            color("green")
            cylinder(h=7,d=diameter_screw,center=true);
            shaft();
        }  
        mirrorSupport(plane_side_length);
    }
}


translate([-15,0,0])
rotate([125,0,180])
mirror_support_for_stepper_motor(shaft_diameter=5);

translate([15,0,0])
rotate([45,180,0])
mirror_support_for_stepper_motor(shaft_diameter=7.4);
