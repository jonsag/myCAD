// ATX PSU Bench Power Supply

// Variables
//###############
// Width, height and thickness of front
front_width = 190;
front_height = 180;
front_thickness = 3;

// Number of objects
number_of_objects_horisontally = 6;
number_of_objects_vertically = 6;
hole_clearance = 0.5;

// Mount Holes
no_mount_holes = 3; // no of holes on each edge
mount_hole_diameter = hole_clearance + 4;
mount_hole_distance_from_edge = 10;
mount_hole_distance_from_corner = 30;

// Fuse holders
fuse_holder_diameter = hole_clearance + 13;

// Power outlets
banana_jack_diameter = hole_clearance + 6;

// Toggle switch and LEDs
toggle_switch_diameter = hole_clearance + 12.2;
led_hole_diameter = hole_clearance + 5;

// rotary_switch_and_instrument()
rotary_switch_diameter = hole_clearance + 10;
instrument_width = hole_clearance + 44.8;
instrument_height = hole_clearance + 25.8;

// USB outlets
usb_width = hole_clearance + 13;
usb_height = hole_clearance + 6;

// Front rounding and bevels
front_corner_radius = 5;
front_edge_bevels = 1;

// Text pads
text_pad_width = 15;
text_pad_height = 5;
text_pad_thickness = 2;
text_pad_corner_radius = 2;
text_size = 4;
text_font = "Liberation Sans";
text_thickness = 1;
text_color = "red";

// Text
function text_lookup(x) = x == 0 ? "+3.3V"
     : x == 1 ? "+5V"
     : x == 2 ? "+5V"
     : x == 3 ? "+12V"
     : x == 4 ? "+12V"
     : x == 5 ? "USB"
     : x == 6 ? "Load"
     : x == 7 ? "Vin"
     : x == 8 ? "ON"
     : x == 9 ? "SB" : "xxx";


// Placement
objects_distance_from_leftnright_edge = 30;
objects_distance_from_uppernlower_edge = 30;
horisontal_distance_between_objects = (front_width - objects_distance_from_leftnright_edge * 2) / (number_of_objects_horisontally - 1);
vertical_distance_between_objects = (front_height - objects_distance_from_uppernlower_edge * 2) / (number_of_objects_vertically -1 );

				     
// Misc variables
hole_roundness = 30;
debug = 1;

// create front
union() {
     difference() {
	  if (debug == 1) {
	       echo ("--- Creating front...");
	       echo("size-corner radius:", front_width, "x", front_height, "-", front_corner_radius);
	  }
	  
	  round_square(front_width, front_height, front_thickness, front_corner_radius);
	  
	  front_edge_bevels();
	  
// make holes
	  mount_holes();
	  
	  fuse_holders();
	  
	  power_outlets();
	  
	  meter_intakes();
	  
	  toggle_switch_and_leds();
	  
	  rotary_switch_and_instrument();
	  
	  usb_outlets();
     }
text_pads();
}



     
module mount_holes() {
     if	(debug == 1) {
          echo ("--- Making mount holes...");
     }
     
     // horisontal holes
     x_start = mount_hole_distance_from_corner;
     x_end = front_width - mount_hole_distance_from_corner;
     x_increments = (x_end - x_start) / (no_mount_holes - 1);
     y1 = mount_hole_distance_from_edge;
     y2 = front_height - mount_hole_distance_from_edge;

     if (debug == 1) {
               echo("--- Horisontal mount holes");
          }
     
     for (x =[x_start: x_increments: x_end + 1]) {
	  if (debug == 1) {
	       echo("x-y lower-y upper-diameter: ", x, "-", y1, "-", y2, "-", mount_hole_diameter);
	  }
	  // lower holes
	  translate([x, y1, 0]) {
	       cylinder($fn = hole_roundness, h = front_thickness, d = mount_hole_diameter, center = false);
	  }
	  // top holes
	  translate([x, y2, 0]) {
	       cylinder($fn = hole_roundness, h = front_thickness, d = mount_hole_diameter, center = false);
	  }
     }
        
