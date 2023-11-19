//box_final_size= 126.48, 80.72,23.36
box_scale = [74.40, 42.49, 42.49];
rounded_corner_radius = 5;

module RoundedCube(cube_size = [40,40,40])//, rounded_corner_radius = 5)
{
    $fn=50;
    half_cube_size = cube_size/2;
    
    hull() {
        for (position=[half_cube_size, 
                       -half_cube_size, 
                       [half_cube_size[0],half_cube_size[1],-half_cube_size[2]],
                       [half_cube_size[0],-half_cube_size[1],-half_cube_size[2]],
                       [half_cube_size[0],-half_cube_size[1],half_cube_size[2]],
                       [-half_cube_size[0],half_cube_size[1],half_cube_size[2]],
                       [-half_cube_size[0],-half_cube_size[1],half_cube_size[2]],
                       [-half_cube_size[0],half_cube_size[1],-half_cube_size[2]]
        ])
        {
            translate(position)
            sphere(r=rounded_corner_radius);
        }
    }
}



module Tab(width, positions)
{
    $fn=50;
    hull() 
    {
        for (position=positions)
        {
            translate(position)
            sphere(d=width);
        }
    }
}
    
module Box(size, wall_width=6)
{
    tab_width = 35;
    tab_height = 17;
    tab_hole_tolerance = 1.6;
    
    union() 
    {
        difference() 
        {
            // main box
            RoundedCube(cube_size=size);
            s=[size[0]/2 - wall_width*2, size[1]-wall_width, size[2]];
            
            // half hole
            translate([s[0]/2 + wall_width*1.2,0,wall_width])
            RoundedCube(cube_size=s);
            
            // other half hole
            translate([-s[0]/2 - wall_width*1.2,0,wall_width])       
            RoundedCube(cube_size=s);
            
            // tab hole center
            Tab (width=tab_hole_tolerance + wall_width/3, positions= [[0,tab_width/2, -size[2]/2 - rounded_corner_radius],
                                                [0,tab_width/2,  -size[2]/2 + tab_height + rounded_corner_radius+tab_hole_tolerance],
                                                [0,-tab_width/2, -size[2]/2 - rounded_corner_radius],
                                                [0,-tab_width/2, -size[2]/2 + tab_height + rounded_corner_radius+tab_hole_tolerance]]);
        }
        // tab center
        Tab (width=wall_width/3, positions= [[0,tab_width/2,size[2]/2],
                                            [0,tab_width/2,size[2]/2 + tab_height + rounded_corner_radius],
                                            [0,-tab_width/2,size[2]/2],
                                            [0,-tab_width/2,size[2]/2+tab_height + rounded_corner_radius]]);

    }
}
scale(box_scale)
Box([160,180,35]);