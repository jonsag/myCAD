// TheKnobMaker-2.scad
//
// Design: Jon Sagebrand
// jonsagebrand@gmail.com
//

// ---------- Variables ----------

// Main body
Height = 25;// The total height of the knob, without dome or protruding text

BottomDiameter = 30;// Bottom diameter
TopDiameter = 25;// Top Diameter

WallThickness = 1;// mm, set to 0 for a solid knob (without a hollow bottom)

// Pointer
PointerType = 2;// 0: No pointer, 1: Wedged, 2: Rectangular

PointerLength = 5;
PointerWidth = 3;

PointerHeight = 20;// mm, set to 0 for full height

PointerThinning = true;// 0/1, set to 0 to keep pointer shape up to the top

// Top modification
TopType = 2;// 0: Flat top, 1: Cylindrical indentation, 2: Spherical indentation, 3: Domed top

TopRimWidth = 1;

TopIndentationDepth = 2;

TopDomeHeight = 2;

// Ridges around the knob
RidgeType = 1;// 0: No ridges, 1: Rectangular ridges, 2: Triangular ridges, 3: Circular ridges

NoOfRidges = 22;

RidgeHeight = 1;// 0 -> 1, how much of the knob will have ridges, measured from the bottom
RidgeDepth = 1;// Protrusion of the ridges
RidgeWidth = 3;

DrawLastRidge = true;// When you have a pointer and the ridges, also draw the ridge in the pointers position

// Skirt
SkirtBottomDiameter = 35;// mm, set to 0 for no skirt
SkirtTopDiameter = 0;// mm, set to 0 to blend in with knob

SkirtHeight = 15;

// Stem
ShaftType = 2;// 0: No shaft (??), 1: Smooth or knurled cylindrical shaft, 2: D shaft

// Typical 18T knurled shaft: OA diameter 6mm
// Typical D shaft: Diameter 6mm, Flat thickness 4.5mm

ShaftDiameter = 6;
NoOfKnurls = 18;
DShaftThickness = 4.5;

ShaftLength = 8;// Depth of the hole

DFlatRotation = 0;// 0 -> 360 ccw, 0 puts the flat straight up,
StemWallThickness = 2;

SplitShaft = 1;// 0: No split, 1: Split to hole depth, 2: Whole stem is split
SplitWidth = 1;

ShaftOffset = -5;// The protrusion of the shaft below the knobs base, negative value makes stem shorter than knob base
ShaftTolerance = 0.1;// Over(+) or undersized (-) hole

// Text
TextType = 1;// 0 = no text, 1 = center curved up, 2 = center curved down, 3: straight text in the middle
TextString = "Volume";

TextSize = 4;
TextFont = "Liberation Sans:style=Bold";//"Liberation Sans:style=Bold Italic";
TextSpacing = 1;
TextFn = 10;

TextDepth = TopIndentationDepth;// set this to TopIndentationDepth if you still want text on the top despite you have a concave top

TextPlaceAngle = 0;// 0 - 360 cw, rotate text around the knob

TextRaised = true;

//TextZOffset = 0;// set this to -TopIndentationDepth if you still want text on the top despite you have a domed top

// ---------- No editing below this line if you don't know what you are doing ----------

$fn = $preview ? 30 : 100;

AlphaValue = 1;

// Make sure the pointer isn't higher than knob height
PointerHeightMax = PointerHeight > Height ? Height : PointerHeight;

echo("Max allowed indentation/dome diameter: ", TopDiameter - TopRimWidth * 2);

// ---------- Spherical indentation on top
CalculatedIndentationSphereDiameter = (TopIndentationDepth ^ 2 + ((TopDiameter - TopRimWidth * 2) / 2) ^ 2) / TopIndentationDepth;
echo("Calculated sphere diameter: ", CalculatedIndentationSphereDiameter);

// Check to see if the sphere diameter /2 is smaller that the indentation depth
// If so the diameter is enlarged to the indentation depth *2
IndentationSphereDiameter = CalculatedIndentationSphereDiameter / 2 < TopIndentationDepth ? TopDiameter - TopRimWidth * 2 : CalculatedIndentationSphereDiameter;

MaxTopIndentationDepth = IndentationSphereDiameter / 2 < TopIndentationDepth ? IndentationSphereDiameter / 2 : TopIndentationDepth;
echo("Top max indentation depth: ", MaxTopIndentationDepth);

