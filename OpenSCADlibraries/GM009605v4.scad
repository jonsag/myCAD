// GM009605v4 0.96"OLED screen

// dimensions:
// width: 25
// height: 27
// thickness: 1

// bottom tabs width: 5
// bottom tabs height: 2

// hole diameter: 3
// hole center from edges: 2.5

// glass width: 25
// glass height: 16.5
// glass upper edge to board edge: 5.5

// image to top edge: 6.5
// image to bottom edge: 9
// image to side edge: 1

// header center to top edge: 1.5

// screen height from board: 2, if you use a 3mm plexi sheet as cover, recessed 2mm, you will need 3mm height of the mounting posts


GM009605v4();

module GM009605v4() {
     include <openscad-rpi-library/misc_parts.scad>;

     x = 25; y = 27; z = 1.2; // pcb
     color([30/255, 114/255, 198/255])
          linear_extrude(height=z) {
          difference() {
	       square(size = [x, y]);
	       translate([2.5, 2.5])
	            circle(r=1.5, $fn=24);
	       translate([x-2.5, 2.5])
	            circle(r=1.5, $fn=24);
	       translate([2.5, y-2.5])
		    circle(r=1.5, $fn=24);
	       translate([x-2.5, y-2.5])
		    circle(r=1.5, $fn=24);
          }
     }

     gx=25; gy=16.5; gz=2;
     sx=23; sy=9.5; sz=2;

     color("gray")
     difference() {
	  translate([x/2-gx/2, y/2-gy/2, z])
	       cube(size=[gx, gy, gz]);
	  
	  translate([x/2-gx/2+(gx-sx)/2, y-6.5-sy, z])
	       cube(size=[sx, sy, sz]);
     }

     translate([x/2-gx/2+(gx-sx)/2, y-6.5-sy, z])
          color("black")
          cube(size=[sx, sy, gz]);
	  
     translate([x/2-2.54*2, y-1.5, 0]) // headers
          rotate(a=180, v=[1, 0, 0])
          pin_headers(4, 1);
}
