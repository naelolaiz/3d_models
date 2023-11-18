module Motor()
{
    $fn=300;
    screws_distance = 15.9;
    holes_diameter=2.5;
    motor_case_top_small_circle_diameter = 10;
    motor_case_top_small_circle_height = 1.5;
    output_shaft_diameter = 2.5;
    output_shaft_height = 8;
    motor_cap_diameter = 7.1;
    motor_cap_gap = 1.3;
    motor_cap_height = output_shaft_height - motor_cap_gap;
    motor_diameter = 27.6;
    motor_height = 37.7;
  
    module MainBody()
    {
    // main cylinder
    color("gray")
    cylinder (h=motor_height, d=motor_diameter,center=true);
    
    // smaller cylinder on top
    color("gray")
    translate([0,0,(motor_height+motor_case_top_small_circle_height)/2])
    cylinder (h=motor_case_top_small_circle_height, d=motor_case_top_small_circle_diameter,center=true);
    
    // output_shaft
    color("gray")
    translate([0,0,(motor_height+output_shaft_height)/2+motor_case_top_small_circle_height])
    cylinder (h=output_shaft_height, d=output_shaft_diameter,center=true);
    }
    
    difference()
    {
        MainBody();
        // holes for screws
        for (position = [[screws_distance/2, 0, motor_height/2], [-screws_distance/2, 0, motor_height/2]])
        {
            translate(position)
            cylinder(h=20, d=holes_diameter, center=true);
        }
    }
    translate([0,0,motor_case_top_small_circle_height + motor_cap_gap + (motor_cap_height + motor_height)/2])
    cylinder(h=motor_cap_height,d=motor_cap_diameter,center=true);
    
}

Motor();