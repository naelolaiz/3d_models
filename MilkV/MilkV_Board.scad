pcb_size=[51.2,
          21,
          1];

usb_connector_size=[8.8,
                    7,
                    1.2];

SPI_connector_size = [12.3,
                      2,
                      4];

tolerance = 0.3;


translate([12.5+SPI_connector_size[1]/2-pcb_size[0]/2,0,0])
    rotate([0,0,90])
        cube(SPI_connector_size,center=true);

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

module milkv_board(pcb_size, usb_connector_size, tolerance=0, extrude=false)
{
    pcb(pcb_size, "pink", tolerance);
    translate([usb_connector_size[0]/2-pcb_size[0]/2,0,0])
    usb_connector(usb_connector_size, "gray", tolerance, extrude);
}

milkv_board(pcb_size, usb_connector_size, tolerance=tolerance, extrude=false);
