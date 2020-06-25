// puch_button.scad

//pushButton(3);

module pushButton(wallThickness) {
     union() {
	  translate([0, 0, 6.4 + 2.9 + 3.5 / 2]) // button top part
	       color("Blue")
	       cylinder(3.5, 2.9, 2.9, $fn = 100, center = true);
	  
	  translate([0, 0, 6.4 + 2.9 / 2]) // metallic part of button
	       color("LightGrey")
	       cylinder(2.9, 2.15, 2.15, $fn = 100, center = true);

	  translate([0, 0, wallThickness + 2 / 2]) // nut
	       color("LightGrey")
	       cylinder(2, 5.05, 5.05, $fn = 6, center = true);
	  
	  translate([0, 0, 6.4 / 2]) // threaded part
	       color("LightGrey")
	       cylinder(6.4, 3.4, 3.4, $fn = 100, center = true);
	  
	  translate([0, 0, - 1 / 2]) // spring washer, top of this is at Z = 0
	       difference() {
	       color("LightGrey")
		    cylinder(1, 5, 5, $fn = 100, center = true);
	       cylinder(1, 3.55, 3.55, $fn = 100, center = true);
	  }

	  translate([0, 0, - 1 - 2 / 2])
	       color("LightGrey")
	       cylinder(2, 4.75, 4.75, $fn = 100, center = true);

	  translate([0, 0, - 1 - 2 - 7.4 / 2]) 
	       color("Black")
	       cylinder(7.4, 3.35, 3.35, $fn = 100, center = true);

	  difference() { // wire connections
	       union() {
		    translate([-1.5, 0, -1 - 2 - 7.4 - 5 / 2])
			 color("LightGrey")
			 cube([0.5, 2, 5], center = true);

		    translate([-1.5, 0, -1 - 2 - 7.4 - 5])
			 rotate([0, 90, 0])
			 color("LightGrey")
			 cylinder(0.5, 1, 1, $fn = 100, center = true);
		    
		    translate([1.5, 0, -1 - 2 - 7.4 - 5 / 2])
			 color("LightGrey")
			 cube([0.5, 2, 5], center = true);

		    translate([1.5, 0, -1 - 2 - 7.4 - 5])
                         rotate([0, 90, 0])
                         color("LightGrey")
                         cylinder(0.5, 1, 1, $fn = 100, center = true);
	       }
	       translate([-1.5, 0, -1 - 2 - 7.4 - 5])
                         rotate([0, 90, 0])
                         cylinder(0.5, 0.5, 0.5, $fn = 100, center = true);

	       translate([1.5, 0, -1 - 2 - 7.4 - 5])
                         rotate([0, 90, 0])
                         cylinder(0.5, 0.5, 0.5, $fn = 100, center = true);
	  }
     }
}
