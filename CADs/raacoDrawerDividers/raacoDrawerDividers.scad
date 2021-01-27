// raacoDrawerDividers.scad

// Design: Jon Sagebrand
// jonsagebrand@gmail.com

// raaco

// Drawer dividers for:
// Drawer 150-00, 108980, Dimensions (H x W x D): 41 x 55 x 153 mm
// Drawer 150-01, 104692, Dimensions (H x W x D): 41 x 67 x 153 mm
// Drawer 150-02, 104715, Dimensions (H x W x D): 64 x 91 x 154 mm
// Drawer 150-03, 104708, Dimensions (H x W x D): 64 x 279 x 155 mm
// Drawer 150-04, 109178, Dimensions (H x W x D): 64 x 139 x 155 mm
// Drawer 250-01, 107273, Dimensions (H x W x D): 58 x 80 x 239 mm
// Drawer 250-02, 107259, Dimensions (H x W x D): 92 x 159 x 239 

// Not for:
// Drawer 250-03, 103114, Dimensions (H x W x D): 57 x 320 x 240 mm
// at the moment

// 0: Custom
// 1: Marked 35/52, Divider 150-00, 101981, Dimensions: 50/51 x 31 mm
// 2: Marked 57/87, Divider 150-02, 102032, Dimensions: 84,5/85,5 x 49 mm
// 3: Marked 57/135, Divider 150-03/04, 102049, Dimensions: 132/133,5 x 50 mm
// 4: Marked 35/?, Divider 150-01 large, 111386, Dimensions: 137 x 31 mm
// 5: Marked 35/?, Divider 150-01 medium, 101998, Dimensions: 62/63 x 31 mm
// 6: Marked 35/?, Divider 150-01 small, 111393, Dimensions: 32 x 31 mm 
// 7: Marked ?, Divider 250-01, 106757, Dimensions: 75 x 46 mm
// 8: Marked ?, Divider 250-02, 106764, Dimensions: 154 x 80 mm
dividerType = 1;

// slopes
// 0: no slopes
// 1: backside sloped
// 2: both sides sloped
slopeType = 1;

layerHeight = 0.2; // set this to your slicer's layer height, not essential, only used for a smooth slope
overExtrusionCompensation = 0.15;  // compensate for over extrusion

// text on the upper front
enableText = true;
myText = "UP";

///// custom type configuration
customWidth = 100; // if you set 'dividerType' to '0' above, these values are used
customHeight = 50;
customAngle = 3;
customTopRadius = 1.5;
customBottomRadius = 2;
customThickness = 1.8;
///// end of custom type

// text configuration
textFont = "Liberation Sans";
textSize = 5;

textDistFromTop = 5;
textDepth = 0.4;

///// here starts the configuration, most things are fine as they are

// slope configuration
slopeDepth = 10;
slopeHeight = 50; // percentage of the total height

// frame for divider
frameProtrusion = 1.6; // how much the frame sticks out from the drawers side
frameDepth = 1.1; // how deep is each protrusion


///// no editing below this line
height1 = 31;
height2 = 49;
height3 = 50;
height4 = 31;
height5 = 31;
height6 = 31;
height7 = 46;
height8 = 80;

height = dividerType == 0 ? customHeight :
  (dividerType == 1 ? height1 :
   (dividerType == 2 ? height2 :
    (dividerType == 3 ? height3 :
     (dividerType == 4 ? height4 :
      (dividerType == 5 ? height5 :
       (dividerType == 6 ? height6 :
	(dividerType == 7 ? height7 :
	 (dividerType == 8 ? height8 :
	  0))))))));

widthCompensation = -overExtrusionCompensation * 2;

width1 = 50.5;
width2 = 85;
width3 = 132.5;
width4 = 137;
width5 = 62.5;
width6 = 32;
width7 = 75;
width8 = 154;

width = dividerType ==	0 ? customWidth :
  (dividerType == 1 ? width1 + widthCompensation :
   (dividerType == 2 ? width2 + widthCompensation : 
    (dividerType == 3 ? width3 + widthCompensation :
     (dividerType == 4 ? width4 + widthCompensation :
      (dividerType == 5 ? width5 + widthCompensation :
       (dividerType == 6 ? width6 + widthCompensation :
	(dividerType == 7 ? width7 + widthCompensation :
	 (dividerType == 8 ? width8 + widthCompensation :
	  0))))))));

defaultThickness = 1.6;
defaultAngle = 0.8;
defaultBottomRadius = 1.5;
defaultTopRadius = 2;

thicknessCompensation = -overExtrusionCompensation * 2; // compensate for over extrusion

thickness = dividerType ==  0 ? customThickness : defaultThickness + thicknessCompensation;
angle = dividerType ==  0 ? customAngle : defaultAngle;
bottomRadius = dividerType ==  0 ? customBottomRadius : defaultBottomRadius;
topRadius = dividerType ==  0 ? customTopRadius : defaultTopRadius;

