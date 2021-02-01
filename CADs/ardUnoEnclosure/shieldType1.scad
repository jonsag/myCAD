
module shieldType1() {
  translate([0, 0, 0]) // PCB
    color("green")
    cube([86.36, 58.42, 1.6]);
  
  // pin headers connecting to Arduino
  translate([28.57 - 2.54, 3.17 - 2.54, 0])
    rotate([180, 0, 90])
    pin_headers(1, 8);
  
  translate([51.44 - 2.54, 3.17 - 2.54, 0])
    rotate([180, 0, 90])
    pin_headers(1, 6);
  
  translate([19.68 - 2.54, 51.44 - 2.54, 0])
    rotate([180, 0, 90])
    pin_headers(1, 10);
  
  translate([46.35 - 2.54, 51.44 - 2.54, 0])
    rotate([180, 0, 90])
    pin_headers(1, 8);
  
  // LEDs
  //translate([79.38, 54.61, 1.6 + 1.5])
  translate([80.64, 54.61, 1.6 + 1.5])
    led(5, "blue", legs = false);

  translate([80.64, 46.35, 1.6 + 1.5])
    led(5, "red", legs = false);
  
  translate([80.64, 38.10, 1.6 + 1.5])
    led(5, "green", legs = false);
  
  // headers
  translate([59.69 - 2.54 / 2, 13.34 - 2.54 / 2, 2.54 / 2 + 0.4])
    rotate([0, 0, 0])
    pin_headers(2, 3);
  
  translate([59.69 - 2.54 / 2, 28.57 - 2.54 / 2, 2.54 / 2 + 0.4])
    rotate([0, 0, 0])
    pin_headers(2, 5);
  
  
  //  28 pin ZIF
  translate([11.43, 12.06, 1.7])
    zif28();
  /*
    translate([11.43 + 2.54 * 6.5, 12.7 + 2.54 * 2, 1.7])
    rotate([0, 0, 90])
    pdip(28, 2.54, socketed = true, w = inch(0.4));
  */
  // 20 pin ZIF
  translate([21.59, 35.56, 1.7])
    zif20();
  /*
    translate([21.59 + 2.54 * 4.5, 36.2 + 2.54 * 1.5, 1.7])
    rotate([0, 0, 90])
    pdip(20, 2.54, socketed = true, w = inch(0.3));
  */
  // 8 pin DIL
  translate([74.3 + 2.54 * 1.5, 5.08 + 2.54 * 1.5, 1.7])
    rotate([0, 0, 0])
    pdip(8, 2.54, socketed = true, w = inch(0.3));

  // capacitor
  translate([20.95, 4.17, 1.7 + 11.5 / 2])
    rotate([0, 0, 0])
    color("black")
    cylinder(h = 11.5, r1 = 2.5, r2 = 2.5, center = true, $fn = roundness);
}

module lidOpeningsType1() {
  xOffset = casWallThick + extraWidthL; // + 0.4;
  yOffset = casWallThick + extraDepthD; // + 0.3;
  
  translate([-extraWidthL - casWallThick, -extraDepthD - casWallThick, 0])
  union() {
  // zif 28
  translate([xOffset + 26.04 + 0.6, 
  yOffset + 16.18, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cube([50.5 + 2, 15 + 2, lidThick + lidInset], center = true);
  
  // zif 20
  translate([xOffset + 30.795 + 0.4, 
  yOffset + 39.37 + 0.3, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cube([40.2 + 2, 15 + 2, lidThick + lidInset], center = true);
  
  // 8-pin DIL
  translate([xOffset + 78.11 - 0.6, 
  yOffset + 8.89 + 0.4, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cube([10.16 + 2, 10.16 + 2, lidThick + lidInset], center = true);
  
  // 6 pin header
  translate([xOffset + 60.96 - 0.6, 
  yOffset + 15.88 - 0., 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cube([2.54 * 2 + 2, 2.54 * 3 + 2, lidThick + lidInset], center = true);
  
  // 10 pin header
  translate([xOffset + 60.96 - 0.6, 
  yOffset + 33.66 - 0.2, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cube([2.54 * 2 + 2, 2.54 * 5 + 2, lidThick + lidInset], center = true);
  
  // blue LED
  translate([xOffset + 80.64 - 1.5, 
  yOffset + 54.61 + 0.3, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cylinder(h = lidThick + lidInset, r1 = 3, r2 = 3, center = true, $fn = roundness);
  
  // red LED
  translate([xOffset + 80.64 - 1.5, 
  yOffset + 46.35 + 0.3, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cylinder(h = lidThick + lidInset, r1 = 3, r2 = 3, center = true, $fn = roundness);
  
  // green LED
  translate([xOffset + 80.64 - 1.5, 
  yOffset + 38.1 + 0.3, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cylinder(h = lidThick + lidInset, r1 = 3, r2 = 3, center = true, $fn = roundness);

  // capacitor
  translate([xOffset + 20.95 + 0.4, 
  yOffset + 4.17 + 0.3, 
  (lidThick + lidInset) / 2 - lidInset + tolerance])
    color("red")
    cylinder(h = lidThick + lidInset, r1 = 3, r2 = 3, center = true, $fn = roundness);
  }
}