include <common.scad>;
use <MilkV_Board.scad>;
use <GC2083.scad>;


case_width = 1.28;
case_bottom_plane_size = milkv_pcb_size + [15, 10, case_width];



case_camera_side_plane_size = [milkv_pcb_size[1] + 5,
                               case_bottom_plane_size[1],
                               case_bottom_plane_size[2]];
                               
case_usb_side_plane_size = case_camera_side_plane_size;
support_bottom_usb_size = [7,
                           case_camera_side_plane_size[1]/3,
                           3];




difference()
{
    union()
    {
        // lens side
        translate([1.85+case_bottom_plane_size[0]/2,
                   0,
                   case_camera_side_plane_size[1]/2-8])
            rotate([0,90,0])
                cube(case_camera_side_plane_size,center=true);

        // bottom plane 
        translate([3,
                   0,
                   -case_bottom_plane_size[2]/2 - gc2083_pcb_size[2] - 3])
            cube(case_bottom_plane_size, center=true);
        

        // bottom plane - sides        
        translate([3,
                   case_bottom_plane_size[1]/2,
                   3.83+case_bottom_plane_size[2] + gc2083_pcb_size[2]])
            rotate([90,0,0])
                cube(case_bottom_plane_size-[0,4.2,0], center=true);
        translate([3,
                   -case_bottom_plane_size[1]/2,
                   3.83+case_bottom_plane_size[2] + gc2083_pcb_size[2]])
            rotate([90,0,0])
                cube(case_bottom_plane_size-[0,4.2,0], center=true);

                           
                           
// bottom support on USB side
        translate([-13-case_usb_side_plane_size[0]/2,
                   0,
                   -2.55])
            cube(support_bottom_usb_size,center=true);

// bottom support on USB side/2
        translate([-13-case_usb_side_plane_size[0]/2,
                   6.5,
                  1.8])
            cube([support_bottom_usb_size[0],
                  support_bottom_usb_size[1]/4,
                  support_bottom_usb_size[2]],
                 center=true);

        translate([-13-case_usb_side_plane_size[0]/2,
                   -6.5,
                  1.8])
            cube([support_bottom_usb_size[0],
                  support_bottom_usb_size[1]/4,
                  support_bottom_usb_size[2]],
                 center=true);



// bottom support on camera side            
        translate([12+case_usb_side_plane_size[0]/2,
                   0,
                   -2.55])
            cube(support_bottom_usb_size,center=true);            
            
            
        translate([-15.96-case_usb_side_plane_size[0]/2,
                   0,
                   case_usb_side_plane_size[1]/2-8])
            rotate([0,90,0])
                cube(case_usb_side_plane_size,center=true);




// top supports
        translate([-27,
                   0,
                   19])
            //cube(support_bottom_usb_size,center=true);
cube([support_bottom_usb_size[0]/4,case_bottom_plane_size[1],case_bottom_plane_size[2]/2],center=true);

        translate([33,
                   0,
                   19])
            //cube(support_bottom_usb_size,center=true);
cube([support_bottom_usb_size[0]/4,case_bottom_plane_size[1],case_bottom_plane_size[2]/2],center=true);

    }

    milkv_board(milkv_pcb_size, usb_connector_size, milkv_SPI_connector_size, tolerance=tolerance, extrude=true);


    translate([case_bottom_plane_size[0]/2-3,
               0,
               case_width+4])
        rotate([-90,0,-90])
            camera(extrude=true, tolerance=tolerance);
}



   milkv_board(milkv_pcb_size, usb_connector_size, milkv_SPI_connector_size, tolerance=tolerance, extrude=false);


    translate([case_bottom_plane_size[0]/2-3,
               0,
               case_width+4])
        rotate([-90,0,-90])
            camera(extrude=false, tolerance=tolerance);
