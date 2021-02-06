
height = 7;
startDia = 4;

increments = 0.1;
no = 10;

wallThickness = 2;

baseX = (startDia + increments * no + wallThickness * 2) * (no - 1);
baseY = startDia + increments * no + wallThickness * 2 ;
baseZ = 2;

textDepth = 0.5;

roundness = 100;

difference() {
    color("red");
        cube([baseX, baseY, baseZ], center = true);

translate([0, 0, -baseZ / 2 + textDepth])
rotate([0, 180, 180])
color("red")
linear_extrude(height = 0.5)
       text(text = str("Od: ", startDia + wallThickness * 2, 
       "-", startDia + increments * (no - 1) + wallThickness * 2, 
       "  Id: ", startDia, "-", startDia + increments * (no - 1)), 
       font = "Liberation Sans", 
       size = baseY / 2, 
       valign = "center", 
       halign = "center");
}

for(extraDia = [0 : increments : increments * (no - 1)]) {
    xSpacing = baseX / no;

    echo("Inner dia: " , startDia + extraDia);

    translate([-baseX / 2 + xSpacing * (0.5 + extraDia / increments), 0, baseZ / 2 + height / 2])
    difference() {
        color("green")
            cylinder(h = height, d = startDia + extraDia + wallThickness * 2, center = true, $fn = roundness);
        color("red")
            cylinder(h = height, d = startDia + extraDia, center = true, $fn = roundness);
    }
}