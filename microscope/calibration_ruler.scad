ruler_width = 35;
ruler_length = 7;
original_ruler_height = 5;
steps = 5;
large_vs_short_tich_ratio = 2/7;

module plane_ruler(ruler_width,
                   ruler_length,
                   ruler_height)
{
    module tick(tick_length,
                tick_cube_side_length = 0.33)
    {
        rotate([90,0,0])
            rotate([0,0,45])
                cube([tick_cube_side_length, tick_cube_side_length, tick_length],center=true);
    }

    difference()
    {
        cube([ruler_width,ruler_length,ruler_height], center=true);

        translate([-ruler_width/2, 0, ruler_height/2])
        {
            for(xPos = [0:ruler_width])
            {
                // horizontal ticks
                translate([xPos,0,0])
                    tick(xPos%5==0 ? ruler_length: ruler_length-ruler_length * large_vs_short_tich_ratio);
            }
        }
        
        translate([-ruler_width/2, ruler_length/2, (ruler_height-original_ruler_height)/2])
        {
            for(xPos = [0:ruler_width])
            {
                // vertical ticks
                rotate([90,0,0])
                    translate([xPos,0,0])
                        //tick(original_ruler_height);
                        tick(xPos%5==0 ? original_ruler_height: original_ruler_height - original_ruler_height * large_vs_short_tich_ratio);
            }
        }
         
    }
}

module ruler(steps,
             ruler_width=ruler_width,
             ruler_length=ruler_length,
             original_ruler_height=original_ruler_height)
{
    for(step = [0:steps-1])
    {
        stepHeight = original_ruler_height*(step+1);
        translate([0,
                   -step*ruler_length,
                   stepHeight/2])
            plane_ruler(ruler_width=ruler_width,
                        ruler_length=ruler_length,
                        ruler_height=stepHeight);
    }
}
ruler(steps=steps,
      ruler_width=ruler_width,
      ruler_length=ruler_length,
      original_ruler_height=original_ruler_height);