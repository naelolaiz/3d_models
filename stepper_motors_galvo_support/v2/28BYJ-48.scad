motor_shaft_diameter = 5;
center_y_displacement = 8;
module stepper_motor_28BYJ_48(include_big_axis_circle = true,  include_extra_plane = false, extrude_screws_and_cable = false, tolerance = 0)
{
    extra_extra_z_translation = include_extra_plane ? 1.1 : 0; // hole mounter plate
    extra_z_translation = include_big_axis_circle ? 0 : -1.1;
    
    s=(motor_shaft_diameter+tolerance) / motor_shaft_diameter;
    scale([s,s,s])
    translate([0,center_y_displacement,-9.5+extra_z_translation+extra_extra_z_translation]) // center to shaft
    {
        scale([10, 10, 10]) // scale to mm
        {
            import("28BYJ-48/StepMotorModel.stl");
        }
    }
    
    if (extrude_screws_and_cable)
    {
        extrusion_screw_diameter = 4.1;
        extrusion_screw_length = 30;
        for (x = [18.3,-18.3])
        {
            translate([x,center_y_displacement,-extrusion_screw_length/2])
            cylinder(h=extrusion_screw_length, d = extrusion_screw_diameter,$fn=50);
        }
        
        translate([0,35,-8])
        cube([10,20,16+tolerance],center=true);
    }
}

module extruded_motor(tolerance)
{
union()
{
stepper_motor_28BYJ_48(true,true,true,tolerance);

translate([0,0,12])
difference()
{
    stepper_motor_28BYJ_48(true,true,true,tolerance);
    translate([0,-7,0])
    cube(50,center=true);
}
}
}


extruded_motor(0.2);