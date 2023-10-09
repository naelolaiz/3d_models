
module mini_momentary_switch()
{
     size = [3.9, 3, 2.1];
     translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}

module mini_dip_switch_4()
{
    size = [6.7, 5.5, 2.6];
    translate([-size[0]/2,
               size[1]/2,
               size[2]/2])
    cube(size,center=true);
}
    
module header_1x3_pin()
{
     size = [8, 2.4, 8.1];
     translate([0,
               0,
               size[2]/2])
     cube(size,center=true);   
}
module header_2x5_pin()
{
    size = [12.9, 5, 8.1];
    translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}
module header_1x10_pin()
{
    size = [25.4, 2.4, 8.1];
    translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}

module header_1x6_pin()
{
    size = [15.1, 2.4, 8.1];
    translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}
module daughter_pcb(pcb_daugther_size)
{
    $fn=100;
    union()
    {
        color("springgreen",1)
        translate([pcb_daugther_size[0]/2,
                   -pcb_daugther_size[1]/2,
                   -pcb_daugther_size[2]/2])
        cube(pcb_daugther_size, center=true);
    
        // jp2
        color("black",1)
        translate([18,
                   9 - pcb_daugther_size[1],
                   0])
        header_1x3_pin();
        
        
        // btn1
        color("grey", 1)
        translate([pcb_daugther_size[0] - 3.7,
                   5.6 - pcb_daugther_size[1],
                   0])
        rotate([0,0,90])
        mini_momentary_switch();
        
        // btn2
        color("grey", 1)
        translate([pcb_daugther_size[0] - 3.7,
                   18.8 - pcb_daugther_size[1],
                   0])
        rotate([0,0,90])
        mini_momentary_switch();
        
        
        // sw1
        translate([pcb_daugther_size[0]-3,
                   0,
                   0])
        rotate([0,0,90])
        mini_dip_switch_4();
    }
}


module pcb(pcb_size, holes_distance_to_border, holes_diameter) {
    //holes_distance_to_border = 4.5;
    //holes_diameter = 3.3;    
    epsilon = 0.2;
   
    $fn=100;
    union()
    {
        translate([0,0,-pcb_size[2]/2])
        difference(){
        // main PCB
        color("green",1)
        cube(pcb_size,center=true);
        
        // 4 corner holes
        translate([pcb_size[0]/2 - holes_distance_to_border,
                   pcb_size[1]/2 - holes_distance_to_border,
                   0])
        cylinder(h=pcb_size[2], d=holes_diameter, center=true);
        
        translate([holes_distance_to_border - pcb_size[0]/2,
                   holes_distance_to_border - pcb_size[1]/2,
                   0])
        cylinder(h=pcb_size[2], d=holes_diameter, center=true);
        
        translate([pcb_size[0]/2 - holes_distance_to_border,
                   holes_distance_to_border - pcb_size[1]/2,
                   0])
        cylinder(h=pcb_size[2], d=holes_diameter, center=true);
        
        translate([holes_distance_to_border - pcb_size[0]/2,
                   pcb_size[1]/2 - holes_distance_to_border,
                   0])
        cylinder(h=pcb_size[2], d=holes_diameter, center=true);
    }
    
    // add jacks
    jack_size = [14, 6.3, 5.8];
    jack_inner_length = 11.2;
        
    hpout01_jack_distance_to_border = 17;
    hpout23_jack_distance_to_border = 19.1;
    linein01_jack_distance_to_border = 22;
    
    // HP out 0/1
    color("black", 1)
    translate([pcb_size[0]/2 - jack_size[0]/2 + (jack_size[0]-jack_inner_length),
    hpout01_jack_distance_to_border - pcb_size[1]/2,
    jack_size[2]/2])
    cube(jack_size, center=true);
    
    // HP out 2/3
    color("yellow", 1)
    translate([pcb_size[0]/2 - jack_size[0]/2 + (jack_size[0]-jack_inner_length),
    pcb_size[1]/2 - hpout23_jack_distance_to_border,
    jack_size[2]/2])
    cube(jack_size, center=true);
    
