// ardAVRProgrammer_enclosure.scad

// Design: Jon Sagebrand
// jonsagebrand@gmail.com

// pin headers by Niccolo Rigacci <niccolo@rigacci.org>

// arduino module by ?
include <../../OpenSCADlibraries/Arduino.scad>

// LED module by ?
include <../../OpenSCADlibraries/led.scad>

// NOP scad library by nophead, https://github.com/nophead/NopSCADlib
include <../../OpenSCADlibraries/NopSCADlib/vitamins/dip.scad>

// shield modules
include <shieldType1.scad>
// misc components
include <../../OpenSCADlibraries/ZIFs.scad>
// pin headers
include <../../OpenSCADlibraries/pinHeaders.scad>

// lay out for printing
print = false;

showBottom = true;
showLid = false;

// show arduino board and shield
showArd = true;
showShield = true;

// shield type
// 0: no shield
// 1: ardAVRProgrammer
shieldType = 0;

// make the hole for the arduino power input
powHole = false;

// arduino stand offs
soBotHeight = 4;
soBotDia = 8;

soTopHeight = 1;
soTopDia = 5;

ardMountHoleDia = 2.5;

ardPosts = [[14, 2.5, soBotHeight / 2], 
            [66.1, 7.6, soBotHeight / 2], 
            [66.1, 35.5, soBotHeight / 2], 
            [15.3, 50.7, soBotHeight / 2]];

// arduino uno dimensions
ardWidth = 68.6;
ardDepth = 53.3;
ardHeight = 10.9 + 1.6;

// casing
casWallThick = 1.5;

extraWidthL = shieldType == 0 ? 2 : (shieldType == 1 ? 1 : 5 );
extraWidthR = shieldType == 0 ? 2 : (shieldType == 1 ? 18.5 : 5 );
extraDepthD = shieldType == 0 ? 6 : (shieldType == 1 ? 6.5 : 5 );
extraDepthU = shieldType == 0 ? 6 : (shieldType == 1 ? 12 : 5 );

extraHeight = shieldType == 0 ? 2 : (shieldType == 1 ? 5 : 5 );

// casing lid
lidInset = 2;
lidOffset = 0;

lidScrewHoleDia = 2.5;
lidScrewPostDia = 7;
lidScrewHoleDepth = 7;

lidThick = 1.5;

lidHoleDia = 3.5;

lidRidgeWidth = 2;

tolerance = 0.2;

///// no editing below this line
roundness = 100;

// calculations of casing outer boundaries                                     
casXL = -casWallThick - extraWidthL;
casXR = ardWidth + extraWidthL + extraWidthR + casWallThick * 2 + casXL;
casYD = -casWallThick - extraDepthD;
casYU = ardDepth + extraDepthD + extraDepthU + casWallThick * 2 + casYD;

// lid screw posts                                                             
postsY = soBotHeight + soTopHeight + ardHeight + extraHeight - lidScrewHoleDepth / 2 - lidInset;

lidPostsPos = [[casXL + lidScrewPostDia / 2 + lidOffset, 
                casYD + lidScrewPostDia / 2 + lidOffset, 
                postsY],
	       [casXR - lidScrewPostDia / 2 - lidOffset, 
                casYD + lidScrewPostDia / 2 + lidOffset, 
                postsY],
	       [casXR - lidScrewPostDia / 2 - lidOffset, 
                casYU - lidScrewPostDia / 2 - lidOffset, 
                postsY],
	       [casXL + lidScrewPostDia / 2 + lidOffset, 
                casYU - lidScrewPostDia / 2 - lidOffset, 
                postsY]];

dropPos = [[casXL + casWallThick, 
            casYD + casWallThick, 
            postsY - lidScrewHoleDepth * 1.5],
	   [casXR - casWallThick, 
            casYD + casWallThick, 
            postsY - lidScrewHoleDepth * 1.5],
	   [casXR - casWallThick, 
            casYU - casWallThick, 
            postsY - lidScrewHoleDepth * 1.5],
	   [casXL + casWallThick, 
            casYU - casWallThick, 
            postsY - lidScrewHoleDepth * 1.5]];

////////// the drawing //////////

if ((showArd) && (!print)) {
  translate([0, 53.3, soBotHeight + soTopHeight])
    rotate([0, 0, -90])
    arduinoUno();
 }

if ((showShield) && (!print) && (shieldType)) {
  if (shieldType == 1) {
    translate([0.45, 0.35, 17.9])
      shieldType1();
  }
}

union() {
  if (showBottom) {
    ardMountPosts();
    bottomCasing();
  }
}

//ardMountPosts();
if (showLid) {
  if (print) {
    rotate([180, 0, 0])
      translate([0, 30, 0])
      difference() {
        lid();
        if (shieldType == 1) {
          lidOpeningsType1();
        }
      }
  } else {
    translate([0, 0, soBotHeight + soTopHeight + ardHeight + extraHeight])
    difference() {
      lid();
      if (shieldType == 1) {
        lidOpeningsType1();
      }
    }
  }
 }

