module module5() {
     translate(v = [mod1X / 2 + mod2X + mod3X + mod4X + mod5X / 2, 0, 0])
       difference() {
	  union() {
	       // baseplate
	       translate(v = [0, 0, baseZ / 2])
		    cube([mod5X, baseY, baseZ], center = true);
	       
	       // dovetails
	       //rotate(a = [0, 0, 90])
		 //   translate(v = [0, 0, -dtHeight / 2])
		   // doves(mod5X, baseY);
	       
	       // solder paste cup
	       translate(v = [0, -baseY / 2 + solderPDia / 2 + solderPWall + edgeSpace, baseHeight + solderPZ / 2]) 
		    color("purple")
		    difference() {
		    cylinder(h = solderPZ, r1 = solderPDia / 2 + solderPWall, r2 = solderPDia / 2 + solderPWall, center = true, $fn = roundness);
		    cylinder(h = solderPZ, r1 = solderPDia / 2, r2 = solderPDia / 2, center =true, $fn = roundness);
	       }
	       // syringes
	       for ( syrNo = [0 : noSyrs -1] ) {
		    translate(v = [-mod5X / 2 + syrDia1 / 2 + syrWall + edgeSpace + syrNo * (mod5X - edgeSpace * 2 - syrDia1 - syrWall * 2) / (noSyrs - 1) ,baseY / 2 -(syrDia1 / 2 + syrWall + edgeSpace), syrZTot / 2 - dtHeight])
			 //color("yellow")
			 translate(v = [0, 0, 0])
			 difference() {
			 // total
			 cylinder(h = syrZTot, r1 = syrDia1 / 2 + syrWall, r2 = syrDia1 / 2 + syrWall, center = true, $fn = roundness);
			 // top hole
			 translate(v = [0, 0, syrZTot / 2 - (syrZTot - syrZWaist - syrZTip) / 2])
			      cylinder(h = syrZTot - syrZWaist - syrZTip, r1 = syrDia1 / 2, r2 = syrDia1 / 2, center	= true,	$fn = roundness);
			 //
			 translate(v = [0, 0, syrZTot / 2 - (syrZTot - syrZWaist - syrZTip) - syrZWaist / 2])
			      cylinder(h = syrZWaist, r1 = syrDia2 / 2, r2 = syrDia1 / 2, center = true, $fn = roundness);
		    }
	       }
	       // tips
	       for ( tipNo = [0 : noTips -1] ) {
		    translate(v = [-mod5X / 2 + syrTipDia / 2 + syrWall + edgeSpace + tipNo * (mod5X - edgeSpace * 2 - syrTipDia - syrWall * 2) / (noTips - 1), baseY / 2 - edgeSpace * 2- syrDia1 - syrWall * 2 - syrTipDia / 2 - syrWall, syrZTip / 2 - dtHeight])
			 cylinder(h = syrZTip, r1 = syrTipDia / 2 + syrWall, r2 = syrTipDia / 2 + syrWall, center    = true, $fn = roundness);
	       }
	       // dovetails
	       rotate(a = [0, 0, 90])
		 color("green")
		    translate(v = [0, 0, -dtHeight / 2])
		    doves(mod5X, baseY);
	  }
	  // remove this
	  // syringe tip hole
	  for ( syrNo2 = [0 : noSyrs -1] ) {
	       translate(v = [-mod5X / 2 + syrDia1 / 2 + syrWall + edgeSpace + syrNo2 * (mod5X - edgeSpace * 2 - syrDia1 - syrWall * 2) / (noSyrs - 1), baseY / 2 -(syrDia1 / 2 + syrWall + edgeSpace), syrZTot / 2 - dtHeight])

	  cylinder(h = syrZTot, r1 = syrDia2 / 2, r2 = syrDia2 / 2, center       = true, $fn = roundness);
	       }
	  // tip hole                                                                         
	  for ( tipNo = [0 : noTips -1] ) {
	       translate(v = [-mod5X / 2 + syrTipDia / 2 + syrWall + edgeSpace + tipNo * (mod5X - edgeSpace * 2 - syrTipDia - syrWall * 2) / (noTips - 1), baseY / 2 - edgeSpace * 2- syrDia1 - syrWall * 2 - syrTipDia / 2 - syrWall, syrZTip / 2 - dtHeight])
		    cylinder(h = syrZTip, r1 = syrTipDia / 2, r2 = syrTipDia / 2, center    = true, $fn = roundness);
	  }
     }
}