bottomInset = height * tan(angle);

frameXCompensation = overExtrusionCompensation; // compensate for over extrusion
frameYCompensation = overExtrusionCompensation * 2; // compensate for over extrusion
frameX = frameProtrusion + frameXCompensation;
frameY = frameDepth + frameYCompensation;

roundness = 100;

///// start to draw
echo("Width: ", width);
echo("Height: ", height);
echo("Thickness: ", thickness);

difference() {
  union() {
    if (!slopeType) { // draw divider laying flat
      drawPolygon(thickness);
    } else {

      difference() {
	union() {
	  intersection() { // make divider and slopes, with angles
	    translate([0, slopeDepth, 0])
	      rotate([90, 0, 0])
	      drawPolygon(slopeDepth * 2);
	    slopes();
	  }
	  translate([0, thickness / 2, 0]) // make divider again, as the top part was deleted
	    rotate([90, 0, 0])
	    drawPolygon(thickness);
	}
 
	// delete frame
	if (slopeType) {
	  frames();
	}
      }     
    }
  }

if (enableText && (slopeType)) {
  rotate([90, 0, 0])
    translate([0, 0, -thickness / 2])
    drawText();
 } else if (enableText) {
  drawText();
 }
}
module drawPolygon(polygonExtrude) {
  
  linear_extrude(height = polygonExtrude)
  union() {
  color("lightgreen")
    polygon(points = [[bottomInset + bottomRadius, 0], 
		      [width - bottomInset - bottomRadius, 0], 
		      [width - bottomInset, bottomRadius], 
		      [width, height - topRadius], 
		      [width - topRadius, height],
		      [topRadius, height],
		      [0, height - topRadius],
		      [bottomInset, bottomRadius]]);

  translate([bottomRadius + bottomInset, bottomRadius, 0])
    color("red")
    circle(r = bottomRadius, $fn = roundness);

  translate([width - bottomRadius - bottomInset, bottomRadius, 0])
    color("red")
    circle(r = bottomRadius, $fn = roundness);

  translate([width - topRadius, height - topRadius, 0])
    color("red")
    circle(r = topRadius, $fn = roundness);

  translate([topRadius, height - topRadius, 0])
    color("red")
    circle(r = topRadius, $fn = roundness);
  }
}

module drawText() {

  recess = slopeType == 0 ? textDepth : slopeDepth;
  translate([width / 2, height - textDistFromTop, thickness - textDepth])
    linear_extrude(height = recess)
    text(text = str(myText), font = textFont, size = textSize, halign = "center", valign = "top");
  
}

module slopes() {
  steps = height * slopeHeight / 100 / layerHeight;
  echo("Steps: ", steps);

  // exponential decay formula:
  // y = a * pow(k, t)
  //
  // y, final amount remaining after the decay over a period of time
  // a, the original amount
  // k, decay factor, where b is percent change in decimal, ie 2(%), 3(%) e
  // t, time
  //
  // k = pow(y / a, 1 / t)
  //
  // this translates to:
  // y <=> stepDepth
  // a <=> slopeDepth
  // t <=> stepNo
  //
  // stepDepth = slopeDepth * pow(k, stepNo)
  //
  // so we have to calculate k, when stepDepth is half ofthickness and stepNo is maximum (steps):
  
  k = pow((thickness / 2) / slopeDepth, 1 / steps);
  //k = (pow(thickness / 2 / slopeDepth, 1 / steps) + 2.1) / 100;
  
  echo("Decay: ", k);

  difference() {

    
    for (slopeStep = [0 : layerHeight : height * slopeHeight / 100]) {
 
      stepWidth = width;

      stepDepth = slopeDepth * pow(k, slopeStep / layerHeight); 
            
      // echo("Step: ", slopeStep / layerHeight, ", CurrentHeight: ", slopeStep, "Depth: ", stepDepth);
      
      translate([0, 0, slopeStep])
	color("lightgrey")
	linear_extrude(height = layerHeight)
	square(size = [stepWidth, stepDepth]);

      if (slopeType == 2) {
	translate([0, -stepDepth, slopeStep])
	  color("lightgreen")
	  linear_extrude(height = layerHeight)
	  square(size = [stepWidth, stepDepth]);
      }
    }

  }

  //echo(exp(ln(2) * 4)); // 2 to the power of 4
}

module frames() {
  for (y = [0 : 1 : 1]) {
    translate([bottomInset, -frameY - thickness / 2 + y * (thickness + frameY), 0])
      rotate([0, -angle, 0])
      color("red")
      cube([frameX, frameY, height]);
  }

  for (y = [0 : 1 : 1]) {
    translate([width - frameX - bottomInset, -frameY - thickness / 2 + y * (thickness + frameY), 0])
      rotate([0, angle, 0])
      color("blue")
      cube([frameX, frameY, height]);
  }
}
