// Ring measure
//
// Measure the inner diameter of a finger ring

// libraries
use<text_on.scad>

// how many different diameters will be stacked
noOfSegments = 20;

// the height of each segment
segmentHeight = 5;

// the largest diameter on the bottom
baseDiameter = 25;

// the diameter step between each segment
diameterSteps = 0.5;

// depth of the engraved text
engraveDepth = 1;
// font for the engraved text
font = "Liberation Sans";

///// don't change anything below this line /////
// rendering options
roundness = 100;
// Set to 0.01 for higher definition curves (renders slower)
$fs = 0.25;

// calculate text size
// compensation for text height
textHeightCompensation = 0.2;
// factor for setting text size
textFactor = 1;
// when wrapping text around the cylinder, slice the text
noOfTextSlices = 20;
// calculate text size
textSize = (segmentHeight - textHeightCompensation) * textFactor;

// center everything
center = true;

for (segmentNo = [0 : noOfSegments - 1]) {
  difference() {
    // ring
    translate(v = [0, 0, segmentHeight / 2 + segmentNo * segmentHeight])
  color("green",0.2)
    cylinder(h = segmentHeight, r1 = (baseDiameter - segmentNo * diameterSteps) / 2, r2 = (baseDiameter - segmentNo * diameterSteps) / 2, center = center, $fn = roundness);

    radius = (baseDiameter - segmentNo * diameterSteps) / 2;
    circumference = 2 * 3.14159 * radius;
    sliceWidth = circumference / noOfTextSlices;

    //circular_text ();
    // http://forum.openscad.org/It-seems-no-way-to-put-text-on-the-curved-surface-td20182.html
    union () {
      for (i = [0 : 1 : noOfTextSlices]) {
	rotate ([0, 0, i * (360 / noOfTextSlices)])
	  translate ([0, -radius, segmentHeight / 2 + segmentNo * segmentHeight])
	  intersection () {
	  translate ([-sliceWidth / 2 - (i * sliceWidth),0 ,0])
	    rotate ([90, 0, 0])
	    linear_extrude(engraveDepth, center = true, convexity = 10)
	    //text(text = "OpenSCAD", font = font, size = textSize, valign = "center", halign = "center");
	    text(text = str(baseDiameter - segmentNo * diameterSteps), size = textSize, valign = "center");
	  cube ([sliceWidth + 0.1, engraveDepth + 0.1, segmentHeight], true);
	}
      }
    }
  }
}
