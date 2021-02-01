

//------------------------------------------------------------------------
// OpenSCAD models of miscellaneous components and devices:
// Pin headers, SD-Card, Edimax WiFi nano dongle, etc.
//
// Author:      Niccolo Rigacci <niccolo@rigacci.org>
// Version:     1.0 2017-12-14
// License:     GNU General Public License v3.0
//------------------------------------------------------------------------

//------------------------------------------------------------------------
// Matrix of 2.54 mm pins.
//------------------------------------------------------------------------
module pin_headers(cols, rows) {
  w = 2.54; h = 2.54; p = 0.65;
  for(x = [0 : (cols -1)]) {
    for(y = [0 : (rows  - 1)]) {
      translate([w * x, w * y, 0]) {
	union() {
	  color("black") 
	    cube([w, w, h]);
	  color("gold")  
	    translate([(w - p) / 2, (w - p) / 2, -3]) cube([p, p, 11.54]);
	}
      }
    }
  }
}
