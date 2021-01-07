// AntennaClip

// rendering options
hole_roundness = 30;
// Set to 0.01 for higher definition curves (renders slower)
$fs = 0.25;

// base measurements
baseX = 15;
baseY = 15;
baseZ = 15;

baseRadius = 1;

centerIs = true;

// screw dimensions
screwDia = 3;
screwHeadDia = 6;

screwBottomThickness = 3;

screwDiaExtra = 0.5;
screwHeadDiaExtra = 1;

// antenna hole
antennaDia = 4.5;
antennaHoleCenter = 10;

// antenna wedge
wedgeWidth = 10;
wedgeLength = 20;

wedgePointZ = 3;

// create base cube
union() {
     difference() {
	  // draw base
          //color("Yellow")
	  roundedcube([baseX, baseY, baseZ], centerIs, baseRadius, "zmax");
	  
	  // screw hole
	  cylinder(baseZ, screwDia / 2 + screwDiaExtra / 2, screwDia / 2 + screwDiaExtra / 2, centerIs);
	  
	  // screw head hole
	  translate(v = [0, 0, screwBottomThickness])
	       cylinder(baseZ, screwHeadDia / 2 + screwHeadDiaExtra / 2, screwHeadDia / 2 + screwHeadDiaExtra / 2, centerIs);
	  
	  // antenna hole
	  translate(v = [0, 0, -baseZ / 2 + antennaHoleCenter])
	       rotate(a=[90, 0, 0])
	       cylinder(baseY, antennaDia / 2, antennaDia / 2, antennaDia, center = centerIs);
	  
	  // antenna wedge
	  difference() {
	       translate(v = [0, -baseY / 2, -baseZ / 2 + wedgePointZ ])
		    rotate(a=[90, 0, 90])
		    wedge(baseY, wedgeLength, wedgeWidth);
	       translate(v = [0, 0, -baseZ / 2 + antennaHoleCenter - antennaDia ])
		    cube(size = [baseX, baseY, baseZ / 2], center = centerIs);
	  }
     }
}

// More information: https://danielupshaw.com/openscad-rounded-corners/
module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
     // If single value, convert to [x, y, z] vector
     size = (size[0] == undef) ? [size, size, size] : size;
     
     translate_min = radius;
     translate_xmax = size[0] - radius;
     translate_ymax = size[1] - radius;
     translate_zmax = size[2] - radius;
     
     diameter = radius * 2;
     
     obj_translate = (center == false) ?
	  [0, 0, 0] : [
	       -(size[0] / 2),
	       -(size[1] / 2),
	       -(size[2] / 2)
	       ];
     
     translate(v = obj_translate) {
	  hull() {
	       for (translate_x = [translate_min, translate_xmax]) {
		    x_at = (translate_x == translate_min) ? "min" : "max";
		    for (translate_y = [translate_min, translate_ymax]) {
			 y_at = (translate_y == translate_min) ? "min" : "max";
			 for (translate_z = [translate_min, translate_zmax]) {
			      z_at = (translate_z == translate_min) ? "min" : "max";
			      
			      translate(v = [translate_x, translate_y, translate_z])
				   if (
					(apply_to == "all") ||
					(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
					(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
					(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
					) {
					sphere(r = radius);
				   } else {
					rotate = 
					     (apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
						  (apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
						  [0, 0, 0]
						  );
					rotate(a = rotate)
					     cylinder(h = diameter, r = radius, center = true);
				   }
			 }
		    }
	       }
	  }
     }
}

module wedge(l, w, h){
	  polyhedron(
          points=[[0,0,0], [l,0,0], [l,w,-h/2], [0,w,-h/2], [0,w,h/2], [l,w,h/2]],
          faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
          );
}
