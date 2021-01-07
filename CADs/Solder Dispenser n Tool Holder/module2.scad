module module2() {
  translate(v = [mod1X / 2 + mod2X / 2, 0, 0])
    difference() {
    union() {
      // baseplate
      translate(v = [0, 0, baseZ / 2])
	cube([mod2X, baseY, baseZ], center = true);
      
      // dovetails
      rotate(a = [0, 0, 90])
	translate(v = [0, 0, -dtHeight / 2])
	doves(mod2X, baseY);
      
      // roll holder
      color("gray")
	translate(v = [0, -baseY / 2 + rollDia / 2 + rollWall + edgeSpace, 0])
	union() {
	translate(v = [0, 0, baseHeight + rollDia / 2])
	  difference() {
	  cube([rollX + rollWall * 2, rollDia + rollWall * 2, rollDia], center = true);
	  translate(v = [0, 0, rollDia / 4])
	    cube([rollX, rollDia, rollDia / 2], center = true);
	  
	  rotate(a = [0, 90, 0])
	    cylinder(h = rollX, r1 = rollDia / 2, r2 = rollDia / 2, center = true, $fn = roundness);
	  
	  translate(v = [0, rollDia / 2 - rollWall * 2.5, rollDia])
	    rotate(a = [0, 90, 0])
	    cylinder(h = rollX + rollWall * 2, r1 = rollDia, r2 = rollDia, center = true, $fn = roundness);
	  
	  // solder slot
	  translate(v = [0, -rollDia / 2 - rollWall / 2, rollDia / 4 - rollWall * 2])
	    union() {
	    cube([solderSlotX, rollWall, rollDia / 2], center = true);
	    
	    translate(v = [0, 0, rollDia / 4])
	      rotate(a = [90, 0, 0])
	      cylinder(h = rollWall, r1 = solderSlotX / 2, r2 = solderSlotX / 2, , center = true, $fn = roundness);
	    translate(v = [0, 0, -rollDia / 4])
	      rotate(a = [90, 0, 0])
	      cylinder(h = rollWall, r1	= solderSlotX /	2, r2 = solderSlotX / 2, , center = true, $fn = roundness);
	  }
	}
      }
      
      // desoldering pump
      color("purple")
	translate(v = [0, baseY / 2 - pumpDia / 2 - pumpWall - edgeSpace, pumpY / 2 - dtHeight])
	difference() {
	cylinder(h = pumpY, r1 = pumpDia / 2 + pumpWall, r2 = pumpDia / 2 + pumpWall, center = true, $fn = roundness);
	translate(v = [0, 0, pumpY / 2 -pumpRecess / 2])
	  cylinder(h = pumpRecess, r1 = pumpDia / 2, r2 = pumpDia / 2, center = true, $fn = roundness);
	
	translate(v = [0, 0, -(pumpY -pumpY * 7 / 8) / 2])
	  cylinder(h = pumpY -pumpY * 7 / 8, r1 = pumpTipDia / 2, r2 = pumpDia / 2, center =true, $fn = roundness);
      }
      
      
      // braid roll
      color("red")
	translate(v = [0, -baseY / 2 + rollDia + rollWall + edgeSpace + braidDepth / 2 + braidWall, baseHeight + braidDia / 4])
	difference() {
	cube([braidDia + braidWall * 2, braidDepth + braidWall * 2, braidDia / 2], center = true);
	
	translate(v = [0, 0, braidDia / 4])
	  rotate([90, 0, 0])
	  cylinder(h = braidDepth, r1 = braidDia / 2, r2 = braidDia / 2, center = true, $fn = roundness);
      }
      
    }
    translate(v = [0, baseY / 2 - pumpDia / 2 - pumpWall - edgeSpace, pumpY / 2 - dtHeight])
      cylinder(h = pumpY, r1 = pumpTipDia / 2, r2 = pumpTipDia / 2, center = true, $fn = roundness);
  }
}
