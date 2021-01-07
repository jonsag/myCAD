// Knurled knob.scad

// knob dimensions
knobDia = 30;
knobDiaTop = 27; // if knob is cone shaped
knobHeight = 15;

// knob's bottom part
knobBottomDia = 32; // only makes sense if larger than knobDia
knobBottomDiaTop = 30;
knobBottomHeight = 3; // this will be added to knobHeight, enter 0 for no bottom part

// outer ridges on knob
outerRidged = true; // should we have a ridged knob for better grip
outerRidgeAngle = 30; // not larger than 60 degrees
noOfOuterRidges = 60;
outerRidgesHeight = 8; // height if the outer ridges
outerRidgesProtrution = 0.8; // how high will the ridges be
outerRidgesOffset = 0; // adjust this to move the ridges up and down on the knob

// spherical indent on top, good for fast rotating
makeTopIndent = true;
topIndentDia = 10;
topIndentOffset = 7; // the indents center distance from knob edge
topIndentDepth = 3;
rotateTopIndentAngle = 135; // rotate CW, when 0 indent is up

// the shaft hole
shaftType = 2; // 0 = round shaft, 1 = D-shape shaft, 2 = detented shaft

shaftDia = 6.3;
shaftDepth = 14;
shaftOversize = 0.6; // make the hole a bit bigger or smaller

DSize = 4.5; // if d-shaped shaft, the smallest 'dia' on it
rotateDAngle = 0; // rotate the d cutout CW, when 0 flat face face up

detentsAngle = 60; // detented shaft
noOfDetents = 20;
shaftInnerDia = 6;

// hollow out the bottom
hollowBottom = true;
hollowDia = 26;
hollowDepth = 3;

// shaft that sticks out from the bottom
extraShaftLength = 0; // set to 0 for no extra shaft
extraShaftDia = 10;

// pointer
pointer = 0; // 0 = no point, 1 = pointy, 2 = blocky
pointerLength = 4;
pointerHeight = knobHeight / 2;//+ knobBottomHeight; //4;

pointerAngle = 60; // when creating a pointy pointer

pointerWidth = 4; // when creating a blocky pointer
pointerLengthTop = 4;

// misc parameters, not much to change below, if you don't know what you are doing
roundness = 100;
alphaValue = 1.0; // just ignore this
isCenter = true;


// ########## start drawing ##########

union() {
  difference() {
    union() {
      // main body
      knobMainBody();
      
      // knob outer ridges
      if (outerRidged) {
	outerRidges();
      }
      
      // pointer
      makePointer();
      
    }
    
    // indent on top
    if (makeTopIndent) {
      topIndent();
    }
    
    // hollow out the bottom
    if (hollowBottom) {
      makeHollow();
    }

    if (extraShaftLength == 0) {
      shaftHole();
    }
  }

  if (extraShaftLength > 0) {
    difference() {
      // a longer shaft
      extraShaft();
      
      // shaft hole
      shaftHole();
    }
  }
}
  

module knobMainBody() {
  union() {
    // top part of knob
    translate([0, 0, 0])
      color("grey", alpha = alphaValue)
      cylinder(h = knobHeight, r1 = knobDia / 2, r2 = knobDiaTop / 2, center = true, $fn = roundness);

    // bottom part of knob
    translate([0, 0, -knobHeight / 2 - knobBottomHeight / 2])
      color("black", alpha = alphaValue)
      cylinder(h = knobBottomHeight, r1 = knobBottomDia / 2, r2 = knobBottomDiaTop / 2, center = true, $fn = roundness);
      
  }
}

module topIndent() {
  // calculate the radius of the sphere
  sphRad = ((topIndentDia / 2) * (topIndentDia / 2) + topIndentDepth * topIndentDepth) / (2 * topIndentDepth);

  rotate([0, 0, -rotateTopIndentAngle])
    translate([0, knobDia / 2 - topIndentOffset, knobHeight / 2 + sphRad - topIndentDepth])
    sphere(r = sphRad, $fn = roundness);
}

module shaftHole() {
  translate([0, 0, -knobHeight / 2 - knobBottomHeight + shaftDepth / 2 - extraShaftLength])

    if ((shaftType == 0) || (shaftType == 1)) { // round shaft
      difference() {
	cylinder(h = shaftDepth, r1 = (shaftDia + shaftOversize) / 2, r2 = (shaftDia + shaftOversize)/ 2, center = true, $fn = roundness);
	
	if (shaftType == 1) { // remove the d-part
	  rotate([0, 0, -rotateDAngle])
	    translate(v = [0, (shaftDia + shaftOversize) / 2 - (shaftDia + shaftOversize - DSize) / 2 + shaftOversize / 2, 0])
	    cube([shaftDia + shaftOversize, shaftDia + shaftOversize - DSize, shaftDepth], center = true);
	}
	}
      
    } else { // detented shaft

      dPoint = ((shaftDia + shaftOversize - shaftInnerDia) / 2) * tan(detentsAngle / 2); // calculate the point based on the given angle

      for (j = [1 : 1 : noOfDetents]) {
	rotate([0, 0, j * 360 / noOfDetents])
	  linear_extrude(height = shaftDepth, center = true)
	  polygon([[dPoint, shaftInnerDia / 2], [0, (shaftDia + shaftOversize) / 2], [-dPoint, shaftInnerDia / 2]]);
      }

      cylinder(h = shaftDepth, r1 = shaftInnerDia / 2, r2 = shaftInnerDia / 2, center = true, $fn = roundness);
      
    }
}

