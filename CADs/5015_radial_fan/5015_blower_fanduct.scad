// 5015_blower.scad

// Design: Jon Sagebrand
// jonsagebrand@gmail.com

// blower library by nophead at https://github.com/nophead/NopSCADlib
include <../../OpenSCADlibraries/NopSCADlib/core.scad>
//use <../NopSCADlib/utils/layout.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/blowers.scad>

// e3d model by Professional3D at https://www.thingiverse.com/thing:548237
include <../../OpenSCADlibraries/E3Dv6_hotend/e3d_v6_all_metall_hotend.scad>

// shroud by kbowley at https://www.thingiverse.com/thing:2429054

///// some parameters /////

// remove the clamp from the print
deleteClamp = true;

// shroud type
shroudType = 3; // 0: semicircle, rounded top, two holes, 1: kbowley's shroud, 2: single blow point, 3: triangular shaped shroud, >3: no shroud

// should we also show the blower and it's screws
showBlower = true;
showBlowerScrews = true;

// should we show the hotend
showHotend = true;

// position of the duct connecting to the shroud

lowerDuctX0 = -18; //-18; // shroudType 0
lowerDuctY0 = 24.5;
lowerDuctZ0 = -24.5;


lowerDuctX1 = -19; // shroudType 1
lowerDuctY1 = 24.7;
lowerDuctZ1 = -23.5;


lowerDuctX2 = -20; // shroudType 2
lowerDuctY2 = 20;
lowerDuctZ2 = -20;

lowerDuctX3 = -19; // shroudType 3
lowerDuctY3 = 23.8;
lowerDuctZ3 = -26;

lowerDuctXx = -10; // shroudType >3
lowerDuctYx = 10;
lowerDuctZx = -20;

// how far down should the shroud be
shroudXOffset = 0; // postive value moves it to the right
shroudYOffset = 0; // positive value moves it towards the heatblock
shroudZOffset = 0; // positive value moves it up

// square/round shroud
myShroudWidth = 10;
myShroudHeight = 6;

myRadius = 10;
myTotAngle = 180;
myAnglePos = -199;

myHoleWidth = 8;
myHoleHeight = 3;
myShroudWallThick = 0.7;

myShroudZAngle = -90;

myDuctX = -18.5;
myDuctY = 39.5; //44.5;
myDuctZ = -28;

// triangular shroud
triShWidth = 8;
triShHeight = 5;

triShHole = 2;
triShWallThick = 0.7;

myTriDuctX = -18.5;
myTriDuctY = 38;
myTriDuctZ = -28;

// rotate shroud around the Z axis
shroudZAngle = 0; // positive value rotates the shroud clockwise

// e3dv6 hotend clamp
hcWidth = 32.29;
hcDepth = 17;
hcHeight = 12.7;

hcScrewDistance = 23.3 - 5.3;
hcScrewHoleDia = 3.5;

hcTolerance = 100; 

// e3dv6 hotend
e3dLargeDia = 16;
e3dSmallDia = 12;

e3dTopHeight = 3.7;
e3dWaistHeight = 6;
e3dBottomHeight = 3;

///// no editing below this line, if you don't know what you are doing /////

roundness = 100;

// set position of connection to the shroud
lowerDuctX = shroudType == 0 ? lowerDuctX0 : (shroudType == 1 ? lowerDuctX1 : (shroudType == 2 ? lowerDuctX2 : (shroudType == 3 ? lowerDuctX3 : lowerDuctXx) ) );
lowerDuctY = shroudType == 0 ? lowerDuctY0 : (shroudType == 1 ? lowerDuctY1 : (shroudType == 2 ? lowerDuctY2 : (shroudType == 3 ? lowerDuctY3 : lowerDuctYx) ) );
lowerDuctZ = shroudType == 0 ? lowerDuctZ0 : (shroudType == 1 ? lowerDuctZ1 : (shroudType == 2 ? lowerDuctZ2 : (shroudType == 3 ? lowerDuctZ3 : lowerDuctZx) ) );

// the blower's data
b = ["RB5015", "Blower Runda RB5015", 51.3, 51, 15, 31.5,
     ["M4_cap", "M4 cap", 0, 4, 7, 4, 2, 3, 20,
      ["M4", 4, 9, 0.8, false, 7.9, 7, 1.2,
       ["M4_penny", 4, 14, 0.8, false, 7.9, 7, 1.2, true]],
      ["M4_nut", 4, 8.1, 3.2, 5,
       ["M4", 4, 9, 0.8, false, 7.9, 7, 1.2,
	["M4_penny", 4, 14, 0.8, false, 7.9, 7, 1.2, true]], 4, 0],
      1.65, 2.2], 26,
     [27.3, 25.4], 4.5,
     [[4.3, 45.4],
      [47.3, 7.4]],
     20, 14, 1.5, 1.3, 1.2, 15];