     // vertical holes
     y_start = mount_hole_distance_from_corner;
     y_end = front_height - mount_hole_distance_from_corner;
     y_increments = (y_end - y_start) / (no_mount_holes - 1);
     x1 = mount_hole_distance_from_edge;
     x2 = front_width - mount_hole_distance_from_edge;

     if (debug == 1) {
               echo("--- Vertical holes");
          }
     
     for (y =[y_start: y_increments: y_end + 1]) {
	  if (debug == 1) {
               echo("x left-x right, y-diameter: ", x1, "-", x2, "-", y, "-", mount_hole_diameter);
          }

	  // left holes
	  translate([x1, y, 0]) {
	       cylinder($fn = hole_roundness, h = front_thickness, d = mount_hole_diameter, center = false);
	  }
	  // right holes
	  translate([x2, y, 0]) {
	       cylinder($fn = hole_roundness, h = front_thickness, d = mount_hole_diameter, center = false);
	  }
     }
}

module fuse_holders() {
     if	(debug == 1) {
          echo ("--- Making holes for fuse holders...");
     }
     
     y = objects_distance_from_uppernlower_edge;
     
     // power outlets fuse holders
     if (debug == 1) {
               echo("--- Power outlets fuse holders");
          }
     
     for (fuse_no =[0: number_of_objects_horisontally - 1]) {
	  x = objects_distance_from_leftnright_edge + horisontal_distance_between_objects * fuse_no;
	  
	  if (debug == 1) {
               echo("x-y-diameter:", x, "-", y, "-", fuse_holder_diameter);
          }
	  
	  translate([x, y, 0]) {
	       cylinder($fn = hole_roundness, h = front_thickness, d = fuse_holder_diameter, center = false);
	  }
     }
     
     // top fuse hole
     x2 = front_width / 2;
     y2 = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 3;
     
     if (debug == 1) {
               echo("--- Making hole for amp meter fuse holder");
	       echo("x-y-diameter:", x2, "-", y2, "-", fuse_holder_diameter);
          }
     
     translate([x2, y2, 0]) {
	  cylinder($fn = hole_roundness, h = front_thickness, d = fuse_holder_diameter, center = false);
     }
}

module power_outlets() {
     if	(debug == 1) {
          echo ("--- Making holes for power outlets...");
     }
     
     x_start = objects_distance_from_leftnright_edge;
     x_end = front_width - objects_distance_from_leftnright_edge;
     
     for (y_counter = [1:2]) {
	  for (x =[x_start: horisontal_distance_between_objects: x_end + 1]) {
	       if (x < front_width - objects_distance_from_leftnright_edge) {
		    y = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * y_counter;

		    if (debug == 1) {
			 echo("x-y-diameter: ", x, "-", y, "-", banana_jack_diameter);
		    }
		    
		    translate([x, y, 0]) {
			 cylinder($fn = hole_roundness, h = front_thickness, d = banana_jack_diameter, center = false);
		    }

	       }
	  }
     }
}

module meter_intakes() {
     if (debug == 1) {
          echo ("--- Making holes for meter intakes...");
     }
     
     x_start = front_width / 2;
     y_start = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 4;
     
     for (x_counter =[0:1]) {
	  for (y_counter =[0:1]) {
	       x = x_start + horisontal_distance_between_objects * x_counter;
	       y = y_start + vertical_distance_between_objects * y_counter;

	       if (debug == 1) {
		    echo("x-y-diameter: ", x, "-", y, "-", banana_jack_diameter);
	       }
	       
	       translate([x, y, 0]) {
                    cylinder($fn = hole_roundness, h = front_thickness, d = banana_jack_diameter, center = false);
               }
	  }
     }        
}

module toggle_switch_and_leds() {
     if (debug == 1) {
          echo ("--- Making holes for on switch and LEDs...");
     }

     // power switch
     x_switch = objects_distance_from_leftnright_edge + horisontal_distance_between_objects * 5;
     y_switch = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 3;

     if (debug == 1) {
	  echo("--- Power switch");
	  echo("x-y-diameter: ", x_switch, "-", y_switch, "-", toggle_switch_diameter);
     }
     
     translate([x_switch, y_switch, 0]) {
                    cylinder($fn = hole_roundness, h = front_thickness, d = toggle_switch_diameter, center = false);
               }

