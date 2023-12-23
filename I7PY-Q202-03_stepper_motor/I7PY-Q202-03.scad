
    //cube([42,42,23.3],center=true);
    // Parameters
length = 42;  // Length of the stepper motor
width = 42;  // Width of the stepper motor
height = 23.3;   // Height of the stepper motor
cut_depth = 3; // Size of the angled cuts
screws_holes_diameter = 3;
screws_holes_distance_side = 32;


module inner_circle_and_shaft()
{

    outer_diameter = 22;
    inner_diameter = outer_diameter - 3.5;
    ic_height = 1.4;
    translate([0,(height+ic_height)/2,0])
    {
        rotate([90,0,0])
        {
            difference()
            {
                cylinder(h=ic_height, d=outer_diameter, center=true);
                cylinder(h=ic_height, d=inner_diameter, center=true);
            }
        }
    }
    
    shaft_diameter = 5;
    shaft_height = 25;
    translate([0,(height+shaft_height)/2,0])
    rotate([90,0,0])
    cylinder(h=shaft_height,d=shaft_diameter,$fn=50);
}



// Function to create an angled cut
module angled_cut()
{
    rotate([0, 45, 0])
    translate([-cut_depth, -height/2, -cut_depth])
    cube([cut_depth * 2, height, cut_depth * 2]);
}


union()
{
    // Main model
    color("black")
    difference() 
    {
        // Create the main cuboid
        cube([length, height, width], center=true);
        for (x = [-1, 1]) 
        {
            for (y = [-1, 1])    
            {
                for (z = [-1, 1])
                {
                    // corners angled cuts 
                    translate([x * length/2, y * height/2, z * width/2]) 
                    {
                          angled_cut();
                    }
                    
                    // screws holes
                    translate([x * screws_holes_distance_side/2, 0, z* screws_holes_distance_side/2])
                    {
                        rotate([90,0,0])
                        cylinder(h=height, d=screws_holes_diameter, center=true, $fn=50);
                    }
                }
            }
        }
    }

    color("gray")
    inner_circle_and_shaft();
}