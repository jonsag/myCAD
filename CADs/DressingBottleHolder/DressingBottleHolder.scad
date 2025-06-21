/*
   -----------------------------
   | DressingBottleHolder.scad |
   | by                        |
   | Jon Sagebrand             |
   | jonsagebrand@gmail.com    |
   -----------------------------
*/

/* Bottle Dimensions - These are not used. Drawn just for fun

                ---                 D=7.6       H=52
               /   \
              /     \
             /       \
            /         \
           /           \
          /             \           D=13.9      H=26.5
          /             \
         /               \          D=12.1
     ----                 ----      D=41.4      H=20
     |                       |
     |                       |
     |                       |
   ---                       ---    D=52.4      H=0
   |                           |
   |                           |
   .                           .
   .                           .
   .                           .

   |                           |
   |                           |
   -----------------------------

                ---                 D5=10.3       H=47.2
               /   \
              /     \
             /       \
            /         \
           /           \
          /             \           D4=17.6      H=27.1
         /               \
        /                 \         D3=18.9
     ---                   ---      D2=40.7      H=18.5
     |                       |
     |                       |
     |                       |
   ---                       ---    D1=52.1      H=0
   |                           |
   |                           |
   .                           .
   .                           .
   .                           .

   |                           |
   |                           |
   -----------------------------

*/

XBottles = 2;// Number of bottles in the X axle
YBottles = 2;// Number of bottles in the X axle

// Holder Dimensions
WallThickness = 2;
CornerRadius = 25;

AddBottom = false;
AddSupports = true;

SupportSizeFactor = 1;

HoleShape1 = [
  [0, 0], 
  [-2, -2], 
  [-2, -14], 
  [-4, -16], 
  [-12, -16], 
  [-14, -18], 
  [-14, -30], 
  [-18, -52], 
  [-19, -53], 
  [-28.5, -53], 
  [-28.5, -55], 
  [-18, -55], 
  [-17, -54], 
  [-16, -52], 
  [-12, -30], 
  [-12, -19], 
  [-11, -18], 
  [-3, -18], 
  [0, -15]
];

HolderShape2 = [
  [0, 0], 
  [-2, -2], 
  [-2, -17], 
  [-3, -18], 
  [-10, -18], 
  [-12, -20], 
  [-12, -29], 
  [-17, -50], 
  [-18, -51], 
  [-23, -51], 
  [-23, -53], 
  [-17, -53], 
  [-15, -50],// -15 -14 ?
  [-10, -29], 
  [-10, -21], 
  [-9, -20], 
  [-2, -20], 
  [0, -18], 
  [0, -4], 
  [2, -2], 
  [0, -2]
];

HolderSupportShape2 = [
  [-2, -20], 
  [-4, -20], 
  [-10, -27], 
  [-10, -29]
];

HolderShape = HolderShape2;
HolderSupportShape = HolderSupportShape2;

// Number of Bottles
ShowSection = false;// Only for debugging, not for printing

NoBottlesX = ShowSection ? 2 : XBottles;
NoBottlesY = ShowSection ? 2 : YBottles;

HoleDia = 23 * 2;
HolderDepth = 53 - WallThickness;

ExtraWidth = 52 - HoleDia;

HolderX = WallThickness * 2 + ExtraWidth * 2 + HoleDia * NoBottlesX + 2 * ExtraWidth * (NoBottlesX - 1);
HolderY = WallThickness * 2 + ExtraWidth * 2 + HoleDia * NoBottlesY + 2 * ExtraWidth * (NoBottlesY - 1);
HolderZ = HolderDepth + WallThickness;

echo("X: ", HolderX);
echo("Y: ", HolderY);
echo("Z: ", HolderZ);

AlphaValue = 1;

module HullOuter() {
  difference() {
    cube(size = [HolderX, HolderY, HolderZ]);

    for(i = [0:1]) {
      for(j = [0:1]) {
        translate([i * HolderX - i * CornerRadius * 2, j * HolderY - j * CornerRadius * 2, 0])
          intersection() {
            difference() {
              color("red")
                cube(size = [CornerRadius * 2, CornerRadius * 2, HolderZ]);

              translate([CornerRadius, CornerRadius, 0])
                cylinder(r = CornerRadius, h = HolderZ);
            }
            translate([i * CornerRadius, j * CornerRadius, 0])
              cube(size = [CornerRadius, CornerRadius, HolderZ]);
          }
      }
    }

  }
}

module HullInner() {
  Bottom = AddBottom ? WallThickness : 0;

  translate([WallThickness, WallThickness, Bottom * 2 - WallThickness])
    difference() {
      cube(size = [HolderX - WallThickness * 2, HolderY - WallThickness * 2, HolderZ - Bottom * 2]);

      for(i = [0:1]) {
        for(j = [0:1]) {

          translate([i * HolderX - i * (CornerRadius) * 2, j * HolderY - j * (CornerRadius) * 2, 0])
            intersection() {
              difference() {
                color("red")
                  cube(size = [(CornerRadius - WallThickness) * 2, (CornerRadius - WallThickness) * 2, HolderZ]);

                translate([CornerRadius - WallThickness, CornerRadius - WallThickness, 0])
                  cylinder(r = CornerRadius - WallThickness, h = HolderZ);
              }
              translate([i * (CornerRadius - WallThickness), j * (CornerRadius - WallThickness), 0])
                cube(size = [CornerRadius - WallThickness, CornerRadius - WallThickness, HolderZ]);
            }
        }
      }

    }
}

