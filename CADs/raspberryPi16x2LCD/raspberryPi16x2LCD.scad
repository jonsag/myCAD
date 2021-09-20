// raspberryPi16x2LCD.scad

include <raspberryPi16x2LCD-config.scad>

///// Draw

// draw RPi
if (!print) {
  drawRPi();
 }

// draw the bottom part of the box
if (printBottom) {
  union() {
    // draw the stands for RPi
    drawRPiStands();
    
    // draw bottom part of box
    drawBoxBottom();
  }
 }

// draw the box's lid
if (printLid) {
  union() {
    // draw the lid
    drawLid();
    
    if (hasLCD) {
      translate([LCDXOffset + extraXPlus / 2 - extraXMinus / 2,
		 LCDYOffset + extraYPlus / 2 - extraYMinus / 2,
		 raspHeight + raspExtraHeight + extraZ + wallThickness + lidRecess + LCDProtrusion + 2]) {
	// draw LCD
	if (!print) {
	  drawLCD();
	}
      }
    }
    
    if (hasButtons) {
      // draw buttons
      if (!print) {
	drawButtons();
      }
    }
  }
 }

////////////////////////////////////////////////// RPi module
module drawRPi() {
  translate([0, 0, 0])
    pcb(RPI3);
}

////////////////////////////////////////////////// RPi stands
module drawRPiStands() {

  translate([0, 0, 0])
  for (i = [0 : 1 : 3]) {

    translate(postPos[i]) {
      if ((hasInserts) && (!print)) {
	translate([0, 0, mountPostHeight / 2 + mountPostTopHeight])
	  insert(F1BM3);
	}
      if (!print) {
	translate([0, 0, mountPostHeight / 2 + mountPostTopHeight + 1.6])
	  screw(M3_cap_screw, 6);
	  }
      difference() {
	union() {
	  // lowest part of the post, conical
	  color("blue")
	    cylinder(h = mountPostHeight, d1 = mountPostDia, d2 = mountPostTopDia,
		     center = true, $fn = roundness);
	  
	  // top part of the post
	  color("green")
	    translate([0, 0, mountPostHeight / 2 + mountPostTopHeight / 2])
	    cylinder(h = mountPostTopHeight, d1 = mountPostTopDia, d2 = mountPostTopDia,
		     center = true, $fn = roundness);
	  
	}
	
	// screw hole
	color("red")
	  translate([0, 0, mountPostTopHeight / 2])
	  cylinder(h = mountPostHeight + mountPostTopHeight + 0.2,
		   d1 = mountHoleDia, d2 = mountHoleDia,
		   center = true, $fn = roundness);
      }
    }
  }
}

///////////////////////////////////////////////// bottom part
module drawBoxBottom() {
  translate([extraXPlus / 2 - extraXMinus / 2,
	     extraYPlus / 2 - extraYMinus / 2,
	     boxHeight / 2 - mountPostHeight - mountPostTopHeight - wallThickness]) {

    difference() {
      // box outer shell
      cube([boxWidth, boxDepth, boxHeight], center = true);
      
      // the hollow
      translate([0, 0, wallThickness / 2])
	color("red")
	cube([boxWidth - wallThickness * 2,
	      boxDepth - wallThickness * 2,
	      boxHeight - wallThickness + 0.1], center = true);
      
      // cutouts in the shell
      RPiCutOuts();
    }
  }

  translate([extraXPlus / 2 - extraXMinus / 2,
	     extraYPlus / 2 - extraYMinus / 2,
	     0]) {
    
    // lid mounts
    for (i = [0 : 1 : 3]) {
      translate(lidMountPos[i]) {
	if ((hasInserts) && (!print)) {
	  translate([0, 0, lidMountHeight / 2])
	    insert(F1BM3);
        }
	color("green")
	  union() {
	  difference() {
	    cylinder(h = lidMountHeight, d = lidMountDia, center = true, $fn = roundness);
	    
	    color("red")
	      cylinder(h = lidMountHeight + 0.2, d = lidMountScrewDia, center = true, $fn = roundness);
	  }
	}
      }
    }
    
    // conical bottom part
    for (i = [0 : 1 : 3]) {
      color("blue")
	hull() {
	
	// small low part
	translate(boxBottomCornersPos[i])
	  linear_extrude(height = 1, center = true)
	  circle(d = 0.1);
	
	// large upper part
	translate([0, 0, - lidMountHeight / 2 - 0.5])
	  translate(lidMountPos[i])
	  translate([0, 0, 0])
	  linear_extrude(height = 1, center = true)
	  circle(d = lidMountDia);
      }
    }
  }
}

