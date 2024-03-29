include <common.scad>;

module top_screw(diameter, height, tolerance=0)
{
    rotate([-90,0,0])
        translate([0,0,height/2])
            difference()
            {
                cylinder(h=height, d=diameter+tolerance,center=true,$fn=100);
                translate([0,0,height/2])
                    cube([diameter/2,0.2,height/2],center=true);
                translate([0,0,height/2])
                    rotate([0,0,90])
                        cube([diameter/2,0.2,height/2],center=true);
            }
}

module pcb_holes(tolerance = 0)
{
    for ( pos =  [ [-pcb_holes_outside_distance[0]/2, pcb_holes_outside_distance[1]/2, -gc2083_pcb_size[2]/2], [ pcb_holes_outside_distance[0]/2, -pcb_holes_outside_distance[1]/2, -gc2083_pcb_size[2]/2 ] ] )
    {
        translate(pos)
        cylinder(h=holes_height, d=pcb_holes_outside_diameter+tolerance, center=true, $fn=50);  
    }
}

module pcb(size, tolerance=0)
{
    color("green")
    union()
    {
        difference()
        {
            // back plate
            translate([0, 0, -size[2]/2])
            {
                cube(gc2083_pcb_size, center=true);
            }
            pcb_holes(tolerance=tolerance);
        }
    }
}
module holes_inside(tolerance = 0)
{
    for ( pos =  [ [-holes_inside_distance[0]/2, holes_inside_distance[1]/2, -gc2083_pcb_size[2]/2], [ holes_inside_distance[0]/2, -holes_inside_distance[1]/2, -gc2083_pcb_size[2]/2 ] ] )
    {
        translate(pos)
        cylinder(h=holes_height, d=holes_inside_diameter+tolerance, center=true, $fn=50);  
    }
}


module semi_cylinder(center_plate_size, tolerance = 0)
{
    semi_cylinder_diameter = 4.5 + tolerance;
    semi_cylinder_height = center_plate_size[2];
    translate([0,0,semi_cylinder_height/2])
    difference()
    {
        translate([0,0,0])
        cylinder(h=semi_cylinder_height,d=semi_cylinder_diameter, center=true,  $fn=80);
        translate([-semi_cylinder_diameter/2,0,0])
        cube([semi_cylinder_diameter, semi_cylinder_diameter, semi_cylinder_height],center=true);
    }
}



module center_plate(center_plate_size, tolerance=0)
{
    color("black")
    difference()
    {
        union()
        {
            translate([0,0,center_plate_size[2]/2])
            cube(center_plate_size,center=true);

            center_plate_rect_size = [center_plate_size[0]+1.8*2,4.5+tolerance,center_plate_size[2]];
            translate([0,0,center_plate_rect_size[2]/2])
            cube(center_plate_rect_size,center=true);

            translate([center_plate_rect_size[0]/2,0,0])
            semi_cylinder(center_plate_size=center_plate_size,tolerance=tolerance);

            translate([-center_plate_rect_size[0]/2,0,0])
            rotate([0,0,180])
            semi_cylinder(center_plate_size=center_plate_size,tolerance=tolerance);
        }
        holes_inside();
    }
}
module lens(center_plate_size,
            lens_diameter,
            lens_height,
            tolerance=0)
{
    color("gray")
    translate([0,0,center_plate_size[2]+lens_height/2])
    cylinder(h=lens_height, d=lens_diameter+tolerance, center=true, $fn=100);
}

module top_box_and_screw(top_screw_height, top_screw_diameter, top_screw_box_size, top_screw_pos_z,lens_diameter, tolerance=0)
{
    color("gray")   
    {
        translate([0,
                   top_screw_box_size[0]/2+lens_diameter/2,
                   0.1+top_screw_pos_z-top_screw_box_size[1]/4])
            rotate([90,0,90])
                cube(top_screw_box_size,center=true);
    }
    color("black")
    {
        translate([0,lens_diameter/2,top_screw_pos_z])
            top_screw(diameter=top_screw_diameter,height=top_screw_height, tolerance=tolerance);
     }
}

module camera(extrude=false, tolerance=0)
{
    pcb(gc2083_pcb_size,
        tolerance=tolerance);

    center_plate(center_plate_size=center_plate_size,
                 tolerance=tolerance);

    lens(center_plate_size=center_plate_size,
                lens_diameter=lens_diameter,
                lens_height=lens_height,
                tolerance=tolerance);
  
    top_box_and_screw(top_screw_height=top_screw_height, top_screw_diameter=            top_screw_diameter, top_screw_box_size=top_screw_box_size, top_screw_pos_z=top_screw_pos_z, lens_diameter=lens_diameter, tolerance=tolerance);
    
    if (extrude)
    {   
        //pcb_holes(tolerance=tolerance);
        holes_inside(tolerance=tolerance);
    }
    
    module back(gc2083_pcb_size, spi_connector_size, tolerance=0)
    {
        color("white")
            translate([0,
                       spi_connector_size[1]/2 - gc2083_pcb_size[1]/2-0.35,
                       -gc2083_pcb_size[2]-spi_connector_size[2]/2-tolerance/2])
                cube(spi_connector_size+[tolerance,tolerance,tolerance],center=true);
        
        for ( pos =  [ [holes_inside_distance[0]/2,0,-top_screw_height/2], [-holes_inside_distance[0]/2,0,-top_screw_height/2] ] )
            color("gray")
                translate(pos)
                    rotate([-90,0,0])
                        top_screw(diameter=top_screw_diameter, height=top_screw_height, tolerance=tolerance);
    }
    back(gc2083_pcb_size=gc2083_pcb_size, spi_connector_size=spi_connector_size, tolerance=tolerance);
}

camera(extrude=false, tolerance=tolerance);
