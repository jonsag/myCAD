//batteryHolder.scad


// include some NOP scad libraries by nophead, https://github.com/nophead/NopSCADlib
include <../../OpenSCADlibraries/NopSCADlib//utils/core/core.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/batteries.scad>

contWidth = 16.5;
contHeight = 16;
contThick = 0.3;

termWidth = 2.86;
termLength = 6;

// bcontact = ["bcontact", 9.33, 9.75, 0.4, 2.86, 6, [1.6, 3, 5], [4.5, batt_spring]];
my_bcontact = ["bcontact", contWidth, contHeight, contThick, termWidth, termLength, [1.6, 3, 5], [4.5, batt_spring]];

module battery_n_terminals() {
  translate([0, 0, 0])
    rotate([0, 0, 0,]) {
    // 18650 cell
    battery(S25R18650);

    // positive contact
    translate([0, 0, cellLength / 2 + posCOffset])
      rotate([0, 180, 0])
      battery_contact(my_bcontact, true);
    
    // negative contact
    translate([0, 0, -cellLength / 2 + negCOffset])
      battery_contact(my_bcontact, false);
    
  }
}
