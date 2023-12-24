use <I7PY-Q202-03.scad>
module epson_stepper_motor_template()
{
    $fn=70;
    tolerance=1;
    shaft_diameter = 25;
    shaft_height = 20;

    screw_hole_diameter = 3;
    screw_holes_distance = 42.5;
    cables_hole_radius = 4;

    cylinder(h=shaft_height,d=shaft_diameter+tolerance, center=true);

    translate([0,-shaft_diameter/2,0])
    cylinder(h=shaft_height, r=cables_hole_radius, center=true);
    for (x = [-1, 1])
    {
        translate([x * screw_holes_distance/2,0,0])
        cylinder(h=shaft_height, d=screw_hole_diameter, center=true);
    }
}

epson_stepper_motor_template();
