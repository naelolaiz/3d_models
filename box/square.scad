//cube([200,150,35],center=true);
//size = 40; // Size of the square
//radius = 5; // Radius of the rounded corners


module RoundedCube(cube_size = [40,40,40], rounded_corner_radius = 5)
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

module Box(size)
{
    wall_width=6;
    difference() {
    RoundedCube(cube_size=size);
    s=[size[0]/2 - wall_width*2, size[1]-wall_width,size[2]];
    translate([s[0]/2 + wall_width,0,wall_width])       
    RoundedCube(cube_size=s);
    translate([-s[0]/2 - wall_width,0,wall_width])       
    RoundedCube(cube_size=s);
    }
}

Box([160,180,35]);