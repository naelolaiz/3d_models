use <28BYJ-48.scad>;
use <circular_mirror_support_45_degree_support/circular_mirror_support_45_degree_support.scad>;

module galvo_support_v2(tolerance = 0.2, wall_width = 4, show_components = false)
{
    cube_external_size = [50, 88, 60];
    cube_internal_size = cube_external_size - [-10, wall_width*2, wall_width*2];
    shaft_height = 20;
    lift_horizontal = 2;

    position_horizontal_stepper_motor = [0,
                                         13,
                                         lift_horizontal-cube_internal_size[2]/2];
                                         
    position_vertical_stepper_motor = [0,-cube_internal_size[1]/2,0];


    difference()
    {
        union()
        {
            difference()
            {
                // case
                cube(cube_external_size,center=true);
                cube(cube_internal_size,center=true);
            }
            // extra base
            c_size = [cube_external_size[0],cube_internal_size[1]/2, lift_horizontal];
            translate([0,c_size[1]/2,c_size[2]/2-cube_internal_size[2]/2])
            cube(c_size,center=true);
            
            // extra base
            base_height = 12.1;
            translate([0,-cube_external_size[1]/4,- (cube_external_size[2] + base_height )/2])
            cube([30,30,base_height],center=true);
        }

        
        // stepper_motors
        translate(position_horizontal_stepper_motor)
        {
            stepper_motor_28BYJ_48(true, true, true, tolerance=tolerance);
        }
        
        translate(position_vertical_stepper_motor)
        {
            rotate([-90,0,0])
            {
                stepper_motor_28BYJ_48(true, true, true, tolerance=tolerance);
            }
        }
        
        // laser
        laser_diameter = 6;
        translate([0,position_horizontal_stepper_motor[1],20])
        cylinder(h=10,d=laser_diameter + tolerance,$fn=100);
    }
    
    if(show_components)
    {
    translate(position_horizontal_stepper_motor)
    {
        rotate ([0,0,90])  circular_mirror_support_45_degree_support();
        stepper_motor_28BYJ_48(true,true);
    }

    translate(position_vertical_stepper_motor)
    {
        rotate([-90,0,0])
        {
            rotate ([0,0,90]) circular_mirror_support_45_degree_support();
            stepper_motor_28BYJ_48(true,true);
        }
    }
}
}

translate([0,60,0])
galvo_support_v2();

translate([0,-60,0])
galvo_support_v2(show_components=true);
