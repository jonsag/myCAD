
/*
// what to show
mount1 = true;
mount2 = true;
mount3 = true;
mount4 = true;

gy521 = true;

// print?
print = true;

mpu6050_mount();
*/
// oversize hole depths
overSize = 1.07;

// nut for X, Y adjustments screwes
nutDia = 7;
nutHeight = 2.3;
     
// mpu mount
springHeight = 10;
springHoleDia = 7;

springRecess = 1;

adjScrewDia = 3;

adjScrewEdgeDist = 1;

// mount1, the one closest to the pcb, adjusts Z
mount1Width = 35;
mount1Depth = 17.6;
mount1Height = 6;

pcbHoleDia = 2.5;

pinHeaderCutOut = 5;

mount1YMove = 3;

// mount2, adjusts X
mount2Width = mount1Width;
mount2Depth = mount1Depth;
mount2Height = mount1Height;

mount2ExtraDepth = 10;

// mount3, non moving part
mount3Width = mount2Width;
mount3Depth = mount2Depth;
mount3Height = mount2Height;

mount3ExtraDepth = mount2ExtraDepth;

// mount4, non moving part
mount4Width = mount3Width;
mount4Depth = mount3Depth;
mount4Height = mount3Height;

mount4ExtraDepth = mount3ExtraDepth;
     
// swivels, where the adjustment plates swivel
swivelWidth = mount1Width / 2 - 11;

swivelScrewDia = 3;

// roundness
$fn=100;

//mpu6050_mount();

module mpu6050_mount() {
     if (mount1) {
	  if (print) {
	       translate([0, -mount1YMove, mount2Height / 2 + swivelWidth])
		    mount1();
	  } else {
	       mount1();
	  }
     }
     
     if (mount2) {
	  if (print) {
	       translate([mount1Width * 1.1, 0, mount2Height / 2 + swivelWidth])
		    mount2();
	  } else {
	       translate([0, 0, -swivelWidth - mount1Height])
		    mount2();
          }
     }
     
     if (mount3) {
	  if (print) {
	       translate([0, mount1Depth * 1.1, mount3Height / 2])
		    mount3();
	  } else {
	       translate([0, 0, (-swivelWidth - mount1Height) * 2])
		    mount3();
          }
     }
     /*
     if (mount4) {
          if (print) {
               translate([mount1Width * 1.1, (mount1Depth + mount2ExtraDepth) * 1.1, mount3Height / 2])
                    mount4();
          } else {
               translate([0, 0, (-swivelWidth - mount1Height) * 3 + swivelWidth])
                    mount4();
          }
     }
     
     if (gy521) {
	  if (!print) {
	       translate([-10.5, -7.8 + mount1YMove, mount1Height / 2 - 1.2])
		    mpu6050_gy521();
	  }
     }
     */
}

