ruler_width = 40;
ruler_length = 7;
original_ruler_height = 5;
steps = 8;

module plane_ruler(ruler_width,
                   ruler_length,
                   ruler_height)
{

    large_tick_length=ruler_length;
    short_tick_length=ruler_length-2;

    module tick(tick_length, tick_cube_side_length = 0.2)
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
                    tick(xPos%5==0 ? large_tick_length: short_tick_length);
                

            }
        }
        
        translate([-ruler_width/2, ruler_length/2, (ruler_height-original_ruler_height)/2])
        {
            for(xPos = [0:ruler_width])
            {
                // vertical ticks
                rotate([90,0,0])
                    translate([xPos,0,0])
                        tick(original_ruler_height);
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