module HullHoles() {
  for(i = [0:NoBottlesX - 1]) {
    for(j = [0:NoBottlesY - 1]) {

      HoleX = WallThickness + ExtraWidth + HoleDia / 2 + i * ExtraWidth * 2 + i * HoleDia;
      HoleY = WallThickness + ExtraWidth + HoleDia / 2 + j * ExtraWidth * 2 + j * HoleDia;

      echo("HoleX: ", HoleX);
      echo("HoleY: ", HoleY);
      echo("");

      translate([HoleX, HoleY, HolderZ - WallThickness])
        cylinder(d = HoleDia, h = WallThickness);
    }
  }
}

module arc(r1, r2, a1, a2) {
  difference() {
    difference() {
      polygon([
        [0, 0], 
        [cos(a1) * (r1 + 50), sin(a1) * (r1 + 50)], 
        [cos(a2) * (r1 + 50), sin(a2) * (r1 + 50)]
      ]);
      circle(r = r2);
    }
    difference() {
      circle(r = r1 + 100);
      circle(r = r1);
    }
  }
}

module HolderProfile() {
  polygon(points = HolderShape);
}

module HolderSupportProfile() {
  polygon(points = HolderSupportShape);
}

module Holders() {
  for(i = [0:NoBottlesX - 1]) {
    for(j = [0:NoBottlesY - 1]) {
      HolderX = WallThickness + ExtraWidth + HoleDia / 2 + i * ExtraWidth * 2 + i * HoleDia;
      HolderY = WallThickness + ExtraWidth + HoleDia / 2 + j * ExtraWidth * 2 + j * HoleDia;

      echo("HolderX: ", HolderX);
      echo("HolderY: ", HolderY);
      echo("");

      translate([HolderX, HolderY, 0])
        translate([0, 0, HolderZ])
          rotate_extrude()
            translate([HoleDia / 2, 0, 0]) {
              HolderProfile();
              if (AddSupports) {
                HolderSupportProfile();
              }
            }
    }
  }
}

module SupportArm1() {
  difference() {
    union() {
      difference() {
        translate([0, 0, (HolderZ - WallThickness) * 2 / 3])
          cylinder(d1 = ExtraWidth, d2 = ExtraWidth * 4.5 * SupportSizeFactor, h = HolderZ / 3);
        translate([0, 0, (HolderZ - WallThickness) * 2 / 3 + 2])
          cylinder(d1 = ExtraWidth, d2 = ExtraWidth * 4.5* SupportSizeFactor, h = HolderZ / 3);
      }
      cylinder(d = ExtraWidth, h = HolderZ);
    }
    cylinder(d = ExtraWidth - WallThickness, h = HolderZ);
  }
}

module SupportArm2() {
  difference() {
    union() {
      difference() {
        translate([0, 0, (HolderZ - WallThickness) * 2 / 3])
          cylinder(d1 = ExtraWidth, d2 = ExtraWidth * 2.6* SupportSizeFactor, h = HolderZ / 3);
        translate([0, 0, (HolderZ - WallThickness) * 2 / 3 + 2])
          cylinder(d1 = ExtraWidth, d2 = ExtraWidth * 2* SupportSizeFactor, h = HolderZ / 3);
      }
      cylinder(d = ExtraWidth, h = HolderZ);
    }
    cylinder(d = ExtraWidth - WallThickness, h = HolderZ);
  }
}

module SingleHolder() {// This is just for testing
  rotate_extrude()
    translate([HoleDia / 2, 0, 0]) {
      HolderProfile();
      if (AddSupports) {
        HolderSupportProfile();
      }
    }
}

module Hull() {
  difference() {
    HullOuter();
    HullInner();
    HullHoles();
  }
}

module Supports() {
  for(i = [0:NoBottlesX - 2]) {
    for(j = [0:NoBottlesY - 2]) {

      Support1X = WallThickness + ExtraWidth * 2 + (i + 1) * HoleDia + i * ExtraWidth * 2;
      Support1Y = WallThickness + ExtraWidth * 2 + (j + 1) * HoleDia + j * ExtraWidth * 2;

      echo("Xcup, Ycup:", i + 1, j + 1);
      echo("Support1X: ", Support1X);
      echo("Support1Y: ", Support1Y);
      echo("");

      translate([Support1X, Support1Y, 0])
        SupportArm1();
    }
  }

  for(i = [0:NoBottlesX - 1]) {
    for(j = [0:NoBottlesY - 1]) {

      Support1X = WallThickness + ExtraWidth * 2 + (i + 1) * HoleDia + i * ExtraWidth * 2;
      Support1Y = WallThickness + ExtraWidth * 2 + (j + 1) * HoleDia + j * ExtraWidth * 2;
      
      if (i < (NoBottlesX - 1)) {
        if (j == 0) {
          translate([Support1X, WallThickness + ExtraWidth * 1.7, 0])
            SupportArm2();
          translate([Support1X, HolderY - WallThickness - ExtraWidth * 1.7, 0])
            SupportArm2();
          echo("Put X arms");
        }
      }
      if (j < (NoBottlesY - 1)) {
        if (i == 0) {
          translate([WallThickness + ExtraWidth * 1.7, Support1Y, 0])
            SupportArm2();
          translate([HolderX - WallThickness - ExtraWidth * 1.7, Support1Y, 0])
            SupportArm2();
          echo("Put Y arms");
        }
      }
    }
  }
}

module BottleHolder() {
  difference() {
    union() {
      Hull();
      Holders();

      if (AddSupports) {
        Supports();
      }
    }
    if (ShowSection) {
      rotate(a = 45, [0, 0, 1])
        translate([0, -HolderY * 2, -HolderZ / 2])
          cube([HolderX * 2, HolderY * 2, HolderZ * 2]);
    }
  }
}

if ($preview) {
  color(alpha = AlphaValue)
    BottleHolder();
//Holders();
//SingleHolder();
//HolderProfile();
//SupportArm();
} else {
  $fn = 90;
  BottleHolder();
//SingleHolder();
//SupportArm();
}