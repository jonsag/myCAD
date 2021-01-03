
//led(5, "Green");

module led(diameter, _color) {
  difference() {
	  translate([0, 0, -1 / 2]) // ridge
	       color(_color)
	       cylinder(1, (diameter + 1) / 2, (diameter + 1) / 2, $fn = 100, center = true);

	  translate([1 / 2 + diameter / 2, 0, -1 / 2]) // delete cathode cut off
	       cube([1, diameter, 1], center = true);
     }
     
     translate([0, 0, (diameter * 1.72 - diameter / 2) / 2]) // straight part
	  color(_color)
          cylinder(diameter * 1.72 - diameter / 2, diameter / 2, diameter / 2, $fn = 100, center = true);

     translate([0, 0, diameter * 1.72 - diameter / 2]) // top dome
	  color(_color)
          sphere(diameter / 2, $fn = 100);

     translate([-2.54 / 2, 0, -1 - 28.5 / 2]) // anode
	  color("LightGrey")
	  cube([0.6, 0.6, 28.5], center = true);
     
     translate([2.54 / 2, 0, -1 - 27 / 2]) // cathode
          color("LightGrey")
          cube([0.6, 0.6, 27], center = true);

}
