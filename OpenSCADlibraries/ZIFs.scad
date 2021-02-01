

module zif28() {
  
  radius = 3;
  
  translate([2.54 * 6.5 - 2, 2.54 * 2, 11.9 / 2])
    union() {
    color("lightgreen")
      difference() {
      union() {
	translate([-50.5 / 2 + radius, -15 / 2 + radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	translate([50.5 / 2 - radius, -15 / 2 + radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	translate([50.5 / 2 - radius, 15 / 2 - radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	translate([-50.5 / 2 + radius, 15 / 2 - radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	cube([50.5 - radius * 2, 15, 11.9], center = true);
	
	cube([50.5, 15 - radius * 2, 11.9], center = true);
      }
      
      // room for lever
      translate([-50.5 / 2 + 5 / 2, -15 / 2 + 3 / 2, 11.9 / 2 - 5 / 2])
	color("red")
	cube([5, 3, 5], center = true);
    }
    
    // lever
    translate([-50.5 / 2, -15 / 2 + 3 / 2, 11.9 / 2 - 5 + 1])
      rotate([0, -90, 0])
      union() {
      color("lightgrey")
	cylinder(h = 10, r1 = 1, r2 = 1, center = true, $fn = roundness);
      
      translate([0, 0, 10 / 2 + 5 / 2])
	color("white")
	cylinder(h = 5, r1 = 2, r2 = 2, center = true, $fn = roundness);
    }
    
    translate([2, 0, -11.9 / 2]) // legs under ZIF
      rotate([0, 0, 90])
      pdip(28, 2.54, socketed = false, w = inch(0.4));
    
    translate([2, 0, 11.9 / 2]) // DIP on ZIF
      rotate([0, 0, 90])
      pdip(28, 2.54, socketed = false, w = inch(0.3));
    
  }
}

module zif20() {
  
  radius = 3;
  
  translate([2.54 * 4.5 - 2, 2.54 * 1.5, 11.9 / 2])
    union() {
    color("lightgreen")
      difference() {
      union() {
	translate([-40.2 / 2 + radius, -15 / 2 + radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	translate([40.2 / 2 - radius, -15 / 2 + radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	translate([40.2 / 2 - radius, 15 / 2 - radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	translate([-40.2 / 2 + radius, 15 / 2 - radius, 0])
	  cylinder(h = 11.9, r1 = radius, r2 = radius, center = true, $fn = roundness);
	
	cube([40.2 - radius * 2, 15, 11.9], center = true);
	
	cube([40.2, 15 - radius * 2, 11.9], center = true);
      }
      
      // room for lever
      translate([-40.2 / 2 + 5 / 2, -15 / 2 + 3 / 2, 11.9 / 2 - 5 / 2])
	color("red")
	cube([5, 3, 5], center = true);
    }
    
    // lever
    translate([-40.2 / 2, -15 / 2 + 3 / 2, 11.9 / 2 - 5 + 1])
      rotate([0, -90, 0])
      union() {
      color("lightgrey")
	cylinder(h = 10, r1 = 1, r2 = 1, center = true, $fn = roundness);
      
      translate([0, 0, 10 / 2 + 5 / 2])
	color("white")
	cylinder(h = 5, r1 = 2, r2 = 2, center = true, $fn = roundness);
    }
    
    translate([2, 0, -11.9 / 2])
      rotate([0, 0, 90])
      pdip(20, 2.54, socketed = false, w = inch(0.3));
    
    translate([2, 0, 11.9 / 2])
      rotate([0, 0, 90])
      pdip(20, 2.54, socketed = false, w = inch(0.3));
    
  }
}