module mount1() {
     translate([0, mount1YMove, 0])
     union() {
	  difference() {
	       cube([mount1Width, mount1Depth, mount1Height], center = true); // main body of mount1
	       
	       translate([0, 0, (mount1Height - 1.2) / 2]) // pcb recess
		    cube([22, 16.6, 1.2 * overSize], center = true);
	       
	       translate([0, -mount1Depth / 2 + 2.5, 0]) // pin header cut out
		    cube([20, pinHeaderCutOut * overSize, mount1Height * overSize], center = true);
	       
	       translate([-21 / 2 + 3, 15.6 / 2 -3, 0]) // pcb mounting holes
		    cylinder(mount1Height * overSize, pcbHoleDia / 2, pcbHoleDia / 2, center = true);
	       translate([21 / 2 - 3, 15.6 / 2 -3, 0])
		    cylinder(mount1Height  * overSize, pcbHoleDia / 2, pcbHoleDia / 2, center = true);
	       
	       translate([mount1Width / 2 - springHoleDia / 2 - adjScrewEdgeDist, 0, 0]) // hole for X adjusment screw
		    cylinder(mount1Height * overSize, (swivelScrewDia + 0.5) / 2, (pcbHoleDia + 0.5) / 2, center = true);
	       
	       translate([mount1Width / 2 - springHoleDia / 2 - adjScrewEdgeDist, 0, -mount1Height / 2 + springRecess / 2]) // spring recess hole
		    cylinder(springRecess * overSize, springHoleDia / 2, springHoleDia / 2, center = true);
	  }
	  difference() {
	       union() {
		    translate([-mount1Width / 2 + swivelWidth / 2, 0, -swivelWidth / 4 - mount1Height / 2])
			 cube([swivelWidth, mount1Depth, swivelWidth / 2], center = true);
		    
		    translate([-mount1Width / 2 + swivelWidth / 2, 0, -swivelWidth / 2 - mount1Height / 2]) // swivel point
			 rotate([90, 0, 0])
			 cylinder(mount1Depth, swivelWidth / 2, swivelWidth / 2, center = true);
	       }
	       
	       translate([-mount1Width / 2 + swivelWidth/ 2, 0, -swivelWidth / 2 - mount1Height / 2]) // cut out for adjoing part of mount2
		    cube([swivelWidth * overSize, mount1Depth / 2 + 0.5, swivelWidth], center = true); // make the cut out 0.5mm wider
	       
	       translate([-mount1Width / 2 + swivelWidth / 2, -mount1Depth / 2, -swivelWidth / 2 - mount1Height / 2]) // swivel screw hole
		    rotate([90, 0, 0])
		    cylinder(mount1Depth * overSize, (swivelScrewDia + 0.5) / 2, (swivelScrewDia + 0.5) / 2, center = true);
	       translate([-mount1Width / 2 + swivelWidth / 2, mount1Depth / 2, -swivelWidth / 2 - mount1Height / 2]) // swivel screw hole
		    rotate([90, 0, 0])
		    cylinder(mount1Depth * overSize, (swivelScrewDia - 0.5) / 2, (swivelScrewDia - 0.5) / 2, center = true);
	  }
     }
}

module mount2() {
     union() {
	  difference() { // main body of mount2
	       union() {
		    cube([mount2Width, mount2Depth, mount2Height], center = true); // main body of mount2
		    
		    translate([0, mount2Depth / 2 + mount2ExtraDepth / 2, 0]) // extra piece for adjustment screw
			 cube([mount2Width, mount2ExtraDepth, mount2Height], center = true);
	       }
	       translate([0, -mount2Depth / 2 + mount1YMove / 2 + 2.5, 0]) // pin header cut out            
		    cube([20, (pinHeaderCutOut + mount1YMove) * overSize, mount2Height * overSize], center = true);

	       translate([0, mount1YMove, 0])
		    union()  {
		    translate([mount1Width / 2 - springHoleDia / 2 - adjScrewEdgeDist, 0, 0]) // hole for X adjusmentscrew
			 cylinder(mount2Height * overSize, (swivelScrewDia - 0.5) / 2, (swivelScrewDia - 0.5) / 2, center = true);
		    
		    translate([mount1Width / 2 - springHoleDia / 2 - adjScrewEdgeDist, 0, mount2Height / 2 - springRecess / 2]) // spring recess hole, X-axis
			 cylinder(springRecess * overSize, springHoleDia / 2, springHoleDia / 2, center = true);
		    translate([mount1Width / 2 - springHoleDia / 2 - adjScrewEdgeDist, 0, -mount2Height / 2 + nutHeight / 2]) // nut for X adjustment screw
			 cylinder(nutHeight * overSize, nutDia / 2, nutDia / 2, $fn = 6, center = true);
	       }
	       
	       translate([0, mount2Depth / 2 + mount2ExtraDepth - springHoleDia / 2 - adjScrewEdgeDist, 0]) // hole for Y adjusmentscrew
                    cylinder(mount1Height * overSize, (swivelScrewDia + 0.5) / 2, (swivelScrewDia + 0.5) / 2, center = true);

               translate([0, mount2Depth / 2 + mount2ExtraDepth - springHoleDia / 2 - adjScrewEdgeDist, -mount1Height / 2 + springRecess / 2]) // spring recess hole, Y-axis
                    cylinder(springRecess * overSize, springHoleDia / 2, springHoleDia / 2, center = true );
	       
	  }

