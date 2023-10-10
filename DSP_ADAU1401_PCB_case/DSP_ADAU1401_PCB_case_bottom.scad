use <DSP_ADAU1401_PCB.scad>;

module support_pin(height_total, height_1, d1, d2)
{
        //pins_height = 20;
    union(){
        height_2 = height_total - height_1;
        translate([0,0, -height_1/2])
        cylinder(h=height_1, d=d1, center=true, $fn=100);
        translate([0,0, height_total/2 - height_1/2 ])
        cylinder(h=height_2, d=d2, center=true, $fn=100);
    }
}
module box_bottom(inner_size, wall_width, holes_distance_to_border, holes_diameter, margin_xy, pcb_height)
{
    outer_size = [inner_size[0]+wall_width*2,
                  inner_size[1]+wall_width*2,
                  inner_size[2]+wall_width];
    epsilon=0.2;
    new_holes_diameter = holes_diameter - epsilon;
    max_distance_to_border = wall_width + margin_xy + holes_distance_to_border + holes_diameter * 2;
    translate([0,
               0,
               outer_size[2]/2 - pcb_size[2]])
    union()
    {
        difference()
        {
            // external cube
            color("blue",1)
            cube(outer_size, center=true);

            // internal cubes (hole)
            // do it twice keeping corners for the support of the PCB
            translate([0,0,wall_width])
            cube([inner_size[0] - max_distance_to_border,
                  inner_size[1] ,
                  inner_size[2]],
                 center=true);            
            translate([0,0,wall_width])
            cube([inner_size[0],
                  inner_size[1] - max_distance_to_border,
                  inner_size[2]],
                 center=true);
            color("blue",1)
            translate([0,0,wall_width + pcb_height])
            cube([inner_size[0],
                  inner_size[1],
                  pcb_height*2],
                 center=true);
        }
        
        // support through-hole pins
        pins_height = 10;
        pins_height_1 = pcb_height+epsilon;
        pins_d1 = 4;
        pins_d2 = 2.5;      

        color("blue",1)
        translate([inner_size[0]/2 - holes_distance_to_border,
                   inner_size[1]/2 - holes_distance_to_border,
                   pins_height_1*2])
        support_pin(pins_height, pins_height_1, pins_d1, pins_d2);
        
        color("blue",1)
        translate([holes_distance_to_border - inner_size[0]/2,
                   inner_size[1]/2 - holes_distance_to_border,
                   pins_height_1*2])
        support_pin(pins_height, pins_height_1, pins_d1, pins_d2);

        color("blue",1)
        translate([inner_size[0]/2 - holes_distance_to_border,
                   holes_distance_to_border -inner_size[1]/2,
                   pins_height_1*2])
        support_pin(pins_height, pins_height_1, pins_d1, pins_d2);

        color("blue",1)
        translate([holes_distance_to_border - inner_size[0]/2,
                   holes_distance_to_border - inner_size[1]/2,
                   pins_height_1*2])
        support_pin(pins_height, pins_height_1, pins_d1, pins_d2);
    }
}


holes_distance_to_border_pcb = 3.8;
holes_diameter = 3.4;
pcb_size = [86.7, 51.6, 1.5 ];

    margin_xy = 4;
    wall_width = 2;

    holes_distance_to_border_case_bottom = holes_distance_to_border_pcb + margin_xy;
    // external size = internal + wall_width * 2
    bottom_box_internal_size = [pcb_size[0] + margin_xy*2,
                                pcb_size[1] + margin_xy*2,
                                6];

    translate([0,0,pcb_size[2] - bottom_box_internal_size[2]] )
    box_bottom(bottom_box_internal_size, wall_width, holes_distance_to_border_case_bottom, holes_diameter, margin_xy, pcb_size[2]);
