include <common.scad>;


body_depth = 1.7; // Depth of the connector body
module header_male(pin_count, body_depth)
{
    // Parameters
    pin_height = 11.5; // Total height of the pin
    pin_width = 0.64; // Width of the pin
    pin_depth = 0.64; // Depth of the pin
    body_height = 2.5; // Height of the connector body
    pitch = 2.54; // Distance between pins center to center
    single_unit_width = pitch; // Width of a single unit, based on pitch
    //body_depth = 1.7; // Depth of the connector body

    // Single Unit Module (One Pin + Part of Body)
    module single_unit() {
        // Pin
        color("gray")
            translate([0, 0, body_height])
                rotate([0,0,45])      
                    cylinder(h = pin_height - body_height, r = pin_width / 2, $fn = 4, center = true);
        
        // Body Part
        color("black")
            translate([0, 0, body_height / 2])
                cube([single_unit_width, body_depth, body_height], center = true);
    }

    for (i = [0:pin_count-1]) {
        translate([pitch * i - ((pin_count-1) * pitch) / 2, 0, 0]) single_unit();
    }
}




module pcb(size, color, tolerance = 0)
{
    color(color)
    {
        translate([0,0,-size[2]/2])
        {
            cube(size,center=true);
        }
    }
}

module usb_connector(size, color, tolerance = 0, extrude=false)
{
    extrude_size = extrude ? 30 : 0;
    color(color)
    {
        translate([0,0,size[2]/2])
        {
            cube(size+[extrude_size,tolerance,tolerance],center=true);
        }
    }
}

module micro_sd_reader_with_sd()
{   
    rotate([0,0,90])   
    {
        translate([-5.5,-8.3,0])
        {
            union()
            {
                color("orange")
                    union()
                    {
                        cube([9.5,13,0.5]);
                        cube([11,8,0.5]);
                        cube([11,1.7,1.3]);
                    }
                    
                color("gray")
                {
                    translate([-1, 8.3, 0])
                    {
                        cube([11,6,1]);
                    }
                }
            }
        }
    }
}

module milkv_board(pcb_size, usb_connector_size, SPI_connector_size, tolerance=0, extrude=false)
{
    // pcb
    pcb(pcb_size, "pink", tolerance);

    // usb connector
    translate([usb_connector_size[0]/2-pcb_size[0]/2,0,0])
        usb_connector(usb_connector_size, "gray", tolerance, extrude);
    
    // spi connector
    extrusion_height=3;
    color("white")
        translate([12.5 + SPI_connector_size[1]/2-pcb_size[0]/2,
                   0,
                   2 + (extrude ? extrusion_height/2 : 0)])
            rotate([0,
                    0,
                    90])
                cube(SPI_connector_size + (extrude ? [0,0,extrusion_height] : [0,0,0]) ,center=true);
   
    // pins
    translate([0,pcb_size[1]/2 -body_depth/2 ,0])
        header_male(20, body_depth);
    translate([0,body_depth/2-pcb_size[1]/2,0])
        header_male(20, body_depth);

    // micro sd    
    translate([15.5, 0, 0])
        micro_sd_reader_with_sd();
        
        
     // SoC
     
     color("black")
        translate([1.6,0,0.5])
            cube(size=[9,9,1], center=true);
}

milkv_board(milkv_pcb_size, usb_connector_size, milkv_SPI_connector_size, tolerance=tolerance, extrude=false);