///////////////////////////////////////////////// RPi cutouts
module RPiCutOuts() {
  translate([- raspWidth / 2 - extraXPlus / 2 + extraXMinus / 2,
	     - raspDepth / 2 + extraYMinus / 2 - extraYPlus / 2 - cutOutDepthY / 2,
	     - boxHeight / 2 + mountPostHeight + mountPostTopHeight + wallThickness]) {

    // Power in
    translate([10.6, 0,  3 / 2 + 1.6])
    color("red")
    cube([pwWidth, cutOutDepthY, pwHeight], center = true);

    // HDMI
    translate([32, 0,  6.5 / 2 + 1.6])
      color("red")
      cube([hdmiWidth, cutOutDepthY, hdmiHeight], center = true);
    
    // Phono
    translate([53.5, 0, 6 / 2 + 1.6])
      rotate([90, 0, 0])
      color("red")
      cylinder(h = cutOutDepthY, d = phonoDia, center = true, $fn = roundness);
  }

  translate([- raspWidth / 2 + cutOutDepthX / 2 + extraXMinus / 2 - extraXPlus / 2,
	     - raspDepth / 2 - extraYPlus / 2 + extraYMinus / 2,
	     - boxHeight / 2 + mountPostHeight + mountPostTopHeight + wallThickness]) {
    
    // Ethernet
    translate([85, 10.25, 13.5 / 2 + 1.6])
      color("red")
      cube([cutOutDepthX, ethernetWidth, ethernetHeight], center = true);
    
    // USB1
    translate([85, 29, 16 / 2 + 1.6])
      color("red")
      cube([cutOutDepthX, usbWidth, usbHeight], center = true);
    
    // USB2
    translate([85, 47, 16 / 2 + 1.6])
      color("red")
      cube([cutOutDepthX, usbWidth, usbHeight], center = true);
  }
}

///////////////////////////////////////////////// LCD
module drawLCD() {
  translate([0, 0, 0])
    rotate([0, 180, 0])
    display(LCD1602A);
}

///////////////////////////////////////////////// LCD stands
module drawLCDStands() {
  translate([0, 0, 0])
  for (i = [0 : 1 : 3]) {
    
    translate(LCDMountPos[i])
      difference() {
      color("blue")
	cylinder(h = postHeightDisp, d = postDiaDisp,
		 center = true, $fn = roundness);
   
      color("red")
	cylinder(h = postHeightDisp + 0.2,
		 d = mountHoleDiaDisp,
		 center = true, $fn = roundness);      
    }
  }
}
///////////////////////////////////////////////// lid
module drawLid() {

  lidPosX = print ? 0 : extraXPlus / 2 - extraXMinus / 2;
  lidPosY = print ? - boxDepth - 5 : extraYPlus / 2 - extraYMinus / 2;
  lidPosZ = print ? -mountPostHeight - mountPostTopHeight -wallThickness / 2 : boxHeight - wallThickness - mountPostHeight - mountPostTopHeight + wallThickness / 2;

  lidRotateY = print ? 180 : 0;

  translate([lidPosX, lidPosY, lidPosZ]) {
    rotate([0, lidRotateY, 0]) {
      difference() {

	union() {
	  // top part of lid
	  color("lightgreen")
	    cube([boxWidth, boxDepth, wallThickness], center = true);
	  
	  // underside of lid
	  translate([0, 0, -wallThickness / 2 - lidRecess / 2])
	    color("orange")
	    cube([boxWidth - wallThickness * 2 - 0.2, boxDepth - wallThickness / 2 - 0.2, lidRecess], center = true);
	  
	  if (hasLCD) {
	    // draw the posts for the LCD
	    translate([LCDXOffset,
		       LCDYOffset,
		       LCDProtrusion + 1])
	      drawLCDStands();
	  }
	} // end of the union, parts created
      
	// screw holes
	translate([0,
		   0,
		   -lidMountPosZ - lidRecess / 2])
	  for (i = [0 : 1 : 3]) {
	    translate(lidMountPos[i])
	      color("red")
	      cylinder(h = wallThickness + lidRecess + 0.2, d = lidScrewHoleDia , center = true, $fn = roundness);
	  }
	
	// LCD cutout
	if (hasLCD) {
	  translate([LCDXOffset + displayXOffset + extraXPlus / 2 - extraXMinus / 2,
		     LCDYOffset + displayYOffset + extraYPlus / 2 - extraYMinus / 2,
		     -lidRecess / 2])
	    color("red")
	    cube([displayWidth + displayExtra, displayDepth + displayExtra, wallThickness + lidRecess + 0.2], center = true);
	}
	
	translate([0,
		   0,
		   - raspHeight - raspExtraHeight - extraZ - wallThickness / 2 - lidRecess - 2])
	  if (hasButtons) {
	    // button holes
	    makeButtonHoles();
	    
	    // button texts
	    drawButtonTexts();
	  }
      } 
    }
  } // end of the difference, holes made
  
  // screws
  if (!print) {
    translate([extraXPlus / 2 - extraXMinus / 2,
	       extraYPlus / 2 - extraYMinus / 2,
	       -lidMountPosZ + raspHeight + raspExtraHeight + extraZ + wallThickness + lidRecess + 2])
      for (i = [0 : 1 : 3]) {
	translate(lidMountPos[i])
	  translate([0, 0, 0])
	  screw(M3_cap_screw, 10);
      }
  }
}