     // leds
     y_on = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 4;
     y_sb = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 5;

     if (debug == 1) {
          echo("--- LEDs");
     }

     for (y =[y_on, y_sb]) {
	  if (debug == 1) {
	       echo("x-y-diameter: ", x_switch, "-", y, "-", led_hole_diameter);
	  }

	  translate([x_switch, y, 0]) {
	       cylinder($fn = hole_roundness, h = front_thickness, d = led_hole_diameter, center = false);
	  }
     }
}

module rotary_switch_and_instrument() {
     if (debug == 1) {
          echo ("--- Making holes for selection switch and instrument...");
     }

     // rotary switch
     x_switch = objects_distance_from_leftnright_edge + horisontal_distance_between_objects;
     y_switch = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 3;

     if (debug == 1) {
	  echo("--- Rotary switch");
	  echo("x-y-diameter: ", x_switch, "-", y_switch, "-", rotary_switch_diameter);
     }

     translate([x_switch, y_switch, 0]) {
	  cylinder($fn = hole_roundness, h = front_thickness, d = rotary_switch_diameter, center = false);
     }

     // instrument
     x_instrument_start = x_switch;
     y_instrument_start = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 4 + vertical_distance_between_objects / 2;
     z = front_thickness / 2;

     if (debug == 1) {
          echo("--- Instrument");
          echo("x-y-size: ", x_instrument_start, "-", y_instrument_start, "-", instrument_width, "x", instrument_height);
     }

     translate([x_instrument_start, y_instrument_start, z]) {
          cube(size = [instrument_width, instrument_height, front_thickness], center = true);
     }	       
}

module usb_outlets() {
     if (debug == 1) {
          echo ("--- Making holes for usb outlets...");
     }

     x_usb = objects_distance_from_leftnright_edge + horisontal_distance_between_objects * 5;
     y_usb = objects_distance_from_uppernlower_edge + vertical_distance_between_objects;
     y_increments = vertical_distance_between_objects / 2;
     z = front_thickness / 2;
     
     for (y_counter =[0:2]) {
	  y = y_usb + y_increments * y_counter;
	  if (debug == 1) {
	       echo("x-y-size: ", x_usb, "-", y, "-", usb_width, "x", usb_height);
	  }
	  translate([x_usb, y, z]) {
               cube(size = [usb_width, usb_height, front_thickness], center = true);
          }
     }
}

module round_square(x, y, z, r){
     c = "red";
     hull(){
	  translate([r / 2, r / 2, 0]) {
	       color(c) cylinder($fn = hole_roundness, h=z, d=r);
	  }
	  translate([-r / 2 + x, r/2, 0]) {
	       color(c) cylinder($fn = hole_roundness, h=z, d=r);
	  }
	  translate([ r / 2, - r / 2 + y, 0]) {
	       color(c) cylinder($fn = hole_roundness, h=z, d=r);
	  }
	  translate([ -r / 2 + x, -r / 2 + y, 0]) {
	       color(c) cylinder($fn = hole_roundness, h=z, d=r);
	  }
     }
}

module text_pads() {
     if (debug == 1) {
          echo ("--- Creating text pads...");
     }
     
     y = objects_distance_from_uppernlower_edge + vertical_distance_between_objects / 2 - text_pad_height / 2;

     // power outlets fuse holders                                                                                                                                                             
     if (debug == 1) {
               echo("--- Power outlets pads");
     }

     for (pad_no =[0: number_of_objects_horisontally - 1]) {
          x = objects_distance_from_leftnright_edge + horisontal_distance_between_objects * pad_no - text_pad_width / 2;

          if (debug == 1) {
	       echo("x-y-size:", x, "-", y, "-", text_pad_width, "x", text_pad_height, "x", text_pad_thickness);
          }

          translate([x, y, front_thickness]) {
	       round_square(text_pad_width, text_pad_height, text_pad_thickness, text_pad_corner_radius);
          }

	  print_text_on_power_outlet_pads(x, y, pad_no);
     }
 
     // meter intakes
     if (debug == 1) {
               echo("--- Meter intake pads");
     }
     
