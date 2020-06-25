mpu6050_gy521();

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