	  translate([0, mount1YMove, 0])
	       difference() {
	       union() { // swivel to X adjustement
		    translate([-mount2Width / 2 + swivelWidth / 2, 0, swivelWidth / 4 + mount2Height / 2])
			 cube([swivelWidth, mount2Depth / 2, swivelWidth / 2], center = true);

		    translate([-mount2Width / 2 + swivelWidth / 2, 0, swivelWidth / 2 + mount2Height / 2]) // swivel point 
                         rotate([90, 0, 0])
                         cylinder(mount1Depth / 2, swivelWidth / 2, swivelWidth / 2, center = true);
	       }
	       translate([-mount2Width / 2 + swivelWidth / 2, 0, swivelWidth /2 + mount2Height / 2]) // swivel screw hole                   
                    rotate([90, 0, 0])
                    cylinder(mount2Depth / 2 * overSize, (swivelScrewDia + 0.5) / 2, (swivelScrewDia + 0.5) / 2, center = true);
	  }
	  difference() {
               union() { // swivel to Y adjustemen
		    translate([0, -mount2Depth / 2 + swivelWidth / 2, -swivelWidth / 4 - mount2Height / 2])
			 cube([mount2Width, swivelWidth, swivelWidth / 2], center = true);

		    translate([0, -mount2Depth / 2 + swivelWidth / 2, -swivelWidth / 2 - mount2Height / 2])
			 rotate([0, 90, 0])
			 cylinder(mount2Width, swivelWidth / 2, swivelWidth / 2, center = true);
	       }
	       
	       translate([0, (-mount2Depth / 2 + swivelWidth / 2), (-swivelWidth / 2 - mount1Height / 2)]) // make center cutout of swivel
		    
		    cube([mount2Width / 2 + 0.5, swivelWidth * overSize, swivelWidth * overSize], center = true);

	       translate([mount2Width / 2, -mount2Depth / 2 + swivelWidth / 2, -swivelWidth / 2 - mount2Height / 2])
                         rotate([0, 90, 0])
                         cylinder(mount2Width * overSize, (swivelScrewDia + 0.5) / 2, (swivelScrewDia + 0.5) / 2, center = true);

	       translate([-mount2Width / 2, -mount2Depth / 2 + swivelWidth / 2, -swivelWidth / 2 - mount2Height / 2])
                         rotate([0, 90, 0])
                         cylinder(mount2Width * overSize, (swivelScrewDia - 0.5) / 2, (swivelScrewDia - 0.5) / 2, center = true);

	  }
     }
}

module mount3() {
     union () {
          difference() { // main body of mount3
	       union() {
		    cube([mount3Width, mount3Depth, mount3Height], center = true); // main body of mount3
		    translate([0, mount3Depth / 2 + mount3ExtraDepth / 2, 0]) // extra piece for adjustment screw			 
			 cube([mount3Width, mount3ExtraDepth, mount3Height], center = true);
}
		    translate([0, 0, 0])
		    baseMount(0);

               translate([0, mount2Depth / 2 + mount2ExtraDepth - springHoleDia / 2 - adjScrewEdgeDist, 0]) // hole for Y adjustment screw
                    cylinder(mount2Height * overSize, (swivelScrewDia - 0.5) / 2, (swivelScrewDia - 0.5) / 2, center = true);
	       
               translate([0, mount2Depth / 2 + mount2ExtraDepth - springHoleDia / 2 - adjScrewEdgeDist, mount2Height / 2 - springRecess / 2]) // spring recess hole, Y-axis
                    cylinder(springRecess * overSize, springHoleDia / 2, springHoleDia / 2, center = true);

	       translate([0, mount2Depth / 2 + mount2ExtraDepth - springHoleDia / 2 - adjScrewEdgeDist, -mount2Height / 2 + nutHeight / 2]) // nut for Y adjustment recess
		    cylinder(nutHeight * overSize, nutDia / 2, nutDia / 2, $fn = 6, center = true);
	  }
	  difference() {
	       union() {
		    translate([0, -mount3Depth / 2 + swivelWidth / 2, +swivelWidth / 4 + mount3Height / 2])
                         cube([mount3Width / 2, swivelWidth, swivelWidth / 2], center = true);
		    
                    translate([0, -mount3Depth / 2 + swivelWidth / 2, +swivelWidth / 2 + mount3Height / 2])
                         rotate([0, 90, 0])
                         cylinder(mount3Width / 2, swivelWidth / 2, swivelWidth / 2, center = true);
	       }
	       translate([0, -mount3Depth / 2 + swivelWidth / 2, +swivelWidth / 2 + mount3Height / 2])
                         rotate([0, 90, 0])
                         cylinder(mount3Width, (swivelScrewDia + 0.5) / 2, (swivelScrewDia + 0.5) / 2, center = true);
	  }
     }
}

