use <DSP_ADAU1401_PCB.scad>;
use <DSP_ADAU1401_PCB_case_bottom.scad>;
include <common.scad>;

module box_top_without_holes()
{
    holes_distance_to_border = holes_distance_to_border_pcb + margin_xy;
    outer_size = [top_box_internal_size[0]+wall_width*2,
                  top_box_internal_size[1]+wall_width*2,
                  top_box_internal_size[2]];//+wall_width];
    epsilon=0.4;
    new_holes_diameter = holes_diameter - epsilon;
    max_distance_to_border = wall_width + margin_xy + holes_distance_to_border + holes_diameter * 2;
    
    rotate([0,180,0])
    translate([0,0,top_box_internal_size[2]])
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
            cube([top_box_internal_size[0] - max_distance_to_border,
                  top_box_internal_size[1] ,
                  top_box_internal_size[2]],
                 center=true);            
            translate([0,0,wall_width])
            cube([top_box_internal_size[0],
                  top_box_internal_size[1] - max_distance_to_border,
                  top_box_internal_size[2]],
                 center=true);
            
            
            //color("blue",1)
            
            /*
            translate([0,0, top_box_internal_size[2]/2])
            cube([top_box_internal_size[0],
                  top_box_internal_size[1],
                  pcb_height*2],
                 center=true);*/
        
        // support through-hole pins
        pins_height = 10;
        pins_height_1 = pcb_size[2]+epsilon;
        pins_d1 = 4;
        pins_d2 = 2.5;
        
        translate([holes_distance_to_border - top_box_internal_size[0]/2,
                   top_box_internal_size[1]/2 - holes_distance_to_border,
                   pins_height_1*2])
        cylinder(h=top_box_internal_size[2], d=pins_d2+epsilon, center=true, $fn=100);

        translate([top_box_internal_size[0]/2 - holes_distance_to_border,
                   top_box_internal_size[1]/2 - holes_distance_to_border,
                   pins_height_1*2])
        cylinder(h=top_box_internal_size[2], d=pins_d2+epsilon, center=true, $fn=100);

        translate([holes_distance_to_border - top_box_internal_size[0]/2,
                   holes_distance_to_border - top_box_internal_size[1]/2,
                   pins_height_1*2])
        cylinder(h=top_box_internal_size[2], d=pins_d2+epsilon, center=true, $fn=100);

        translate([top_box_internal_size[0]/2 - holes_distance_to_border,
                   holes_distance_to_border - top_box_internal_size[1]/2,
                   pins_height_1*2])
        cylinder(h=top_box_internal_size[2], d=pins_d2+epsilon, center=true, $fn=100);        
        }
    }
}

module box_top()
{
    difference()
    {
        translate([0,0,top_box_internal_size[2]/2 + bottom_box_internal_size[2] + wall_width])
        box_top_without_holes();
        control_components_margin = [3,3,100];
        translate([0,0,-wall_width-pcb_size[2]/2])
        pcb(control_components_margin);
    }
}   
rotate([0,180,0])
box_top();