module outerRidges() {
  echo("Will do ", noOfOuterRidges / (180 / outerRidgeAngle), " turns");
  echo("     at ", 360 / noOfOuterRidges, " degrees every turn");
  echo("This will make ", noOfOuterRidges / (180 / outerRidgeAngle) * 180 / outerRidgeAngle, " ridges");
  
  translate([0, 0, outerRidgesOffset])
    color("orange", alpha = alphaValue)
    difference() {
    // add the ridges
    for(i = [0 : 1 : noOfOuterRidges / (180 / outerRidgeAngle) - 1]) {
      rotate([0, 0, i * 360 / noOfOuterRidges])
	cylinder(h = knobHeight, r1 = knobDia / 2 + outerRidgesProtrution, r2 = knobDiaTop / 2 + outerRidgesProtrution, center = true, $fn = 180 / outerRidgeAngle);
    }   
    
    // subtract top and bottom
    translate([0, 0, -knobHeight / 2 + (knobHeight - outerRidgesHeight) / 4])
      color(alpha = 0.5)
      cylinder(h = (knobHeight - outerRidgesHeight) / 2 , r1 = max(knobDia, knobDiaTop) / 2 + outerRidgesProtrution, r2 = max(knobDia, knobDiaTop) / 2+ outerRidgesProtrution, center = true, $fn = roundness);

    translate([0, 0, knobHeight / 2 - (knobHeight - outerRidgesHeight) / 4])
      color(alpha = 0.5)
      cylinder(h = (knobHeight - outerRidgesHeight) / 2 , r1 = max(knobDia, knobDiaTop) / 2 + outerRidgesProtrution, r2 = max(knobDia, knobDiaTop) / 2 + outerRidgesProtrution, center = true, $fn = roundness);
    
  }
}

module makeHollow() {
  translate([0, 0, -knobHeight / 2 -  knobBottomHeight + hollowDepth / 2])
    cylinder(h = hollowDepth, r1 = hollowDia / 2, r2 = max(shaftDia + shaftOversize, extraShaftDia) / 2, center = true, $fn = roundness);
}

module extraShaft() {
  translate([0, 0, -knobHeight / 2 - knobBottomHeight - (extraShaftLength + hollowDepth) / 2 + hollowDepth])
    color("red", alpha = alphaValue)
    cylinder(h = extraShaftLength + hollowDepth, r1 = extraShaftDia / 2, r2 = extraShaftDia / 2, center = true, $fn = roundness);
}

module makePointer() {

  color("green")
    if (pointer == 1) {
      pointy();
    } else if (pointer == 2) {
      blocky();
    }
}

module pointy() {

  yMax = knobBottomHeight > 0 ? knobBottomDia / 2 + pointerLength : knobDia / 2 + pointerLength;

  totalPointerLength = knobBottomHeight > 0 ? pointerLength : (knobDia - knobBottomDia) / 2 + pointerLength;

  xLength = 2 * tan(pointerAngle / 2) * yMax;
  height=pointerHeight;
  
  translate([-xLength / 2, 0, -knobHeight / 2 - knobBottomHeight])

    polyhedron(points = [
			 [0, 0, 0], // 3 points of the base
			 [xLength, 0, 0],
			 [xLength / 2, yMax, 0],
			 [xLength / 2, knobDiaTop / 2, height] // and one point on the top
			  ],
	       faces = [
			[0, 1, 2], // Base
			[0, 2, 3], // Left face
			[1, 3, 2], // Right face
			[0, 3, 1]  // Front face
			]
	       );
}

module blocky() {
  
  yMax = knobBottomHeight > 0 ? knobBottomDia / 2 + pointerLength : knobDia / 2 + pointerLength;
  
  totalPointerLength = knobBottomHeight > 0 ? pointerLength : (knobDia - knobBottomDia) / 2 + pointerLength;

  xLength = 2 * tan(pointerAngle / 2) * yMax;
  height=pointerHeight;
  
  translate([0, 0, -knobHeight / 2 - knobBottomHeight])
    rotate([0, -90, 0])
    linear_extrude(height = pointerWidth, center  = true)
    polygon(points=[[0, 0], [pointerHeight, 0], [pointerHeight, knobDiaTop / 2 + pointerLengthTop], [0, yMax]]);
}
