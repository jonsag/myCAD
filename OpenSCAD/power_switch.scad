/*
totalWidth = 20;
holeWidth = 10.5;
holeDepth = 7;
screwHoleWidth = 15;
screwHoleDia = 2;
knobHoleWidth = 6;
knobDepth = 3;
knobWidth = 3;
knobHeight = 5;
mountPlateHeight = 0.5;
bodyHeight = 5;
legWidth = 1.5;
legDepth = 0.5;
legLength = 3;
legSpacing = 2.54;

powerSwitch(totalWidth, holeWidth, holeDepth, screwHoleWidth, screwHoleDia, knobHoleWidth, knobDepth, knobWidth, knobHeight, mountPlateHeight, bodyHeight, legWidth, legDepth, legLength, legSpacing);
*/

module powerSwitch(totalWidth, holeWidth, holeDepth, screwHoleWidth, screwHoleDia, knobHoleWidth, knobDepth, knobWidth, knobHeight, mountPlateHeight, bodyHeight, legWidth, legDepth, legLength, legSpacing) {

     overSize = 1.1;
	  
     union() {
	  difference () {
	       translate([0, 0, 0]) // top plate
		    color("LightGrey")
		    cube([totalWidth, holeDepth, mountPlateHeight], center = true);

	       translate([-screwHoleWidth / 2, 0, 0]) // mounting hole
		    cylinder(mountPlateHeight * overSize, screwHoleDia / 2, screwHoleDia / 2, $fn = 100, center = true);

	       translate([screwHoleWidth / 2, 0, 0]) // mounting hole
                    cylinder(mountPlateHeight *	overSize, screwHoleDia / 2, screwHoleDia / 2, $fn = 100, center = true);

	       translate([0, 0, 0]) // knob hole
                    cube([knobHoleWidth, knobDepth, mountPlateHeight * overSize], center = true);
	  }

	  translate([0, 0, -bodyHeight / 2]) // switch body
	       color("LightGrey")
	       cube([holeWidth, holeDepth, bodyHeight  - mountPlateHeight], center = true);

	  translate([-knobHoleWidth / 2 + knobWidth / 2, 0, mountPlateHeight / 2 + knobHeight / 2]) // knob
	       color("Black")
	       cube([knobWidth, knobDepth, knobHeight], center = true);

	  for ( i = [-legSpacing: legSpacing : legSpacing] ){
	       translate([i, 0, mountPlateHeight / 2 - bodyHeight - legLength / 2])
	       color("LightGrey")
		    cube([legWidth, legDepth, legLength], center = true);
	       }
     }
}
