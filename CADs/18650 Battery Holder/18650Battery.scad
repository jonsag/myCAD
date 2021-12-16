//batteryHolder.scad


// include some NOP scad libraries by nophead, https://github.com/nophead/NopSCADlib
include <../../OpenSCADlibraries/NopSCADlib//utils/core/core.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/batteries.scad>

/*
contWidth = 16.5;
contHeight = 16;
contThick = 0.3;

termWidth = 2.86;
termLength = 6;

cellLength = 65; // including cellPosHeight
cellDia = 18.3;
cellPosHeight = 25;
*/

// bcontact = ["bcontact", 9.33, 9.75, 0.4, 2.86, 6, [1.6, 3, 5], [4.5, batt_spring]];
my_bcontact = ["bcontact", contWidth, contHeight, contThick, termWidth, termLength,
	       [contPosHeight, contPosSmallDia, contPosLargeDia],
	       [contNegHeight, batt_spring]];

// S25R18650 = ["S25R18650", "Cell Samsung 25R 18650 LION",              65,   18.3, 13, 10,  0,   "MediumSeaGreen", [],                      0, bcontact];
my_18650 = ["18650 Li-ion 3.6V", "Cell Kjell & Co 2600mAh",
	     cellLength,   cellDia, 13, cellPosDia,  cellPosHeight,   "LightSkyBlue",
	    [],
	     0, bcontact];

module battery_n_terminals() {
  translate([0, 0, 0])
    rotate([0, 0, 0,]) {
    // 18650 cell
    battery(my_18650);

    // positive contact
    translate([0, 0, cellLength / 2 + posCOffset + compPosExtra])
      rotate([0, 180, 0])
      battery_contact(my_bcontact, true);
    
    // negative contact
    translate([0, 0, -cellLength / 2 + negCOffset - compNegExtra])
      battery_contact(my_bcontact, false);
    
  }
}
