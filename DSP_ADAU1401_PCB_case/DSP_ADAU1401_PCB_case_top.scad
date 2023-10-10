use <DSP_ADAU1401_PCB.scad>;
use <DSP_ADAU1401_PCB_case_bottom.scad>;

module box_top(inner_size, wall_width, holes_distance_to_border, holes_diameter, margin_xy, pcb_height)
{
    outer_size = [inner_size[0]+wall_width*2,
                  inner_size[1]+wall_width*2,
                  inner_size[2]+wall_width];
    epsilon=0.4;
    new_holes_diameter = holes_diameter - epsilon;
    max_distance_to_border = wall_width + margin_xy + holes_distance_to_border + holes_diameter * 2;
    
    rotate([0,180,0])
    translate([0,0,inner_size[2]])
    translate([0,
               0,
               - wall_width - outer_size[2]/2 ])
    union()
    {
        difference()
        {
            // external cube
            //color("blue",1)
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
            
            
            //color("blue",1)
            /*translate([0,0, inner_size[2]/2])
            cube([inner_size[0],
                  inner_size[1],
                  pcb_height*2],
                 center=true);*/
        
        // support through-hole pins
        pins_height = 10;
        pins_height_1 = pcb_height+epsilon;
        pins_d1 = 4;
        pins_d2 = 2.5;
        
        translate([holes_distance_to_border - inner_size[0]/2,
                   inner_size[1]/2 - holes_distance_to_border,
                   pins_height_1*2])
        cylinder(h=inner_size[2], d=pins_d2+epsilon, center=true, $fn=100);

        translate([inner_size[0]/2 - holes_distance_to_border,
                   inner_size[1]/2 - holes_distance_to_border,
                   pins_height_1*2])
        cylinder(h=inner_size[2], d=pins_d2+epsilon, center=true, $fn=100);

        translate([holes_distance_to_border - inner_size[0]/2,
                   holes_distance_to_border - inner_size[1]/2,
                   pins_height_1*2])
        cylinder(h=inner_size[2], d=pins_d2+epsilon, center=true, $fn=100);

        translate([inner_size[0]/2 - holes_distance_to_border,
                   holes_distance_to_border - inner_size[1]/2,
                   pins_height_1*2])
        cylinder(h=inner_size[2], d=pins_d2+epsilon, center=true, $fn=100);        
        }
        
/*
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
        support_pin(pins_height, pins_height_1, pins_d1, pins_d2);*/
    }
}



// TODO: make a module to reuse in ALL!!
holes_distance_to_border_pcb = 3.8;
holes_diameter = 3.4;
pcb_size = [86.7, 51.6, 1.5 ];

    margin_xy = 4;
    wall_width = 2;

    holes_distance_to_border_case_bottom = holes_distance_to_border_pcb + margin_xy;
    bottom_box_internal_size = [pcb_size[0] + margin_xy*2,
                                pcb_size[1] + margin_xy*2,
                                6];

    //translate([0,0,pcb_size[2] - bottom_box_internal_size[2]] )
   // box_bottom(bottom_box_internal_size, wall_width, holes_distance_to_border_case_bottom, holes_diameter, margin_xy, pcb_size[2]);
    
    top_box_internal_size = [bottom_box_internal_size[0],
                             bottom_box_internal_size[1],
                             25];


    rotate([0,180,0])
    difference()
    {
        box_top(top_box_internal_size, wall_width, holes_distance_to_border_case_bottom, holes_diameter, margin_xy, pcb_size[2]);
        control_components_margin = [10,10,1000];
        pcb(pcb_size, holes_distance_to_border_pcb, holes_diameter, control_components_margin);
    }