/*
["RB5015", "Blower Runda RB5015", 51.3, 51, 15, 31.5, 
["M4_cap", "M4 cap", 0, 4, 7, 4, 2, 3, 20, 
["M4", 4, 9, 0.8, false, 7.9, 7, 1.2, 
["M4_penny", 4, 14, 0.8, false, 7.9, 7, 1.2, true]], 
["M4_nut", 4, 8.1, 3.2, 5, 
["M4", 4, 9, 0.8, false, 7.9, 7, 1.2, 
["M4_penny", 4, 14, 0.8, false, 7.9, 7, 1.2, true]], 
4, 0], 
1.65, 2.2], 
26, 
[27.3, 25.4], 
4.5, 
[[4.3, 45.4], 
[47.3, 7.4]], 
20, 14, 1.5, 1.3, 1.2, 15]
*/

///// start drawing /////
union() {
     
  // hotend clamp
  if (!deleteClamp) {
    drawHcClamp();
  }

  // the mount towards the clamp
  mountPlate();
  
  // blower, mount and duct
   translate([3, -hcDepth / 2 - 4, -10])
  rotate([-135, 0, -90])
    
  //translate([40, 0, 0])
    fanDuct();
  

}

///// below are things we don't want to print

// the hotend
if (showHotend) {
  translate([0, hcDepth / 2, e3dTopHeight + e3dWaistHeight])
    rotate([0, 180, 0])
    color("lightgrey")
    e3d();
 }

module writeBlowerScrews() {
  screw = blower_screw(b);
  washer = screw_washer(screw);
  h = blower_lug(b);
  
  blower_hole_positions(b)
    translate_z(h)
    screw_and_washer(screw, screw_longer_than(h + washer_thickness(washer) + 5));
}

module drawHcClamp() {

  difference() {
    
      cube([hcWidth, hcDepth, hcHeight], center = true);
    
    // make the screw holes
    
      for (x = [-hcScrewDistance / 2 : hcScrewDistance: hcScrewDistance / 2]) {
	translate([x, 0, 0])
	  rotate([90, 0, 0])
	  cylinder(h = hcDepth, r1 = hcScrewHoleDia / 2, r2 = hcScrewHoleDia / 2, center = true, $fn = roundness);
      }
    
    // the cutout for the hotend
    
      translate([0, hcDepth / 2, 0])
      cylinder(h = e3dWaistHeight, r1 = e3dSmallDia / 2, r2 = e3dSmallDia / 2, center = true, $fn = roundness);
    
    for (y = [-e3dWaistHeight/ 2 - (hcHeight - e3dWaistHeight) / 4: e3dWaistHeight + (hcHeight - e3dWaistHeight) / 2 : e3dWaistHeight/ 2 + (hcHeight - e3dWaistHeight) / 4]) {
      translate([0, hcDepth / 2, y])
	cylinder(h = (hcHeight - e3dWaistHeight) / 2, r1 = e3dLargeDia / 2, r2 = e3dLargeDia / 2, center = true, $fn = roundness);
    }
  }
}

module mountPlate() {
  translate([0, -hcDepth / 2 - 2, 0])
    difference() {
    
      cube([hcWidth, 4, hcHeight], center = true);
    
    
      for (x = [-hcScrewDistance / 2 : hcScrewDistance: hcScrewDistance / 2]) {
	translate([x, 0, 0])
	  rotate([90, 0, 0])
	  cylinder(h = 4, r1 = hcScrewHoleDia / 2, r2 = hcScrewHoleDia / 2, center = true, $fn = roundness);
      }
  }
}

module fanDuct() {

  union() {
    fanduct90Down(invert = true);
    
    blowerMountPlate();

  }
  
  // the blower
  if (showBlower) {
    translate([0, 0, 0])
      rotate([0, -90, 180])
      blower(b);
  }
  
  // the blower's screws
  if (showBlowerScrews) {
    translate([0, 0, 0])
      rotate([0, -90, 180])
      writeBlowerScrews();
  }
}

module fanduct90Down(invert = false) {
  placeX = invert ? 17 : -2;
  placeZ = invert ? 22 : -2;
  
  rotateY = invert ? 180 : 0;

