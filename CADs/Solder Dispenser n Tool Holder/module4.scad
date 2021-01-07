module module4() {
     translate(v = [mod1X / 2 + mod2X + mod3X + mod4X / 2, 0, 0])
	  union() {
	  // baseplate                                                               
	  translate(v = [0, 0, baseZ / 2])
	       cube([mod4X, baseY, baseZ], center = true);
	  
	  // dovetails                                                               
	  rotate(a = [0, 0, 90])
	       translate(v = [0, 0, -dtHeight / 2])
	       doves(mod4X, baseY);
	  
	  // tip cleaner
	  translate(v = [0,  -baseY / 2 + tipCleanDia / 2 + tipCleanWall + edgeSpace, baseHeight + tipCleanHeight / 2])
	       color("green")
	       difference() {
	       cylinder(h = tipCleanHeight, r1 = tipCleanDia / 2 + tipCleanWall, r2 = tipCleanDia / 2 + tipCleanWall, center = true, $fn = roundness);
	       cylinder(h = tipCleanHeight, r1 = tipCleanDia / 2, r2 = tipCleanDia / 2, center = true, $fn = roundness);
	  }

	  // solder tips
	  for (tipNo = [0 : noSolderTips - 1]) {
	       translate(v = [-mod4X / 2 + edgeSpace + solderTipDia / 2 + solderTipWall + tipNo * ((mod4X - edgeSpace * 2 - solderTipWall * 2 - solderTipDia) / (noSolderTips - 1)), baseY / 2 - solderTipDia / 2 - edgeSpace - solderTipWall, baseHeight + solderTipZ / 2])
		    color("pink")
		    difference() {
		    cylinder(h = solderTipZ, r1 = solderTipDia / 2 + solderTipWall, r2 = solderTipDia / 2 + solderTipWall, center = true, $fn = roundness);
		    cylinder(h = solderTipZ, r1	= solderTipDia / 2, r2 = solderTipDia	/ 2, center = true, $fn = roundness);
		    }
	  }
     }
}
