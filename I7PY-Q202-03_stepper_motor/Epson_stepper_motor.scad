use <I7PY-Q202-03.scad>
module epson_stepper_motor_template()
{
    shaft_diameter = 25;
    shaft_height = 20;

    screw_hole_diameter = 3;
    screw_holes_distance = 42.5;

    cylinder(h=shaft_height,d=shaft_diameter, center=true, $fn=50);

    for (x = [-1, 1])
    {
        translate([x * screw_holes_distance/2,0,0])
        cylinder(h=shaft_height, d=screw_hole_diameter, center=true, $fn=50);
    }
}

epson_motor_outer_diameter = 25;
epson_relative_height = 26.5;



planes_height=2;
distance_to_side_stepper_motor = 86;
i7py_motor_side  = 42;
margin = 8.5;
i7py_motor_height = 23.3;

xy_plane_base_size = [i7py_motor_side + margin,
                      i7py_motor_side/2 + distance_to_side_stepper_motor,
                      planes_height];

xy_plane_support_epson_motor_size = [i7py_motor_side + margin,
                                     epson_relative_height + epson_motor_outer_diameter/2+planes_height+1,
                                     planes_height+1];



union()
{
    difference()
    {
        translate([0,
                   i7py_motor_side/2-xy_plane_base_size[1]/2,
                   planes_height/2])
        cube(xy_plane_base_size, center=true);

        //epson_stepper_motor_template();
        translate([0,0,-i7py_motor_height/2])
        I7PY_stepper_motor(extrude=true);
    }

    difference()
    {
        translate([0,
                   xy_plane_support_epson_motor_size[2]/2+i7py_motor_side/2-xy_plane_base_size[1],
                   xy_plane_support_epson_motor_size[1]/2])
        rotate([90,0,0])
        cube(xy_plane_support_epson_motor_size, center=true);

        translate([0,
                   xy_plane_support_epson_motor_size[2]/2+i7py_motor_side/2-xy_plane_base_size[1],
                   epson_relative_height])
        rotate([90,0,0])
        epson_stepper_motor_template();
    }
}


    laser_diameter = 6;
    laser_height = 52;
    wall_h = 2.6;

    laser_support_plane_1_size = [i7py_motor_side + margin,
                                  i7py_motor_side + margin,
                                  wall_h];
        translate([0,
                   -wall_h/2,
                   laser_height])
        difference()
        {
            cube(laser_support_plane_1_size, center=true);
            cylinder(h=30, d=laser_diameter,center=true, $fn=50);
        }


laser_support_plane_2_size = [i7py_motor_side + margin, 
                             laser_height,
                             3];
translate([0,
           (i7py_motor_side +laser_support_plane_2_size[2])/2,
           laser_height/2])
rotate([90,0,0])        
cube(laser_support_plane_2_size, center=true);
