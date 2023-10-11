holes_distance_to_border_pcb = 3.8;
holes_diameter = 3.4;
pcb_size = [86.7, 51.6, 1.5 ];
margin_xy = 4;
wall_width = 2;
epsilon = 0.35;

holes_distance_to_border_case_bottom = holes_distance_to_border_pcb + margin_xy;

bottom_box_internal_size = [pcb_size[0] + margin_xy*2,
                            pcb_size[1] + margin_xy*2,
                            6];
                                      
top_box_internal_size = [bottom_box_internal_size[0],
                         bottom_box_internal_size[1],
                         25];