module mount4() {
     difference() {
	  union() {
	       cube([mount4Width, mount4Depth, mount4Height], center = true); // main body of mount4
	       translate([0, mount4Depth / 2 + mount4ExtraDepth / 2, 0]) // extra piece
		    cube([mount4Width, mount4ExtraDepth, mount4Height], center = true);
	       
	       translate([0, 0, mount4Height])
		    baseMount(0.2);
	  }
	  translate([0, 0, mount4Height / 4])
	       cube([mount4Width / 3, mount4Depth, mount4Height / 2], center = true);
	  
	  translate([0, mount4Depth / 2 + mount4ExtraDepth / 2, mount4Height / 4]) // extra piece
	       cube([mount4Width / 3, mount4ExtraDepth, mount4Height / 2], center = true);
     }
}


module baseMount(sizeFactor) {
     translate([-mount3Width / 8 * 3 - sizeFactor, 0, 0])
	  difference() {
	  union() {
	       cube([mount3Width / 4 - sizeFactor * 2, mount3Depth, mount3Height], center = true);
	       
	       translate([0, mount3Depth / 2 + mount3ExtraDepth / 2, 0]) // extra piece
		    cube([mount3Width / 4  - sizeFactor * 2, mount3ExtraDepth, mount3Height], center = true);
	  }	  
	  translate([mount3Width / 8 - sizeFactor, (mount3Depth + mount3ExtraDepth) / 2 + mount3ExtraDepth / 2, -mount3Height / 2])
	       rotate([0, 0, 180])
	       prismFlatDown(mount3Depth + mount3ExtraDepth, mount3Width / 8, mount3Height);
     }
     
     translate([mount3Width / 8 * 3 + sizeFactor, 0, 0])
          difference() {
          union() {
               cube([mount3Width / 4 - sizeFactor * 2, mount3Depth, mount3Height], center = true);
	       
               translate([0, mount3Depth / 2 + mount3ExtraDepth / 2, 0]) // extra piece
                    cube([mount3Width / 4 - sizeFactor * 2, mount3ExtraDepth, mount3Height], center = true);
	  }
	  translate([-mount3Width / 8 + sizeFactor, -mount3Depth / 2, -mount3Height / 2])
	       prismFlatDown(mount3Depth + mount3ExtraDepth, mount3Width / 8, mount3Height);
     }
}

module mpu6050_gy521() {
     include <misc_parts.scad>;

     x = 21; y = 15.6; z = 1.2;
     color([30/255, 114/255, 198/255])
          linear_extrude(height=z) {
          difference() {
	       square(size = [x, y]);
	       translate([3, y-3]) circle(r=1.5, $fn=24);
	       translate([x-3, y-3]) circle(r=1.5, $fn=24);
          }
     }
     translate([8.3, 5.6, z])
          color([60/255, 60/255, 60/255])
          cube(size=[4.0, 4.0, 0.9]);
     translate([0.34, 2.54, 0])
          rotate(a=180, v=[1, 0, 0])
          pin_headers(8, 1);
}

module prismFlatDown(l, w, h) {          // l = Y, w = X, h = Z
     polyhedron(points=[
                     [0,0,h],            // 0    front top corner
                     [0,0,0], [w,0,0],   // 1, 2 front left & right bottom corners
                     [0,l,h],            // 3    back top corner
                     [0,l,0], [w,l,0]    // 4, 5 back left & right bottom corners
                     ],
                faces=[ // points for all faces must be ordered clockwise when looking in
                     [0,2,1],    // top face
                     [3,4,5],    // base face
                     [0,1,4,3],  // h face
                     [1,2,5,4],  // w face
                     [0,3,5,2],  // hypotenuse face
                     ]);
}
