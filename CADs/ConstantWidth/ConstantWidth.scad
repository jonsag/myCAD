// ConstantCircumference.scad

// Design: Jon Sagebrand
// jonsagebrand@gmail.com

shapeHeight = 100;

drawTriangle = true;

drawPentagon = true;

///// triangle /////
triangleHeight = shapeHeight * sqrt(3) / 2;

echo("Triangle diameter: ", shapeHeight);

if (drawTriangle) {
  
  moveTriangle = drawPentagon ? -shapeHeight / 2 - 10 : 0;
  
  translate([moveTriangle, 0, 0])
    rotate_extrude($fn = 200)
    translate([0, shapeHeight - triangleHeight, 0])
    intersection() {
    
    color("red", 0.5) // the triangle
      translate([-shapeHeight / 2, 0, 0])
      circle(r = shapeHeight);
    
    color("blue", 0.5) // circles
      translate([shapeHeight / 2, 0, 0])
      circle(r = shapeHeight);
    
    color("green", 0.5)
      translate([0, triangleHeight, 0])
      circle(r = shapeHeight);
    
    color("grey", 0.25)
      translate([0, -shapeHeight + triangleHeight, 0])
      square(size = [shapeHeight / 2, shapeHeight]);
  }
 }

///// pentagon /////
if (drawPentagon) {
  // https://mathworld.wolfram.com/RegularPentagon.html

  // height = y1 + c2
  // y1 = c2 / height -->
  // pentagonRadius = c2 / shapeHeight

  goldenRatio = 1.61803398875;
  
  s1 = sqrt(10 + 2 * sqrt(5)) / 4; // sin(2 * PI / 5);
  c1 = (sqrt(5) - 1) / 4; // cos(2 * PI / 5);
  s2 = sqrt(10 - 2 * sqrt(5)) / 4; // sin(4 * PI / 5);
  c2 = (sqrt(5) + 1) / 4; // cos(PI / 5);
  
  pentagonRadius = shapeHeight / c2 / 2 / s2 / 2 ;
  
  x1 = 0 * pentagonRadius;
  y1 = 1 * pentagonRadius;
  x2 = s1 * pentagonRadius;
  y2 = c1 * pentagonRadius;
  x3 = s2 * pentagonRadius;
  y3 = -c2 * pentagonRadius;
  x4 = -s2 * pentagonRadius;
  y4 = -c2 * pentagonRadius;
  x5 = -s1 * pentagonRadius;
  y5 = c1 * pentagonRadius;

  pentagonTop = (x3 - x4) * goldenRatio;

  echo("Pentagon diameter: ", pentagonTop);
  
  points4 = [[x1, y1], [x2, y2], [x3, y3], [x4, y4], [x5, y5]];

  points43D = [[x1, y1, 0], [x2, y2, 0], [x3, y3, 0], [x4, y4, 0], [x5, y5, 0]];

  colors = ["azure", "grey", "red", "blue", "green", "pink"];

  movePentagon = drawTriangle ? pentagonRadius + 10: 0;

  translate([movePentagon, 0, 0])
    rotate_extrude($fn = 200)
  translate([0, (x3 - x4) * goldenRatio - y1 + y3, 0])
    intersection() {
    //translate([0, -y3, 0])
    //polygon(points = points4); // drawing the polygon

    intersection_for(i = [0 : 4]) { // drawing the circles
      translate([0, -y3, 0])
	translate(points43D[i])
	color(colors[i], 0.4)
	circle(r = (x3 - x4) * goldenRatio);
    }

    
    translate([0, -((x3 - x4) * goldenRatio - y1 + y3), 0])
      square(size = [x2, y1 - y3 + ((x3 - x4) * goldenRatio - y1 + y3)]);
  }
 }