  angle = 45;
  
  translate([placeX, 0, placeZ])
    rotate([0, rotateY, 0])
    difference() { //////////////////////////////////////////////////////////////////////// start of difference
    union() { // outer shell
      
	translate([19, 0, 0])
	rotate([0, -90, 0])
	rotate_extrude(angle = angle, convexity = 2)
	polygon(points = [[0, 0], [24, 0], [24, 19], [0, 19]]);
      
       // frame against blower
	translate([0, -2, 0])
	cube([19, 2, 24]);
      
      hull() {
	 // frame towards extruder
	  rotate([-angle, 0, 0])
	  translate([0, 0, 0])
	  cube([19, 2, 24]);
	
	  rotate([angle, 0, 0])
	    translate([lowerDuctY + shroudYOffset, -lowerDuctX - shroudXOffset, lowerDuctZ + shroudZOffset]) // this positions the duct to the ring
	  scale([0.5, 1, 1])
	  cylinder(h = 2, r1 = 8, r2 = 8, $fn = roundness);
      }

      if (shroudType == 0) {
	rotate([-45, 0,-180]) // the shroud closest to the heatblock, additions
	  translate([-myDuctY - shroudYOffset, myDuctX + shroudXOffset, myDuctZ + shroudZOffset])
	  rotate([0, 0, -myShroudZAngle])
	  blowShroudAdd();

      /*
      rotate([-45, 0,-180])
	translate([-myDuctY - shroudYOffset, myDuctX + shroudXOffset, myDuctZ + shroudZOffset])
        rotate([0, 0, -myShroudZAngle])
	blowShroudSub(); // the shroud closest to the heatblock, subtractions
      */

      } else if (shroudType == 1) {
      rotate([-45, 0,-180]) // the shroud closest to the heatblock
	translate([-43.5 - shroudXOffset, -20 + shroudYOffset, -24 + shroudZOffset])
	//color("azure", 0.5)
	rotate([0, 0, -shroudZAngle])
	blow_ring();
      
      } else if (shroudType == 2) {
	rotate([-45, 0,-180]) // the shroud closest to the heatblock
	  translate([-20 - shroudXOffset, -20 + shroudYOffset, -25 + shroudZOffset])
	  //color("azure", 0.5)
	  rotate([0, 0, -shroudZAngle])
	  singleBlowAdd();

	/*
	rotate([-45, 0,-180]) // the shroud closest to the heatblock
	  translate([-20 - shroudXOffset, -20 + shroudYOffset, -25.1 + shroudZOffset])
	  color("red")
	  rotate([0, 0, -shroudZAngle])
	  singleBlowSub();
	*/
      } else if (shroudType == 3) {
	rotate([-45, 0,-180]) // the shroud closest to the heatblock, additions
          translate([-myTriDuctY - shroudYOffset, myTriDuctX + shroudXOffset, myTriDuctZ + shroudZOffset])
          rotate([0, 0, -myShroudZAngle])
          triShroudAdd();
      }

    } //////////////////////////////////////////////////////////////////////// these were all the parts to be added, now subtractions

    translate([17, 0, 2])
      rotate([0, -90, 0])
      rotate_extrude(angle = angle, convexity = 2)
      polygon(points = [[0, 0], [20, 0], [20, 15], [0, 15]]);
    
    
    translate([2, -2, 2])
      cube([15, 4, 20]);
    
    hull() {
      
      rotate([-angle, 0, 0])
	translate([2, -2, 2])
	cube([15, 4.1, 20]);
      
      rotate([angle, 0, 0])
	translate([lowerDuctY + shroudYOffset, -lowerDuctX - shroudXOffset, lowerDuctZ - 0.1 + shroudZOffset]) // this positions the duct to the ring
	scale([0.5, 1, 1])
	cylinder(h = 2, r1 = 6, r2 = 6, $fn = roundness);
    }
    
    if (shroudType == 0) {
      rotate([-45, 0,-180]) // the shroud closest to the heatblock, subtractions
        translate([-myDuctY - shroudYOffset, myDuctX + shroudXOffset, myDuctZ + shroudZOffset])
        rotate([0, 0, -myShroudZAngle])
	blowShroudSub();
      
    } else if (shroudType == 2) {
      rotate([-45, 0,-180]) // the shroud closest to the heatblock
	translate([-20 - shroudXOffset, -20 + shroudYOffset, -25.1 + shroudZOffset])
	//color("red")
	rotate([0, 0, -shroudZAngle])
	singleBlowSub();
      
    } else if (shroudType == 3) {
      rotate([-45, 0,-180]) // the shroud closest to the heatblock, subtractions
        translate([-myTriDuctY - shroudYOffset, myTriDuctX + shroudXOffset, myTriDuctZ + shroudZOffset])
        rotate([0, 0, -myShroudZAngle])
	triShroudSub();
    }
  }
}

