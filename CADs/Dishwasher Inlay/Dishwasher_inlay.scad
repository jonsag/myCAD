// Dishwasher_inlay.scad

// Outer limits
width = 55;
depth = 40;
height = 3;

// outer grid
outerBarWidth = 2;

// inner grid
innerBarWidth = 1.5;

// cc distance between bars
ccWidth = 5;

// use rounded outer corners
radius = true;

// roundness
$fn = 100;

union() {
  // ---------- outer bars ----------
  frame();
  // make outer radius
  if (radius) {
    outerRadius();
    // make inner radius
    innerRadius();
  }
  
  // ---------- inner grid ----------
  grid();
}

module frame() {
  color("red")
    for (Xbar = [-width / 2 + outerBarWidth / 2, width / 2 - outerBarWidth / 2]) {
      translate(v = [Xbar,  0, 0])
	if (radius) {
	  cube(size = [outerBarWidth, depth - outerBarWidth * 4, height], center = true);
	} else {
	  cube(size = [outerBarWidth, depth, height], center = true);
	}
    }
  
  color("blue")
    for (Ybar = [-depth / 2 + outerBarWidth / 2, depth / 2 - outerBarWidth / 2]) {
      translate(v = [0, Ybar, 0])
	if (radius) {
	  cube(size = [width - outerBarWidth * 4, outerBarWidth, height], center = true);
	} else {
	  cube(size = [width, outerBarWidth, height], center = true);
	}
    }
}

module grid() {
  // X              
  Xno = floor((width - outerBarWidth * 2) / ccWidth - 1);
  echo("X-grid: ", Xno);
  
  color("green")
    for (Xplace = [-ccWidth * Xno / 2: ccWidth: ccWidth * Xno / 2]) {
      translate(v = [Xplace, 0, 0])
        cube(size = [innerBarWidth, depth, height], center = true);
    }
  
  // Y
  Yno = floor((depth - outerBarWidth * 2) / ccWidth - 1);
  echo("Y-grid: ", Yno);
  
  color("grey")
    for (Yplace = [-ccWidth * Yno / 2: ccWidth: ccWidth * Yno / 2]) {
      translate(v = [0, Yplace, 0])
        cube(size = [width, innerBarWidth, height], center = true);
    }
}

module outerRadius() {
  color("pink")
    difference() {
    union() {
      for (Xout = [-width / 2 + outerBarWidth * 2, width / 2 - outerBarWidth * 2]) {
	for (Yout = [-depth / 2 + outerBarWidth * 2, depth / 2 - outerBarWidth * 2]) {
	  translate(v = [Xout, Yout, 0])
	    cylinder(h = height, r1 = outerBarWidth * 2, r2 = outerBarWidth * 2, center = true);
	}
      }
    }
    
    union() {
      for (Xout = [-width / 2 + outerBarWidth * 3, width / 2 - outerBarWidth * 3]) {
	for (Yout = [-depth / 2 + outerBarWidth * 3, depth / 2 - outerBarWidth * 3]){
	  translate(v = [Xout, Yout, 0])
	    cube(size = [outerBarWidth * 4, outerBarWidth * 4, height], center = true);
	}
      }
    }
  }
}

module innerRadius() {
  color("orange")
    difference() {
    union() {
      for (Xout = [-width / 2 + outerBarWidth * 1.5, width / 2 - outerBarWidth * 1.5]) {
	for (Yout = [-depth / 2 + outerBarWidth * 1.5, depth / 2 - outerBarWidth * 1.5]) {
	  translate(v = [Xout, Yout, 0])
	    cube(size = [outerBarWidth, outerBarWidth, height], center = true);
	}
      }
    }
    
    union() {
      for (Xout = [-width / 2 + outerBarWidth * 2, width / 2 - outerBarWidth * 2]){
        for (Yout = [-depth / 2 + outerBarWidth * 2, depth / 2 - outerBarWidth * 2]) {
          translate(v = [Xout, Yout, 0])
	    cylinder(h = height, r1 = outerBarWidth, r2 = outerBarWidth, center = true);
        }
      }
    }   
  }
}