// Extra wall thickness on top because of top indentation
TopExtraWallThickness = TopType == 0 ? 0 : MaxTopIndentationDepth;
echo("Top extra wall thickness: ", TopExtraWallThickness);


echo("Sphere diameter: ", IndentationSphereDiameter);

SphereZTranslation = CalculatedIndentationSphereDiameter / 2 < TopIndentationDepth ? 0 : IndentationSphereDiameter / 2 - TopIndentationDepth;

module MainBody() {
  cylinder(h = Height, d1 = BottomDiameter, d2 = TopDiameter);

}

module Pointer() {
  color("red")
    hull() {

      PointerTipX = PointerType == 1 ? 0 : PointerWidth / 2;

      BottomPointerY = sqrt((BottomDiameter / 2) ^ 2 - (PointerWidth / 2) ^ 2);

      // Lower pointer shape
      color("red")
        linear_extrude(height = 0.01)
          polygon(points = [
            [-PointerWidth / 2, BottomPointerY], 
            [-PointerTipX, BottomPointerY + PointerLength], 
            [PointerTipX, BottomPointerY + PointerLength], 
            [PointerWidth / 2, BottomPointerY]
          ]);

      PointerYTranslate = PointerHeightMax > 0 ? (TopDiameter - TopDiameter) * PointerHeightMax / Height : 0;
      PointerZTranslate = PointerHeightMax > 0 ? PointerHeightMax : Height;

      UpperPointerLength = PointerThinning == true ? 0.01 : PointerLength;
      UpperPointerWidth = PointerThinning == true ? 0.01 : PointerWidth;

      TopPointerY = PointerType == 2 ? sqrt((TopDiameter / 2) ^ 2 - (PointerWidth / 2) ^ 2) : TopDiameter / 2 - 0.1;

      // Upper pointer shape
      color("red")
        translate([0, PointerYTranslate, PointerZTranslate])
          rotate(a = 180, v = [0, 1, 0])
            linear_extrude(height = 0.01)
              polygon(points = [
                [-UpperPointerWidth / 2, TopPointerY], 
                [-PointerTipX, TopPointerY + UpperPointerLength], 
                [PointerTipX, TopPointerY + UpperPointerLength], 
                [UpperPointerWidth / 2, TopPointerY]
              ]);
    }
}


module TopIndentation() {
  // Cylindrical indentation
  color("red")
    if (TopType == 1) {
      translate([0, 0, Height - TopIndentationDepth])
        cylinder(h = TopIndentationDepth, d = TopDiameter - TopRimWidth * 2);

        // Spherical indentation
    } else if (TopType == 2) {
      translate([0, 0, Height + SphereZTranslation])
        sphere(d = IndentationSphereDiameter);
    }
}

module TopDome() {
  echo("Top dome height: ", TopDomeHeight);

  CalculatedDomeSphereDiameter = TopDomeHeight == 0 ? TopDiameter - TopRimWidth * 2 : (TopDomeHeight ^ 2 + ((TopDiameter - TopRimWidth * 2) / 2) ^ 2) / TopDomeHeight;
  echo("Calculated dome sphere diameter: ", CalculatedDomeSphereDiameter);

  DomeSphereDiameter = CalculatedDomeSphereDiameter / 2 < TopDomeHeight ? TopDiameter - TopRimWidth * 2 : CalculatedDomeSphereDiameter;

  MaxTopDomeHeight = DomeSphereDiameter / 2 < TopDomeHeight ? DomeSphereDiameter / 2 : TopDomeHeight;
  //  MaxTopDomeHeight = CalculatedDomeSphereDiameter / 2 > (TopDiameter - TopRimWidth * 2) ? TopDiameter - TopRimWidth * 2 : TopDomeHeight;
  echo("Max top dome height: ", MaxTopDomeHeight);

  //  DomeSphereDiameter = CalculatedDomeSphereDiameter / 2 > MaxTopDomeHeight ? CalculatedDomeSphereDiameter : TopDiameter - TopRimWidth * 2;
  echo("Dome sphere diameter: ", DomeSphereDiameter);

  DomeZTranslation = Height - DomeSphereDiameter / 2 + MaxTopDomeHeight;