/*
module fanduct90Left(invert = false) {
  placeX = invert ? 17 : -2;
  placeZ = invert ? 22 : -2;
  
  rotateY = invert ? 180 : 0;
  
  translate([placeX, 0, placeZ])
    rotate([0, rotateY, 0])
    difference() {
    union() {
      
	rotate_extrude(angle = 90, convexity = 2)
	polygon(points = [[0, 0], [19, 0], [19, 24], [0, 24]]);
      
      
	translate([0, -2, 0])
	cube([19, 2, 24]);
      
      color("blue")
	translate([-2, 0, 0])
	cube([2, 19, 24]);
      
    }
    
      translate([2, 2, 2])	     
      rotate_extrude(angle = 90, convexity = 2)
      polygon(points = [[0, 0], [15, 0], [15, 20], [0, 20]]);
    
    
      translate([2, -2, 2])
      cube([15, 4, 20]);
    
    
      translate([-2, 2, 2])
      cube([4, 15, 20]);
    
  }
}
*/

module blowerMountPlate() {
  /*
    lower screw: 45.4, 4.3
    upper screw: 7.4, 47.3
    angle between points (45.4 - 7.4, 47.3 - 4.3): 41.468 degrees  
    distance between points: 57.38467 (28,692335 * 2)
    https://www.omnicalculator.com/math/distance: d = √((x2-x1)2 + (y2-y1)2)
  */
  
  difference() {
    union() {
       // the bar between the two mounting holes
	hull() {
	
	  translate([-2, -45.4, 4.3])
	  rotate([0, 90, 0])
	  cylinder(h = 4, r1 = 4, r2 = 4, center = true, $fn = roundness);
	
	
	  translate([-2, -7.4, 47.3])
	  rotate([0, 90, 0])
	  cylinder(h = 4, r1 = 4, r2 = 4, center = true, $fn = roundness);
      }
      
      translate([-4, 0, 0])
	rotate([0, 90, 0])
	linear_extrude(height = 4)
	polygon(points = [[0, -15], [2, 3], [-46, -3.5], [-0.5, -47]]);
    }
    
    // the two mount holes in the bar
    translate([-2, -45.4, 4.3])
      rotate([0, 90, 0])
      cylinder(h = 4, r1 = 1.75, r2 = 1.75, center = true, $fn = roundness);
    
    translate([-2, -7.4, 47.3])
      rotate([0, 90, 0])
      cylinder(h = 4, r1 = 1.75, r2 = 1.75, center = true, $fn = roundness);   
  }

}

///// circular blow ring
module blow_ring() {
  rotate([0,0,55.75+90]) {
    difference() {
      union() {
	rotate_extrude(angle=248.5,convexity= 10) {
	  translate([25/2,0,0]) {
	    difference() {
	      // outside shape
	      hull() {
		translate([0,-3,0]) circle(d=0.1);
		translate([6,0,0])  circle(d=6);
		translate([7,0,0])  circle(d=6);
	      }
	      // inside shape
	      translate([5.5,0,0]) {
		hull() {
		  circle(d=4);
		  translate([1,0,0]) circle(d=4);
		}
	      }
	    }
	  }
	}
	rotate([0,0,0.01])translate([25/2,0,0]) end_cap();
	rotate([0,0,248.5-0.01])translate([25/2,0,0])scale([1,-1,1]) end_cap();
      }
      // blow holes
      union() {
	for (h=[0:360/16:248.5]) { // hole locations
	  rotate([0,0,h]) {
	    translate([12,0,-3.5])
	      rotate([0,62,0])
	      cylinder(h=12,d=2.5,center=true);
	  }
	}
      }
    }
  }
}

module end_cap() {
  difference() {
    hull() {
      translate([0,0,-3]) sphere(d=0.1);
      translate([6,0,0])  sphere(d=6);
      translate([7,0,0])  sphere(d=6);
    }
    union() {
      translate([5.5,0,0]) {
	hull() {
	  sphere(d=4);
	  translate([1,0,0]) sphere(d=4);
	}
      }
      translate([0,0,-10]) cube([20,20,20]);
    }
  }
}

//// square shroud
module blowShroudAdd() {

