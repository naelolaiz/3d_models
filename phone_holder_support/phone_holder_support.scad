$fn=300;

create_final_holder = false;


phone_holder_dimensions_mm = [30,80,20];
phone_holder_inner_size_mm = [50,60,15];


screw_threads_mm = 5;
screw_head_height_mm = 5;
screw_head_diameter_mm = 18;
threads_outside_length_mm = 6;


screw_total_height_mm = threads_outside_length_mm + screw_head_height_mm + phone_holder_dimensions_mm[2]-phone_holder_inner_size_mm[2];

hole_diameter_mm = screw_threads_mm+1;


module screw(total_height_mm, threads_mm, head_height_mm, head_diameter_mm)
{
    color("white",1.0)
    union()
    {
        cylinder(h=total_height_mm, d=threads_mm);
        cylinder(h=head_height_mm, d=head_diameter_mm);
    }
}


module phone_holder(outer_size, inner_size, hole_diameter_mm)
{
    hole_length=2*(outer_size[2]-inner_size[2]);
    
    
    {
        difference()
        {
            color("black",1.0)
            difference()
            {
                // holder
                translate([0,0,outer_size[2]/2])
                {
                    cube(outer_size, center=true);
                }
                translate([0,0,phone_holder_inner_size_mm[2]/2+
                phone_holder_dimensions_mm[2]-phone_holder_inner_size_mm[2]])
                {
                    cube(inner_size,center=true);
                }
            }
            {
                translate([0,0,hole_length/2])
                {
                    cylinder(h=hole_length, d=hole_diameter_mm, center=true);
                }
            }
        }
    }
}

module holder_and_screw()
{
    
    phone_holder(phone_holder_dimensions_mm, phone_holder_inner_size_mm, hole_diameter_mm);
    translate([0,0,-(screw_head_height_mm+threads_outside_length_mm)])
    {
    //   screw(screw_total_height_mm, screw_threads_mm, screw_head_height_mm, screw_head_diameter_mm);
    }
    translate([0,0,-(threads_outside_length_mm + screw_head_height_mm)/2])
    {
        cylinder(h=threads_outside_length_mm + screw_head_height_mm, d = screw_head_diameter_mm + 10, center=true);
    }
}

holder_and_screw();



base_height = screw_total_height_mm;

base_whole_cube_size = [phone_holder_dimensions_mm[0]*4, phone_holder_dimensions_mm[1], base_height];

module base(base_size)
{
    translate([0,50,0])
    translate([0,0,-base_size[2]/2])
    cube(base_size, center=true);
}

translate([0,0,phone_holder_dimensions_mm[2]-phone_holder_inner_size_mm[2]])
{
    base(base_whole_cube_size);
}