  color("red")
    translate([0, 0, DomeZTranslation])
      difference() {
        sphere(d = DomeSphereDiameter);

        translate([0, 0, -MaxTopDomeHeight])
          cube([DomeSphereDiameter, DomeSphereDiameter, DomeSphereDiameter], center = true);
      }
}

module Ridges() {
  //MaxNoOfRidges1 = PointerType > 0 ? NoOfRidges - 1 : NoOfRidges;
  MaxNoOfRidges = (PointerType == 0 || PointerType > 0 && DrawLastRidge == true) ? NoOfRidges : NoOfRidges - 1;

  color("red")
    for(i = [1:MaxNoOfRidges]) {
      echo(i);

      if (RidgeType == 1) {
        BottomRidgeY = sqrt((BottomDiameter / 2) ^ 2 - (PointerWidth / 2) ^ 2);

        rotate(a = i * 360 / NoOfRidges, [0, 0, 1])
          //translate([0, BottomDiameter / 2 + RidgeDepth / 2, 0])
          hull() {
            linear_extrude(height = 0.01)
              //square([RidgeWidth, RidgeDepth], center = true);

              polygon(points = [
                [-RidgeWidth / 2, BottomRidgeY], 
                [-RidgeWidth / 2, BottomRidgeY + RidgeDepth], 
                [RidgeWidth / 2, BottomRidgeY + RidgeDepth], 
                [RidgeWidth / 2, BottomRidgeY]
              ]);
            translate([0, -BottomDiameter / 2 + TopDiameter / 2, Height * RidgeHeight])
              linear_extrude(height = 0.01)
                //square([RidgeWidth, RidgeDepth], center = true);
                polygon(points = [
                  [-RidgeWidth / 2, BottomRidgeY], 
                  [-RidgeWidth / 2, BottomRidgeY + RidgeDepth], 
                  [RidgeWidth / 2, BottomRidgeY + RidgeDepth], 
                  [RidgeWidth / 2, BottomRidgeY]
                ]);
          }
      } else if (RidgeType == 2) {
        BottomRidgeY = sqrt((BottomDiameter / 2) ^ 2 - (PointerWidth / 2) ^ 2);

        rotate(a = i * 360 / NoOfRidges, [0, 0, 1])
          //translate([0, BottomDiameter / 2 + RidgeDepth / 2, 0])
          hull() {
            linear_extrude(height = 0.01)
              polygon(points = [
                [-RidgeWidth / 2, BottomRidgeY], 
                [0, BottomRidgeY + RidgeDepth], 
                [RidgeWidth / 2, BottomRidgeY]
              ]);
            translate([0, -BottomDiameter / 2 + TopDiameter / 2, Height * RidgeHeight])
              linear_extrude(height = 0.01)
                polygon(points = [
                  [-RidgeWidth / 2, BottomRidgeY], 
                  [0, BottomRidgeY + RidgeDepth], 
                  [RidgeWidth / 2, BottomRidgeY]
                ]);
          }
      } else if (RidgeType == 3) {
        BottomRidgeY = sqrt((BottomDiameter / 2) ^ 2 - (PointerWidth / 2) ^ 2);
        SinX = (BottomDiameter / 2 - TopDiameter / 2) / Height;
        echo("SinX: ", SinX);
        Angle = asin(SinX);
        echo("Angle: ", Angle);
        rotate(a = i * 360 / NoOfRidges, [0, 0, 1])
          translate([0, BottomDiameter / 2 - RidgeWidth / 2 + RidgeDepth, 0])
            rotate(a = Angle, [1, 0, 0])
              hull() {
                linear_extrude(height = 0.01)
                  circle(d = RidgeWidth);
                //translate([0, -BottomDiameter / 2 + TopDiameter / 2, Height * RidgeHeight])
                translate([0, 0, Height * RidgeHeight])
                  linear_extrude(height = 0.01)
                    circle(d = RidgeWidth);

              }
      }
    }
}

module Skirt() {
  SkirtUpperDiameter = SkirtTopDiameter > 0 ? SkirtTopDiameter : 2 * ((BottomDiameter / 2) - (BottomDiameter / 2 - TopDiameter / 2) * (SkirtHeight / Height));
  echo("Skirt upper diameter: ", SkirtUpperDiameter);

  color("red")
    cylinder(d1 = SkirtBottomDiameter, d2 = SkirtUpperDiameter, h = SkirtHeight);
}

