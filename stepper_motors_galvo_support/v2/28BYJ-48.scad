motor_shaft_diameter = 5;
module stepper_motor_28BYJ_48(include_big_axis_circle = true, tolerance = 0)
{
    extra_z_translation = include_big_axis_circle ? 0 : -1.1;
    s=(motor_shaft_diameter+tolerance) / motor_shaft_diameter;
    scale([s,s,s])
    translate([0,8,-9.5+extra_z_translation]) // center to shaft
    {
        scale([10, 10, 10]) // scale to mm
        {
            import("28BYJ-48/StepMotorModel.stl");
        }
    }
}
stepper_motor_28BYJ_48(false);