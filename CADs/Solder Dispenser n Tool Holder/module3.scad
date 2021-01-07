module module3() {
     translate(v = [mod1X / 2 + mod2X + mod3X / 2, 0, 0])
	  union() {
	  // baseplate
	  translate(v = [0, 0, baseZ / 2])
	       cube([mod3X, baseY, baseZ], center = true);
	  
	  // dovetails
	  rotate(a = [0, 0, 90])
	    color("green")
	       translate(v = [0, 0, -dtHeight / 2])
	       doves(mod3X, baseY);

	  // soldering stand
	  color("maroon")
	  translate(v = [0, 0, baseHeight + standZ / 2])
	       difference() {
	       union() {
		    translate(v = [-mod3X / 2 +(standWall * 2 + standThick) / 2 + edgeSpace, 0, 0])
			 cube([standWall * 2 + standThick, baseY - edgeSpace * 2, standZ], center = true);
		    translate(v = [mod3X / 2 -(standWall * 2 + standThick) / 2 - edgeSpace, 0, 0])
			 cube([standWall * 2 + standThick, baseY - edgeSpace * 2, standZ], center = true);
	       }
	       // slots
	       translate(v = [-mod3X / 2 +(standWall * 2 + standThick) / 2 + edgeSpace, 0, 0])
		    cube([standThick, baseY - edgeSpace * 2, standZ], center = true);
	       translate(v = [mod3X / 2 -(standWall * 2 + standThick) / 2 - edgeSpace, 0, 0])
		    cube([standThick, baseY - edgeSpace * 2, standZ], center = true);
	  }
     }
}
