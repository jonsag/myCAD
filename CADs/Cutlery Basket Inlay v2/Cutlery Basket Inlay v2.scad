// Cutlery Basket Inlay v2.scad

// Design: Jon Sagebrand
// jonsagebrand@gmail.com

Width = 52;
Depth = 36;
Height = 10;

Thickness = 1;

NetWidth = 2;
NetGap = 3;

NoOfX = floor(Width / (NetWidth + NetGap)) + 1;
NoOfY = floor(Depth / (NetWidth + NetGap)) + 1;

NoOfZ = floor((Height - Thickness) / (NetWidth + NetGap)) + 1;

// Bottom
union() {
  for(x = [-Width / 2 + NetWidth / 2:Width / NoOfX:0]) {
    // Horizontal
    color("green") {
      translate([-x, 0, 0])
        cube([NetWidth, Depth, Thickness], center = true);
      translate([x, 0, 0])
        cube([NetWidth, Depth, Thickness], center = true);
    }

    // Vertical Sides
    if (Height > 0) {
      color("red") {
        translate([-x, -Depth / 2 + Thickness / 2, Height / 2])
          cube([NetWidth, Thickness, Height], center = true);
        translate([x, -Depth / 2 + Thickness / 2, Height / 2])
          cube([NetWidth, Thickness, Height], center = true);
        translate([-x, Depth / 2 - Thickness / 2, Height / 2])
          cube([NetWidth, Thickness, Height], center = true);
        translate([x, Depth / 2 - Thickness / 2, Height / 2])
          cube([NetWidth, Thickness, Height], center = true);
      }
    }
  }

  for(y = [-Depth / 2 + NetWidth / 2:Depth / NoOfY:0]) {
    // Horizontal
    color("blue") {
      translate([0, -y, 0])
        cube([Width, NetWidth, Thickness], center = true);
      translate([0, y, 0])
        cube([Width, NetWidth, Thickness], center = true);
    }

    // Vertical Sides
    if (Height > 0) {
      color("red") {
        translate([-Width / 2 + Thickness / 2, -y, Height / 2])
          cube([Thickness, NetWidth, Height], center = true);
        translate([-Width / 2 + Thickness / 2, y, Height / 2])
          cube([Thickness, NetWidth, Height], center = true);
        translate([Width / 2 - Thickness / 2, -y, Height / 2])
          cube([Thickness, NetWidth, Height], center = true);
        translate([Width / 2 - Thickness / 2, y, Height / 2])
          cube([Thickness, NetWidth, Height], center = true);
      }
    }
  }

  // Horizontal Sides

  if (Height > 0) {
    for(z = [Height - NetWidth / 2:-Height / NoOfZ:0]) {
      color("orange") {
        translate([-Width / 2 + Thickness / 2, 0, z])
          cube([Thickness, Depth, NetWidth], center = true);
        translate([Width / 2 - Thickness / 2, 0, z])
          cube([Thickness, Depth, NetWidth], center = true);
      }

      color("yellow") {
        translate([0, -(Depth / 2) + Thickness / 2, z])
          cube([Width, Thickness, NetWidth], center = true);
        translate([0, (Depth / 2) - Thickness / 2, z])
          cube([Width, Thickness, NetWidth], center = true);
      }
    }
  }
}