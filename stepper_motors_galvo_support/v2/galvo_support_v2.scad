/*
rotate([45,0,0])
difference()
{
    sphere(d=30,$fn=300);
    translate([0,0,30/2])
    cube(30,center=true);    
    
}
*/
module circular_mirror_45_degree_support()
{
    base_diameter = 30;
    base_small_diameter =5;
    base_length = 10;
    shaft_height = 20;
    shaft_diameter = 8+3;
    translate([0,0,shaft_height])
    union()
    {
        rotate([45,0,0])
        cylinder(h=base_length,d1=base_small_diameter,d2=base_diameter,center=true,$fn=100);
        
        translate([0,0,-shaft_height/2])
        cylinder(h=shaft_height, d=shaft_diameter,center=true,$fn=100);
    }
}

circular_mirror_45_degree_support();