    // line in 0/1
    color("hotpink", 1)
    translate([pcb_size[0]/2 - linein01_jack_distance_to_border,
        pcb_size[1]/2 - jack_size[0]/2 + (jack_size[0]-jack_inner_length),
        jack_size[2]/2])
    rotate([0,0,90])
    cube(jack_size, center=true);
   
   // USB-C connector
    usbc_distance_to_border = 16.2;
    usbc_size = [10, 6.8, 4.3];
    
    color("lightgray", 1)
    translate([(usbc_size[0] - pcb_size[0])/2,
               pcb_size[1]/2 - usbc_distance_to_border,
              usbc_size[2]/2])
    cube(usbc_size, center=true);
    
    // headers
    j41_3p_center_distance_to_border = [15.4, 5.8];
    j61_3p_center_distance_to_border = [15.4, hpout23_jack_distance_to_border];
    j51_3p_center_distance_to_border = [15.4, pcb_size[1] - hpout01_jack_distance_to_border];
    
    // j41
    color("hotpink", 1)
    translate([pcb_size[0]/2 - j41_3p_center_distance_to_border[0],
               pcb_size[1]/2 - j41_3p_center_distance_to_border[1],
               0])
    rotate([0,0,90])
    header_1x3_pin();
   
    // j61
    color("yellow", 1)
    translate([pcb_size[0]/2 - j61_3p_center_distance_to_border[0],
               pcb_size[1]/2 - j61_3p_center_distance_to_border[1],
               0])
    rotate([0,0,90])
    header_1x3_pin();
    
    // j51
    color("black", 1)
    translate([pcb_size[0]/2 - j51_3p_center_distance_to_border[0],
               pcb_size[1]/2 - j51_3p_center_distance_to_border[1],
               0])
    rotate([0,0,90])
    header_1x3_pin();
    
    // j1
    j1_center_distance_to_border = [32.8,3.6];
    color("black",1)
    translate([j1_center_distance_to_border[1]-pcb_size[0]/2,
               pcb_size[1]/2 - j1_center_distance_to_border[0],
               0])
    rotate([0,0,90])
    header_2x5_pin();
    
    // j2
    j2_center_distance_to_border = [26.8, 1.9];
    color("black",1)
    translate([j2_center_distance_to_border[0] - pcb_size[0]/2,
               pcb_size[1]/2 - j2_center_distance_to_border[1],
               0])
    header_1x10_pin();
    
    // j3
    j3_center_distance_to_border = [33.4, 1.7];
    color("black",1)
    translate([j3_center_distance_to_border[0] - pcb_size[0]/2,
               j3_center_distance_to_border[1] - pcb_size[1]/2,
               0])
    header_1x6_pin();
    
    pcb_daugther_size = [52 , 37.1, 1.5];
    pcb_daugther_distance_to_border = [11.6, 9.5, 10.65];
    translate([pcb_daugther_distance_to_border[0] - pcb_size[0]/2,
               pcb_size[1]/2 - pcb_daugther_distance_to_border[1],
               pcb_daugther_distance_to_border[2] + pcb_size[2]])
    daughter_pcb(pcb_daugther_size);
}
}

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
                  inner_size[2]];
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
//translate([100,100,100])
//pcb(pcb_size, holes_distance_to_border_pcb, holes_diameter);


//difference()
//{
    //box_bottom([pcb_size[0]+3,pcb_size[1]+3,23]);
    margin_xy = 4;
    wall_width = 2;

    holes_distance_to_border_case_bottom = holes_distance_to_border_pcb + margin_xy;

    // external size = internal + wall_width * 2
    bottom_box_internal_size = [pcb_size[0] + margin_xy*2,
                                pcb_size[1] + margin_xy*2,
                                6];

    translate([0,0,pcb_size[2] - bottom_box_internal_size[2]] )
    box_bottom(bottom_box_internal_size, wall_width, holes_distance_to_border_case_bottom, holes_diameter, margin_xy, pcb_size[2]);
   //pcb(pcb_size, holes_distance_to_border_pcb, holes_diameter);
//}