module ardMountPosts() {
  for (i = [0 : 1 : 3]) { 
    
    translate(ardPosts[i])
      difference() {
      union() {
	color("blue")
	  cylinder(h = soBotHeight, r1 = soBotDia / 2, r2 = soTopDia / 2, 
		   center = true, $fn = roundness);
	
	color("green")
	  translate([0, 0, soBotHeight / 2 + soTopHeight / 2])
	  cylinder(h = soTopHeight, r1 = soTopDia / 2, r2 = soTopDia / 2, 
		   center = true, $fn = roundness);
	
      }
      
      color("red")
	translate([0, 0, soBotHeight / 2])
        cylinder(h = soBotHeight + soTopHeight, 
		 r1 = ardMountHoleDia / 2, r2 = ardMountHoleDia / 2, 
		 center = true, $fn = roundness);
      
    }
  }
}

module bottomCasing() {
  
  union() {
    translate([-extraWidthL - casWallThick, -extraDepthD - casWallThick, -casWallThick])
      difference() { // bottom part
      color("lightgrey")
	cube([ardWidth + extraWidthL + extraWidthR + casWallThick * 2, 
	      ardDepth + extraDepthD + extraDepthU + casWallThick * 2, 
	      soBotHeight + soTopHeight + ardHeight + casWallThick + extraHeight]);
      
      translate([casWallThick, casWallThick, casWallThick + 0.01])
	color("red")
	cube([ardWidth + extraWidthL + extraWidthR, 
	      ardDepth + extraDepthD + extraDepthU, 
	      soBotHeight + soTopHeight + ardHeight + extraHeight]);
      
      // usb port
      translate([0, 30.2 + casWallThick + extraDepthD, 
		 casWallThick + soBotHeight + soTopHeight])
	color("red")
	cube([casWallThick, 12 + 2, 10.9 + 2]);
      
      // power supply
      if (powHole) {
	translate([0, 3.3 + casWallThick + extraDepthD, 
		   casWallThick + soBotHeight + soTopHeight + 2])
	  union() {
	  //color("red")
	  //cube([casWallThick, 8.9 + 2, 8.9 / 2 + 1]);
	  
	  translate([0, 8.9 / 2 + 1, 8.9 / 2 + 1])
	    rotate([0, 90, 0])
	    cylinder(h = casWallThick, r1 = 8.9 / 2 + 1, r2 = 8.9 / 2 + 1, $fn = roundness);
	}
      }
    }
    
    // lid screw posts
    translate([0, 0, 0])
      for (j = [0 : 1 : 3]) {
	difference() {
	  hull() {
	    translate(lidPostsPos[j])
	      cylinder(h = lidScrewHoleDepth, 
		       r1 = lidScrewPostDia / 2, r2 = lidScrewPostDia / 2, 
		       center = true, $fn = roundness);
	    
	    translate(dropPos[j])
	      cylinder(h = 0.1, r1 = 0.1, r2 = 0.1, center = true, $fn = roundness);
	    
	  }
	  
	  // screw Holes
	  translate(lidPostsPos[j])
	    color("red")
	    cylinder(h = lidScrewHoleDepth, 
		     r1 = lidScrewHoleDia / 2, r2 = lidScrewHoleDia / 2, 
		     center = true, $fn = roundness);
	}
      }    
  }
}


module lid() {
  translate([-extraWidthL - casWallThick, -extraDepthD - casWallThick, 0])
    difference() {
    union() {
      color("grey") // upper side
	cube([ardWidth + extraWidthL + extraWidthR + casWallThick * 2, 
	      ardDepth + extraDepthD + extraDepthU + casWallThick * 2, 
	      lidThick]);
      
      difference() { // ridges under lid
	translate([casWallThick + tolerance, casWallThick + tolerance, -lidInset + tolerance])
	  color("green")
	  cube([ardWidth + extraWidthL + extraWidthR + casWallThick * 2 -casWallThick * 2 - tolerance * 2, 
		ardDepth + extraDepthD + extraDepthU + casWallThick * 2 -casWallThick * 2 - tolerance * 2, 
		lidInset - tolerance]);
	
	translate([casWallThick + tolerance + lidRidgeWidth, 
		   casWallThick + tolerance + lidRidgeWidth, 
		   -lidInset + tolerance])
	  color("red")
	  cube([ardWidth + extraWidthL + extraWidthR + casWallThick * 2 -casWallThick * 2 - lidRidgeWidth* 2 - tolerance * 2, 
		ardDepth + extraDepthD + extraDepthU + casWallThick * 2 -casWallThick * 2 - lidRidgeWidth * 2 - tolerance * 2, 
		lidInset - tolerance]);
      }
    }
    
    // screw holes
    for (i = [0 : 1 : 3]) {
      translate([extraWidthL + casWallThick, 
		 extraDepthD + casWallThick, 
		 -postsY - lidThick / 2 + lidInset / 2 - tolerance * 2])
	translate(lidPostsPos[i])
  color("red")
	cylinder(h = lidThick + lidInset, 
		 r1 = lidHoleDia / 2, r2 = lidHoleDia / 2, 
		 center = true, $fn = roundness);
    }
  }
}


