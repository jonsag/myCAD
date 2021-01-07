module module1() {
     translate(v = [0, 0, 0])
	  union() {
	  // baseplate
	  translate(v = [0, 0, baseZ / 2])
	       cube([mod1X, baseY, baseZ], center = true);
	  
	  // dovetails
	  rotate(a = [0, 0, 90])
	    color("green")
	       translate(v = [0, 0, -dtHeight / 2])
	       doves(mod1X, baseY);
	  
	  // pliers
	  for (plierNo = [0 : noPliers - 1]) {
	       translate(v = [-mod1X / 2 + (plierX + plierWall * 2) / 2 + edgeSpace + plierNo * ((mod1X - edgeSpace * 2 - plierX - plierWall * 2) / (noPliers -1)), baseY / 2 - plierY / 2 - plierWall - edgeSpace, baseHeight + plierZ / 2])
		    color("blue")
		    difference() {
		    cube([plierX + plierWall * 2, plierY + plierWall * 2, plierZ], center = true);
		    cube([plierX, plierY, plierZ], center = true);
	       }
	  }
	  
	  // flux pen
	  translate(v = [-mod1X / 2 + fluxPDia / 2 + fluxPWall + edgeSpace, baseY / 2 - edgeSpace * 2 - fluxPDia / 2 - fluxPWall - plierY - plierWall * 2, baseHeight + fluxPHeight / 2])
	       color("blue")
	       difference()  {
	       cylinder(h = fluxPHeight, r1 = fluxPDia / 2 + fluxPWall, r2 = fluxPDia / 2 + fluxPWall, center = true, $fn = roundness);
	       cylinder(h = fluxPHeight, r1 =	fluxPDia / 2, r2 = fluxPDia / 2, center = true, $fn =	roundness);
	  }
	  
	  // flux brush
	  for (fluxBX = [ 0 : 1]) {
	       for (fluxBY = [0 : 1]) {
		    translate(v = [mod1X / 2 - fluxBDia / 2 - fluxBWall - edgeSpace - fluxBX * (fluxBDia + fluxBWall * 2 + edgeSpace), baseY / 2 - edgeSpace * 2 - fluxBDia / 2 - fluxBWall - plierY - plierWall * 2 - fluxBY * (fluxBDia + fluxBWall * 2 + edgeSpace), baseHeight + fluxBHeight / 2])
			 color("blue")
			 difference()  {
			 cylinder(h = fluxBHeight, r1 =	fluxBDia / 2 + fluxBWall, r2 = fluxBDia / 2 + fluxBWall, center = true, $fn =	roundness);
			 cylinder(h = fluxBHeight, r1 = fluxBDia / 2, r2 = fluxBDia / 2, center = true, $fn =   roundness);
		    }
	       }
	  }
	  
	  // flux cup
	  translate(v = [0, -baseY / 2 + fluxDia / 2 + fluxWall + edgeSpace, baseHeight + fluxHeight / 2]) 
	       color("red")
	       difference() {
	       cylinder(h = fluxHeight, r1 = fluxDia / 2 + fluxWall, r2 = fluxDia / 2 + fluxWall, center = true, $fn = roundness);
	       cylinder(h = fluxHeight, r1 = fluxDia / 2, r2 = fluxDia / 2, center =true, $fn = roundness);
	  }

     }
}
