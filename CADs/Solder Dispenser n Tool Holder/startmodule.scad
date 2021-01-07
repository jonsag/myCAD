module startmodule() {
  translate(v = [-mod1X / 2 - stX / 2, 0, 0])
    difference() {
    union() {
      // baseplate
      translate(v = [0, 0, baseZ / 2])
	cube([stX, baseY, baseZ], center = true);
      
      // dovetails
      rotate(a = [0, 0, 90])
	translate(v = [0, 0, -dtHeight / 2])
	dovesstart(stX, baseY);
    }
    translate(v = [-teethDepth, 0, -dtHeight / 2])
      cube([stX, baseY, baseZ], center = true);
  }
}