     y2 = objects_distance_from_uppernlower_edge + vertical_distance_between_objects * 4 + vertical_distance_between_objects / 2 - text_pad_height / 2;
     x1 = front_width / 2 - text_pad_width / 2;
     x2 = x1 + horisontal_distance_between_objects;

     for (x3 =[x1, x2]) {
	  if (debug == 1) {
               echo("x-y-size:", x3, "-", y2, "-", text_pad_width, "x", text_pad_height, "x", text_pad_thickness);
          }

          translate([x3, y2, front_thickness]) {
               round_square(text_pad_width, text_pad_height, text_pad_thickness, text_pad_corner_radius);
          }

	  // printing text
	  y4 = y2 + text_pad_height / 2;
	  z = front_thickness + text_pad_thickness + text_thickness / 2;

	  if (x3 == x1) { // printing "A"
	       x5 = x1 + text_pad_width / 2;
		    
	       pad_text = text_lookup(number_of_objects_horisontally);

	       if (debug == 1) {
		    echo("--- Printing text:", pad_text);
	       }

	       translate([x5, y4, z]) {
		    color(text_color) linear_extrude(height = text_thickness) text(pad_text, size = text_size, font = text_font, halign = "center", valign = "center");
	       }
	  }
	  else { // printing "V"
	       x6 = x2 + text_pad_width / 2;

	       pad_text = text_lookup(number_of_objects_horisontally + 1);

               if (debug == 1) {
                    echo("--- Printing text:", pad_text);
               }

               translate([x6, y4, z]) {
                    color(text_color) linear_extrude(height = text_thickness) text(pad_text, size = text_size, font = text_font, halign = "center", valign = "center");
               }
	  }
     }

     // on switch and led, sb led
     if (debug == 1) {
               echo("--- On switch and PG pads");
     }

     x4 = objects_distance_from_leftnright_edge + horisontal_distance_between_objects * 5 - text_pad_width / 2;
     y3 = y2 - vertical_distance_between_objects;

     for (y4 =[y3, y2]) {
          if (debug == 1) {
               echo("x-y-size:", x4, "-", y4, "-", text_pad_width, "x", text_pad_height, "x", text_pad_thickness);
          }

          translate([x4, y4, front_thickness]) {
               round_square(text_pad_width, text_pad_height, text_pad_thickness, text_pad_corner_radius);
          }

	  // printing text
	  x7 = x4 + text_pad_width / 2;
	  z = front_thickness + text_pad_thickness + text_thickness / 2;
	  
	  if (y4 == y3) { // printing "ON"
	       y5 = y3 + text_pad_height / 2;

	       pad_text = text_lookup(number_of_objects_horisontally + 2);

               if (debug == 1) {
                    echo("--- Printing text:", pad_text);
               }

               translate([x7, y5, z]) {
                    color(text_color) linear_extrude(height = text_thickness) text(pad_text, size = text_size, font = text_font, halign = "center", valign = "center");
               }

	  }
	  else { // printing "SB"
	       y6 = y3 + vertical_distance_between_objects + text_pad_height / 2;

               pad_text = text_lookup(number_of_objects_horisontally + 3);

               if (debug == 1) {
                    echo("--- Printing text:", pad_text);
               }

               translate([x7, y6, z]) {
                    color(text_color) linear_extrude(height = text_thickness) text(pad_text, size = text_size, font = text_font, halign = "center", valign = "center");
               }

	  }
     }
}

module print_text_on_power_outlet_pads(x, y, pad_no) {
     x1 = x + text_pad_width / 2;
     y1 = y + text_pad_height / 2;
     z = front_thickness + text_pad_thickness + text_thickness / 2;
     
     pad_text = text_lookup(pad_no);
     
     if (debug == 1) {
               echo("--- Printing text:", pad_text);
          }

     translate([x1, y1, z]) {
               color(text_color) linear_extrude(height = text_thickness) text(pad_text, size = text_size, font = text_font, halign = "center", valign = "center");
          }
}

module front_edge_bevels() {
     if (debug == 1) {
          echo ("--- Beveling the front edges...");
     }

     // nothing here at the monent
}
