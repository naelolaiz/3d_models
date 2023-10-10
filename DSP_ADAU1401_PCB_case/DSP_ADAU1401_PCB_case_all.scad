use <DSP_ADAU1401_PCB.scad>;
use <DSP_ADAU1401_PCB_case_bottom.scad>;
use <DSP_ADAU1401_PCB_case_top.scad>;
include <common.scad>;
//rotate([0,180,0])

translate([0,0,top_box_internal_size[2]/2 + bottom_box_internal_size[2] + wall_width])
box_top();
pcb([0,0,0]);
translate([0,0,-pcb_size[2] - bottom_box_internal_size[2]-1]) // check... why -1? calculations are wrong
box_bottom();
