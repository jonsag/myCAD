include <18650Battery.scad>


noOfCells = 4;

drawCell = false;

cellLength = 65;
cellDia = 18;
cellDiaExtra = 0;

negCOffset = -3.5;
posCOffset = 1.6;

compPosExtra = 1.6;
compNegExtra = 3.5;

terminalHolderDepth = 1;

wallThickness = 2;

termWidthExtra = 2;
termHeight = 5;

///// calculations
thWidth = cellDia + cellDiaExtra;
thDepth = terminalHolderDepth;
thHeight = cellDia + cellDiaExtra;

///// start drawing /////
for (i =[ 0 : noOfCells - 1]) {
  translate([(cellDia + cellDiaExtra + wallThickness) * i, 0, 0])
    //rotY = i / 2 == round( i / 2 ) ? 0 : 180;
    if (i / 2 == round( i / 2 )) {
      rotate([0, 0, 0])
	cell_n_holders();
    } else {
      translate([0, compPosExtra - compNegExtra, 0])
      rotate([0, 0, 180])
	cell_n_holders();
    }
 }

module cell_n_holders() {
  // battery cell
  if (drawCell) {
  rotate([-90, 0, 0])
    translate([0, 0, 0])
    battery_n_terminals();
  }
  
  difference() {
    union() {
      // positive contact holder
      translate([0, cellLength / 2 + posCOffset, 0])
	rotate([0, 0, 0])
	terminalHolder();
      
      // negative contact holder
      translate([0, -cellLength / 2 + negCOffset, 0])
	rotate([0, 0, 180])
	terminalHolder();
      
      // battery compartment
      batteryComp();
    }

    // terminal cut out
  }
}

module terminalHolder() {
  thWidth = cellDia + cellDiaExtra;
  thDepth = 1;
  thHeight = cellDia + cellDiaExtra;

  translate([0, -thDepth / 2, 0])
  difference() {
    cube([thWidth, thDepth, thHeight], center = true);
    
    translate([0, thDepth / 4, (thHeight - contHeight) / 4])
      color("red")
      cube([contWidth, thDepth / 2 + 0.1, contHeight + (thHeight - contHeight) / 2 + 0.1], center = true);
    
    translate([0, -thDepth / 4, (thHeight - contHeight) / 4 + 1])
      color("red")
      cube([contWidth - 4, thDepth / 2 + 0.1, contHeight + (thHeight - contHeight) / 2 - 2 + 0.1], center = true);
  }
}

module batteryComp() {
  difference() {
    // outer shell
    translate([0, compPosExtra / 2 - compNegExtra / 2, 0])
      cube([cellDia + cellDiaExtra + wallThickness * 2, cellLength + wallThickness * 2 + compPosExtra + compNegExtra, cellDia + cellDiaExtra + wallThickness], center = true);
    
    // battery hole
    translate([0, compPosExtra / 2 - compNegExtra / 2, 0])
      translate([0, 0, wallThickness])
      cube([cellDia + cellDiaExtra, cellLength + compPosExtra + compNegExtra, cellDia + cellDiaExtra], center = true);
    
    // positive terminal cutout
    translate([0, cellLength / 2 + compPosExtra + wallThickness / 2, cellDia / 2 - termHeight / 2 + wallThickness / 2 + cellDiaExtra / 2])
      color("red")
      cube([termWidth + termWidthExtra, wallThickness + 0.2, termHeight + 0.1], center = true);
    
    // negative terminal cutout
    translate([0, -cellLength / 2 - compNegExtra - wallThickness / 2, cellDia / 2 - termHeight / 2 + wallThickness / 2 + cellDiaExtra / 2])
      color("red")
      cube([termWidth + termWidthExtra, wallThickness + 0.2, termHeight + 0.1], center = true);
  }
}