  rotate([0, 0, myAnglePos])
  rotate_extrude(angle = myTotAngle, $fn = roundness)
  translate([myRadius, 0, 0])
  intersection() {
    color("red")
      polygon(points = [[0, 0], [myShroudWidth, 0], [myShroudWidth, myShroudHeight], [0, myShroudHeight]]);
    
    translate([myShroudWidth / 2, myShroudHeight - myShroudWidth / 2, 0])
      union() {
      color("grey")
	circle(r = myShroudWidth /2);
      
      translate([-myShroudWidth / 2, -myShroudWidth / 2, 0])
	color("pink")
	polygon(points = [[0, 0], [myShroudWidth, 0], [myShroudWidth, myShroudWidth / 2], [0, myShroudWidth / 2]]);
    }
  }
}


module blowShroudSub() {

  translate([0, 0, 0])
  rotate([0, 0, myAnglePos + 3])
  rotate_extrude(angle = myTotAngle - 6, $fn = roundness)
  translate([myRadius, 0, 0])
    intersection() {
      color("green")
    polygon(points = [[myShroudWallThick, myShroudWallThick], [myShroudWidth - myShroudWallThick, myShroudWallThick], [myShroudWidth - myShroudWallThick, myShroudHeight - myShroudWallThick], [myShroudWallThick, myShroudHeight - myShroudWallThick]]);
      
        translate([myShroudWidth / 2, myShroudHeight - myShroudWidth / 2, 0])
	union() {
	  color("blue")
	  circle(r = myShroudWidth / 2 - myShroudWallThick);

	  translate([-myShroudWidth / 2, -myShroudWidth / 2, 0])
	    color("darkgrey")
	    polygon(points = [[myShroudWallThick, myShroudWallThick], [myShroudWidth - myShroudWallThick, myShroudWallThick], [myShroudWidth  - myShroudWallThick, myShroudWidth / 2], [myShroudWallThick, myShroudWidth / 2]]);
      }
    }
    
    
    translate([0, 0, 0])
  rotate([0, 0, -50])
    translate([0, -myHoleWidth / 2, myShroudWallThick])
    cube([myRadius + 5, myHoleWidth, myHoleHeight]);
    
    translate([0, 0, 0])
    rotate([0, 0, 195])
    translate([0, -myHoleWidth / 2, myShroudWallThick])
    cube([myRadius + 5, myHoleWidth, myHoleHeight]);
    
}


module singleBlowAdd() {
  scale([0.5, 1, 1])
    cylinder(h = 5, r1 = 8, r2 = 8, $fn = roundness);

  rotate([0, -14, 0])
  translate([-11, -8, -2])
    //color("azure", 0.25)
    cube([15, 16, 5]);

}

module singleBlowSub() {
  scale([0.5, 1, 1])
    cylinder(h = 5.2, r1 = 6, r2 = 6, $fn = roundness);

  rotate([0, -14, 0])
  translate([-12, -7, -1])
    cube([15, 14, 3]);
}


module triShroudAdd() {
  color("lightgreen")    
    rotate([0, 0, myAnglePos])
        rotate_extrude(angle = myTotAngle, $fn = roundness)
    translate([myRadius, 0, 0])
        //polygon(points = [[0, 0], [triShWidth, 0], [triShWidth, triShHeight / 2], [0, triShHeight]]);
    polygon(points = [[0, 0], [triShWidth, 0], [triShWidth, triShHeight], [0, triShHeight / 2]]);
}

module triShroudSub() {

  color("red")
    rotate([0, 0, myAnglePos + 2.5])
    translate([0, 0, -0.05])
    rotate_extrude(angle = myTotAngle - 5, $fn = roundness)
    translate([myRadius, 0, 0])
        //polygon(points = [[triShWallThick, triShWallThick], [triShWidth - triShHole - triShWallThick, triShWallThick], [triShWidth - triShHole - triShWallThick, 0], [triShWidth - triShWallThick, 0], [triShWidth - triShWallThick, triShHeight / 2 - triShWallThick * triShHeight / triShWidth], [triShWallThick, triShHeight - triShWallThick * triShWidth / triShHeight]]);
    polygon(points = [[triShWallThick, 0], [triShWallThick + triShHole, 0], [triShWallThick + triShHole, triShWallThick], [triShWidth - triShWallThick, triShWallThick], [triShWidth - triShWallThick, triShHeight - triShWallThick * triShWidth / triShHeight], [triShWallThick, triShHeight / 2 - triShWallThick * triShHeight / triShWidth]   ]);
}
