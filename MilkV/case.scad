include <common.scad>;
use <MilkV_Board.scad>;
use <GC2083.scad>;




case_width = 1.28;
case_bottom_plane_size = milkv_pcb_size + [10, 10, case_width];

translate([0,
           0,
           -case_bottom_plane_size[2]/2 - gc2083_pcb_size[2] - 3])
    cube(case_bottom_plane_size, center=true);

milkv_board(milkv_pcb_size, usb_connector_size, milkv_SPI_connector_size, tolerance=tolerance, extrude=true);