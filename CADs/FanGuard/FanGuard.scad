// FanGuard.scad

FanSize = 6;// Axial fan size: 0 = Define measurements below, 1 = 25, 2 = 40, 3 = 50, 4 = 60, 5 = 70, 6 = 80, 7 = 92, 8 = 120

Thickness = 2;

CenterCrossType = 2;// 1 = Horizontal/Vertical, 2 = Diagonal

// Self defined measurements
OwnWidth = 10;
OwnHeight = OwnWidth;

OwnCornerRadius = 5;

OwnMountHoleDistanceX = 7;
OwnMountHoleDistanceY = OwnMountHoleDistanceX;

OwnMountHoleDia = 2;

OwnEdgeWidth = 0.7;

// Setting variables
CubeX = FanSize == 0 ? OwnWidth : FanSize == 1 ? 25 : FanSize == 2 ? 40 : FanSize == 3 ? 50 : FanSize == 4 ? 60 : FanSize == 5 ? 70 : FanSize == 6 ? 80 : FanSize == 7 ? 92 : 120;
CubeY = FanSize == 0 ? OwnX : FanSize == 1 ? 25 : FanSize == 2 ? 40 : FanSize == 3 ? 50 : FanSize == 4 ? 60 : FanSize == 5 ? 70 : FanSize == 6 ? 80 : FanSize == 7 ? 92 : 120;
CubeZ = Thickness;
CornerRadius = FanSize == 0 ? OwnCornerRadius : FanSize == 1 ? 3 : FanSize == 2 ? 4 : FanSize == 3 ? 5 : FanSize == 4 ? 4 : FanSize == 5 ? 4 : FanSize == 6 ? 4 : FanSize == 7 ? 5 : 5;

MountHoleDistanceX = FanSize == 0 ? OwnMountHoleDistanceX : FanSize == 1 ? 20 : FanSize == 2 ? 32 : FanSize == 3 ? 40 : FanSize == 4 ? 50 : FanSize == 5 ? 61 : FanSize == 6 ? 71 : FanSize == 7 ? 82.5 : 105;
MountHoleDistanceY = FanSize == 0 ? OwnMountHoleDistanceY : FanSize == 1 ? 20 : FanSize == 2 ? 32 : FanSize == 3 ? 40 : FanSize == 4 ? 50 : FanSize == 5 ? 61 : FanSize == 6 ? 71 : FanSize == 7 ? 82.5 : 105;
MountHoleDia = FanSize == 0 ? OwnMountHoleDia : FanSize == 1 ? 2.9 : FanSize == 2 ? 4.3 : FanSize == 3 ? 4.3 : FanSize == 4 ? 4.5 : FanSize == 5 ? 4.3 : FanSize == 6 ? 4.5 : FanSize == 7 ? 4.3 : 4.3;

EdgeWidth = FanSize == 0 ? OwnEdgeWidth : FanSize == 1 ? 2 : FanSize == 2 ? 2.5 : FanSize == 3 ? 3 : FanSize == 4 ? 3 : FanSize == 5 ? 3 : FanSize == 6 ? 3 : FanSize == 7 ? 3 : 3.5;

module RoundedCube(CubeX, CubeY, CubeZ, CornerRadius, Thickness) {
  union() {
    difference() {
      cube([CubeX, CubeY, CubeZ]);
      for(x = [0:1]) {
        for(y = [0:1]) {
          translate([x * (CubeX - CornerRadius), y * (CubeY - CornerRadius), 0])
            cube([CornerRadius, CornerRadius, Thickness]);
        }
      }
    }

    for(x = [0:1]) {
      for(y = [0:1]) {
        color("red")
          intersection() {
            translate([CornerRadius + x * (CubeX - CornerRadius * 2), CornerRadius + y * (CubeY - CornerRadius * 2), 0])
              cylinder(r = CornerRadius, h = Thickness);
            translate([x * (CubeX - CornerRadius), y * (CubeY - CornerRadius), 0])
              cube([CornerRadius, CornerRadius, Thickness]);
          }
      }
    }
  }
}

module MountHoles(CubeX, CubeY, DistanceX, DistanceY, HoleSize, Thickness) {
  for(x = [0:1]) {
    for(y = [0:1]) {
      color("green")
        translate([(CubeX - DistanceX) / 2 + x * DistanceX, (CubeY - DistanceY) / 2 + y * DistanceY, 0])
          cylinder(d = HoleSize, h = Thickness);
    }
  }
}

module CenterCutOut(CubeX, CubeY, EdgeWidth, Thickness) {
  color("blue")
    translate([CubeX / 2, CubeY / 2, 0])
      cylinder(d = CubeX - EdgeWidth * 2, h = Thickness);
}

module CenterCross(CubeX, CubeY, CenterCrossType, EdgeWidth, Thickness) {
  if (CenterCrossType == 1 || CenterCrossType == 2) {
    Rotation = CenterCrossType == 1 ? 0 : 45;
    for(i = [0:1]) {
      color("cyan")
        translate([CubeX / 2, CubeY / 2, Thickness / 2])
          rotate([0, 0, Rotation + i * 90])
            cube([CubeX - EdgeWidth * 2, EdgeWidth / 2, Thickness], center = true);
    }
  }
}

module Circles(CubeX, CubeY, EdgeWidth, Thickness) {
  NumberOfCircles = floor((CubeX - EdgeWidth * 2) / 10);
  echo("Number of circles: ", NumberOfCircles);

  for(j = [0:NumberOfCircles]) {
    color("purple")
      translate([CubeX / 2, CubeY / 2, Thickness / 2])
        difference() {
          cylinder(d = CubeX - EdgeWidth * 2 - EdgeWidth * 2 - j * EdgeWidth * 4, h = Thickness, center = true);
          cylinder(d = CubeX - EdgeWidth * 2 - EdgeWidth * 2 - j * EdgeWidth * 4 - EdgeWidth * 2 + EdgeWidth, h = Thickness, center = true);
        }
  }
}

module FanGuard() {

  union() {
    difference() {
      RoundedCube(CubeX, CubeY, CubeZ, CornerRadius, Thickness);
      MountHoles(CubeX, CubeY, MountHoleDistanceX, MountHoleDistanceY, MountHoleDia, Thickness);
      CenterCutOut(CubeX, CubeY, EdgeWidth, Thickness);
    }
    Circles(CubeX, CubeY, EdgeWidth, Thickness);
    CenterCross(CubeX, CubeY, CenterCrossType, EdgeWidth, Thickness);
  }
}

if ($preview) {
  $fn = 12;
  FanGuard();
} else {
  $fn = 100;
  FanGuard();
}