module Stem() {
  StemLength = Height - WallThickness - TopExtraWallThickness + ShaftOffset;
  echo("Stem length: ", StemLength)

    color("red")
      difference() {
        union() {
          difference() {
            translate([0, 0, -ShaftOffset])
              cylinder(d = ShaftDiameter + StemWallThickness * 2, h = StemLength);
            translate([0, 0, -ShaftOffset])
              cylinder(d = ShaftDiameter + ShaftTolerance * 2, h = ShaftLength);
          }
          // The D flat
          if (ShaftType == 2) {
            rotate(a = DFlatRotation, [0, 0, 1])
              translate([0, (ShaftDiameter - DShaftThickness) / 2 + ShaftDiameter - DShaftThickness + ShaftTolerance, ShaftLength / 2 - ShaftOffset])
                cube([ShaftDiameter + ShaftTolerance * 2, ShaftDiameter - DShaftThickness, ShaftLength], center = true);
          }
        }
        if (SplitShaft > 0) {
          MaxSplitLength = SplitShaft == 1 ? ShaftLength : Height - WallThickness - TopExtraWallThickness + ShaftOffset;
          echo("Max split length: ", MaxSplitLength);

          translate([0, 0, MaxSplitLength / 2 - ShaftOffset])
            cube([ShaftDiameter + StemWallThickness * 2, SplitWidth, MaxSplitLength], center = true);
        }
      }
}

module writeCurvedText() {
  Chars = len(TextString) + 1;

  Degrees = TextType == 1 ? Chars * TextSize * 7 : Chars * TextSize * 6;
  TextRadius = TextType == 1 ? TopDiameter / 2 - TopRimWidth - TextSize * 1.3 : TopDiameter / 2 - TopRimWidth - TextSize * 0.7;

  Top = TextType == 1 ? true : false;

  TextY = TextRaised == true ? Height / 2 : Height / 2 - TextDepth;

  rotate([0, 0, -TextPlaceAngle])
    translate([0, 0, Height - TopIndentationDepth])
      for(i = [1:Chars]) {
        rotate([0, 0, (Top ? 1 : -1) * (Degrees / 2 - i * (Degrees / Chars))])
          translate([0, (Top ? 1 : -1) * TextRadius - (Top ? 0 : TextSize / 2), 0])
            linear_extrude(TextDepth)
              text(TextString[i - 1], halign = "center", font = TextFont, size = TextSize);
      }
}

module WriteStraightText() {
  rotate([0, 0, -TextPlaceAngle])
    translate([0, 0, Height - TopIndentationDepth])
      linear_extrude(TextDepth)
        text(TextString, valign = "center", halign = "center", font = TextFont, size = TextSize);
}
module Text() {
  if (TextType == 3) {
    WriteStraightText();
  } else {
    writeCurvedText();
  }
}

module KnobMaker() {
  union() {
    difference() {
      union() {// Main body and dome

        difference() {// Top indentation
          color(alpha = AlphaValue)
            union() {
              MainBody();

              if (PointerType > 0) {
                Pointer();
              }
            }

            // Top modification
          if (TopType == 1 || TopType == 2) {
            TopIndentation();
          }
        }

        if (TopType == 3) {
          TopDome();
        }

        // Side ridges
        if (RidgeType > 0) {
          difference() {
            Ridges();
            // Clean bottom
            translate([0, 0, -Height])
              cylinder(d = BottomDiameter * 2, h = Height);
            // Clean top
            translate([0, 0, Height])
              cylinder(d = BottomDiameter * 2, h = Height);//}
          }
        }

        // Skirt
        if (SkirtBottomDiameter > 0) {
          Skirt();
        }

      }
      // Hollow out the inside
      if (WallThickness > 0) {
        cylinder(h = Height - WallThickness - TopExtraWallThickness, d1 = BottomDiameter - WallThickness * 2, d2 = TopDiameter - WallThickness * 2);
      } else {
        cylinder(h = Height - WallThickness - TopExtraWallThickness, d = ShaftDiameter + StemWallThickness * 2);
      }
    }
  }
  // Stem
  if (ShaftType > 0) {
    Stem();
  }

  // Text
  if (TextType > 0) {
    color("violet", alpha = AlphaValue)
      Text();
  }
}

if ($preview) {
  color(alpha = AlphaValue)
    KnobMaker();
} else {
  KnobMaker();
}