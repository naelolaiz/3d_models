/*
rotate([45,0,0])
difference()
{
    sphere(d=30,$fn=300);
    translate([0,0,30/2])
    cube(30,center=true);    
    
}
*/

tolerance = 0.5;
use <../28BYJ-48.scad>;
motor_shaft_diameter = 5;
shaft_support_wall_size = 3.7;
module circular_mirror_support_45_degree_support()
{
    base_diameter = 30;
    base_small_diameter = 2;
    base_length = 10;
    shaft_height = 20;
    shaft_diameter = motor_shaft_diameter + shaft_support_wall_size;
    translate([0,0,shaft_height])
    union()
    {
        rotate([45,0,0])
        cylinder(h=base_length,d1=base_small_diameter,d2=base_diameter,center=true,$fn=100);
        
        translate([0,0,-shaft_height/2])
        cylinder(h=shaft_height, d=shaft_diameter,center=true,$fn=100);
    }
}

difference()
{
    circular_mirror_support_45_degree_support();
    stepper_motor_28BYJ_48(include_big_axis_circle = false, tolerance = tolerance);
    
    start_to_flat_shaft = 3;
    distance_to_screw_hole = 2;
    screw_diameter = 2.5;

    translate([0, shaft_support_wall_size/3, start_to_flat_shaft + distance_to_screw_hole + (screw_diameter+tolerance)/2])
    rotate([-90,0,0])
    cylinder(h=shaft_support_wall_size,d=screw_diameter+tolerance, $fn=50);
}