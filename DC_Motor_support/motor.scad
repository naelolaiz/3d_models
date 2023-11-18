module Motor()
{
    $fn=300;
    screws_distance = 15.9;
    holes_diameter=2.5;
    
    motor_case_top_small_circle_diameter = 10;
    motor_case_top_small_circle_height = 1.5;
    motor_case_bottom_small_circle_diameter = motor_case_top_small_circle_diameter;
    motor_case_bottom_small_circle_height = 2;
    motor_diameter = 27.6;
    motor_height = 37.7;
    body_outer_shell_diameter = 28.8;
    body_outer_shell_height = 20; 
    body_outer_shell_distance_to_top = 4.4; // 24.4 - 20 = 4.4
    
    output_shaft_diameter = 2.5;
    output_shaft_height = 8;
    
    
    motor_cap_diameter = 7.1;
    motor_cap_gap = 1.3;
    motor_cap_height = output_shaft_height - motor_cap_gap;

    
    connectors_distance = 23.6;
    connectors_diameter=1.8;
    connectors_height = 2.2;
  
    module MainBody()
    {
    // main cylinder
    color("gray")
    cylinder (h=motor_height, d=motor_diameter,center=true);

    // outer shell cylinder
    translate([0,0,(motor_height-body_outer_shell_height)/2 - body_outer_shell_distance_to_top])
    color("blue")
    cylinder (h=body_outer_shell_height, d=body_outer_shell_diameter,center=true);
    
    // smaller cylinder on top and on bottom
    for(d_h_s= [[motor_case_top_small_circle_diameter, motor_case_top_small_circle_height, 1],[motor_case_bottom_small_circle_diameter,motor_case_bottom_small_circle_height, -1]]) 
    {
        color("gray")
        translate([0,0, d_h_s[2]*(motor_height + d_h_s[1])/2])
        cylinder (h=d_h_s[1], d=d_h_s[0],center=true);
    }
    
    // output_shaft
    color("gray")
    translate([0,0,(motor_height+output_shaft_height)/2+motor_case_top_small_circle_height])
    cylinder (h=output_shaft_height, d=output_shaft_diameter,center=true);
    }
    // connectors
    for (position_color = [[[connectors_distance/2, 0, -(motor_height+connectors_height)/2],"red"], [[-connectors_distance/2, 0, -(motor_height+connectors_height)/2],"black"]])
    {
        color(position_color[1])
        translate(position_color[0])
        cylinder(h=connectors_height, d=connectors_diameter, center=true);
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

rotate([70,0,0])
translate([-20,0,0])
Motor();


rotate([-70,0,0])
translate([20,0,0])
Motor();