///////////////////////////////////////////////// draw buttons
module drawButtons() {
  
  for (i = [0 : 1 : buttonsCount - 1]) {
    translate([-extraXMinus / 2 + extraXPlus / 2 - boxWidth / 2 + boxWidth / (buttonsCount + 1) + i * (boxWidth / (buttonsCount + 1)) + buttonsXOffset,
	       -extraYMinus / 2 + extraYPlus / 2 + buttonsYOffset,
	       raspHeight + raspExtraHeight + extraZ + 2])
      pushButton(wallThickness + lidRecess, buttonColor[i]);
  }
}

///////////////////////////////////////////////// button holes
module makeButtonHoles() {
  for (i = [0 : 1 : buttonsCount - 1]) {
    translate([-extraXMinus / 2 + extraXPlus / 2 - boxWidth / 2 + boxWidth / (buttonsCount + 1) + i * (boxWidth / (buttonsCount + 1)) + buttonsXOffset,
               -extraYMinus / 2 + extraYPlus / 2 + buttonsYOffset,
               raspHeight + raspExtraHeight + extraZ + wallThickness / 2 + lidRecess / 2 + 2])
      color("red")
      cylinder(h = wallThickness + lidRecess + 0.2, d = buttonDia, center = true, $fn = roundness);
  }
}

///////////////////////////////////////////////// draw button texts
module drawButtonTexts() {
  for (i = [0 : 1 : buttonsCount - 1]) {
    translate([-extraXMinus / 2 + extraXPlus / 2 - boxWidth / 2 + boxWidth / (buttonsCount + 1) + i * (boxWidth / (buttonsCount + 1)) + buttonsXOffset,
               -extraYMinus / 2 + extraYPlus / 2 + textYOffset,
               raspHeight + raspExtraHeight + extraZ + wallThickness * 0.75 + lidRecess + 2])
      color("red")
      linear_extrude(height = wallThickness / 2 + 0.1, center = true, convexity = 10, twist = 0)
      text(text = str(buttonTexts[i]), font = font, size = textSize, halign = "center");
  }
}

///////////////////////////////////////////////// the button itself
module pushButton(wallThickness, bColor = "blue") {
  union() {
    translate([0, 0, 6.4 + 2.9 + 3.5 / 2]) // button top part
      color(bColor)
      cylinder(3.5, 2.9, 2.9, $fn = 100, center = true);
    
    translate([0, 0, 6.4 + 2.9 / 2]) // metallic part of button
      color("LightGrey")
      cylinder(2.9, 2.15, 2.15, $fn = 100, center = true);
    
    translate([0, 0, wallThickness + 2 / 2]) // nut
      color("LightGrey")
      cylinder(2, 5.05, 5.05, $fn = 6, center = true);
    
    translate([0, 0, 6.4 / 2]) // threaded part
      color("LightGrey")
      cylinder(6.4, 3.4, 3.4, $fn = 100, center = true);
    
    translate([0, 0, - 1 / 2]) // spring washer, top of this is at Z = 0
      difference() {
      color("LightGrey")
	cylinder(1, 5, 5, $fn = 100, center = true);
      cylinder(1, 3.55, 3.55, $fn = 100, center = true);
    }
    
    translate([0, 0, - 1 - 2 / 2])
      color("LightGrey")
      cylinder(2, 4.75, 4.75, $fn = 100, center = true);
    
    translate([0, 0, - 1 - 2 - 7.4 / 2]) 
      color("Black")
      cylinder(7.4, 3.35, 3.35, $fn = 100, center = true);
    
    difference() { // wire connections
      union() {
	translate([-1.5, 0, -1 - 2 - 7.4 - 5 / 2])
	  color("LightGrey")
	  cube([0.5, 2, 5], center = true);
	
	translate([-1.5, 0, -1 - 2 - 7.4 - 5])
	  rotate([0, 90, 0])
	  color("LightGrey")
	  cylinder(0.5, 1, 1, $fn = 100, center = true);
	
	translate([1.5, 0, -1 - 2 - 7.4 - 5 / 2])
	  color("LightGrey")
	  cube([0.5, 2, 5], center = true);
	
	translate([1.5, 0, -1 - 2 - 7.4 - 5])
	  rotate([0, 90, 0])
	  color("LightGrey")
	  cylinder(0.5, 1, 1, $fn = 100, center = true);
      }
      translate([-1.5, 0, -1 - 2 - 7.4 - 5])
	rotate([0, 90, 0])
	cylinder(0.5, 0.5, 0.5, $fn = 100, center = true);
      
      translate([1.5, 0, -1 - 2 - 7.4 - 5])
	rotate([0, 90, 0])
	cylinder(0.5, 0.5, 0.5, $fn = 100, center = true);
    }
  }
}
