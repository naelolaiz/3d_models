module mini_momentary_switch(control_components_margin)
{
     size = [3.9, 3, 2.1] + control_components_margin;
     translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}

module mini_dip_switch_4(control_components_margin)
{
    size = [6.7, 5.5, 2.6] + control_components_margin;
    translate([-size[0]/2,
               size[1]/2,
               size[2]/2])
    cube(size,center=true);
}
    
module header_1x3_pin(control_components_margin)
{
     size = [8, 2.4, 8.1] + control_components_margin;
     translate([0,
               0,
               size[2]/2])
     cube(size,center=true);   
}
module header_2x5_pin(control_components_margin)
{
    size = [12.9, 5, 8.1] + control_components_margin;
    translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}
module header_1x10_pin(control_components_margin)
{
    size = [25.4, 2.4, 8.1] + control_components_margin;
    translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}

module header_1x6_pin(control_components_margin)
{
    size = [15.1, 2.4, 8.1] + control_components_margin;
    translate([0,
               0,
               size[2]/2])
    cube(size,center=true);
}
module daughter_pcb(pcb_daugther_size, control_components_margin)
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
                   ])
        header_1x3_pin(control_components_margin);
        
        
        // btn1
        color("grey", 1)
        translate([pcb_daugther_size[0] - 3.7,
                   5.6 - pcb_daugther_size[1],
                   0])
        rotate([0,0,90])
        mini_momentary_switch(control_components_margin);
        
        // btn2
        color("grey", 1)
        translate([pcb_daugther_size[0] - 3.7,
                   18.8 - pcb_daugther_size[1],
                   0])
        rotate([0,0,90])
        mini_momentary_switch(control_components_margin);
        
        
        // sw1
        translate([pcb_daugther_size[0]-3,
                   0,
                   0])
        rotate([0,0,90])
        mini_dip_switch_4(control_components_margin);
    }
}


module pcb(pcb_size, holes_distance_to_border, holes_diameter, control_components_margin) 
{
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
    header_1x3_pin(control_components_margin);
   
    // j61
    color("yellow", 1)
    translate([pcb_size[0]/2 - j61_3p_center_distance_to_border[0],
               pcb_size[1]/2 - j61_3p_center_distance_to_border[1],
               0])
    rotate([0,0,90])
    header_1x3_pin(control_components_margin);
    
    // j51
    color("black", 1)
    translate([pcb_size[0]/2 - j51_3p_center_distance_to_border[0],
               pcb_size[1]/2 - j51_3p_center_distance_to_border[1],
               0])
    rotate([0,0,90])
    header_1x3_pin(control_components_margin);
    
    // j1
    j1_center_distance_to_border = [32.8,3.6];
    color("black",1)
    translate([j1_center_distance_to_border[1]-pcb_size[0]/2,
               pcb_size[1]/2 - j1_center_distance_to_border[0],
               0])
    rotate([0,0,90])
    header_2x5_pin(control_components_margin);
    
    // j2
    j2_center_distance_to_border = [26.8, 1.9];
    color("black",1)
    translate([j2_center_distance_to_border[0] - pcb_size[0]/2,
               pcb_size[1]/2 - j2_center_distance_to_border[1],
               0])
    header_1x10_pin(control_components_margin);
    
    // j3
    j3_center_distance_to_border = [33.4, 1.7];
    color("black",1)
    translate([j3_center_distance_to_border[0] - pcb_size[0]/2,
               j3_center_distance_to_border[1] - pcb_size[1]/2,
               0])
    header_1x6_pin(control_components_margin);
    
    pcb_daugther_size = [52 , 37.1, 1.5];
    pcb_daugther_distance_to_border = [11.6, 9.5, 10.65];
    translate([pcb_daugther_distance_to_border[0] - pcb_size[0]/2,
               pcb_size[1]/2 - pcb_daugther_distance_to_border[1],
               pcb_daugther_distance_to_border[2] + pcb_size[2]])
    daughter_pcb(pcb_daugther_size,control_components_margin);
}
}
holes_distance_to_border_pcb = 3.8;
holes_diameter = 3.4;
pcb_size = [86.7, 51.6, 1.5 ];
pcb(pcb_size, holes_distance_to_border_pcb, holes_diameter, [0,0,0]);