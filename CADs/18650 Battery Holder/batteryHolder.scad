// batteryHolder.scad
// by Jon Sagebrand

// size of the battery cells
cellLength = 70.5;
cellDia = 19;
cellDiaExtra = 0; // extra space for the cell

cellPosDia = 5.5;
cellPosHeight = 1; // height of the protrusion of the postive side

contPosLargeDia = 10;
contPosSmallDia = 2;

// battery contacts
contWidth = 16.5;
contHeight = 16;
contThick = 0.3;

contPosHeight = 2.4;
contNegHeight = 8;

termWidth = 3.5;
termLength = 7;

// now include the other file
include <18650Battery.scad>

// how many cells
noOfCells = 4;

// also draw the cells and contacts
drawCell = true;

// how far away from the cells are the contacts
negCOffset = 0;
posCOffset = 0;

// extra distance from the cells to the contacts base
compPosExtra = 2.5;
compNegExtra = 8;

// the flange holding the contacts
terminalHolderDepth = 1.5;

// wall thickness of holder
wallThickness = 2;

// the cut outs for the contacts
termWidthExtra = 2;
termHeight = 5;

///// calculations
thWidth = cellDia + cellDiaExtra;
thHeight = cellDia + cellDiaExtra;

thDepth = terminalHolderDepth;

///// start drawing /////
for (i = [0:noOfCells - 1])
{
	translate([ (cellDia + cellDiaExtra + wallThickness) * i, 0, 0 ])
	if (i / 2 == round(i / 2))
	{
		rotate([ 0, 0, 0 ])
		cell_n_holders();
	}
	else
	{
		translate([ 0, compPosExtra - compNegExtra, 0 ])
		rotate([ 0, 0, 180 ])
		cell_n_holders();
	}
}

module cell_n_holders()
{
	// battery cell
	if (drawCell)
	{
		rotate([ -90, 0, 0 ])
		translate([ 0, 0, 0 ])
		battery_n_terminals();
	}

	difference()
	{
		union()
		{
			// positive contact holder
			translate([ 0, cellLength / 2 + posCOffset + compPosExtra, 0 ])
			rotate([ 0, 0, 0 ])
			terminalHolder();

			// negative contact holder
			translate([ 0, -cellLength / 2 + negCOffset - compNegExtra, 0 ])
			rotate([ 0, 0, 180 ])
			terminalHolder();

			// battery compartment
			batteryComp();
		}

		// terminal cut out
	}
}

module terminalHolder()
{
	translate([ 0, -thDepth / 2, 0 ])
	difference()
	{
		cube([ thWidth, thDepth, thHeight ], center = true);

		translate([ 0, thDepth / 4, (thHeight - contHeight) / 4 ])
		color("red")
		    cube([ contWidth, thDepth / 2 + 0.1, contHeight + (thHeight - contHeight) / 2 + 0.1 ], center = true);

		translate([ 0, -thDepth / 4, (thHeight - contHeight) / 4 + 1 ])
		color("red") cube([ contWidth - 4, thDepth / 2 + 0.1, contHeight + (thHeight - contHeight) / 2 - 2 + 0.1 ],
		                  center = true);
	}
}

module batteryComp()
{
	difference()
	{
		// outer shell
		translate([ 0, compPosExtra / 2 - compNegExtra / 2, 0 ])
		cube(
		    [
			    cellDia + cellDiaExtra + wallThickness * 2,
			    cellLength + wallThickness * 2 + compPosExtra + compNegExtra, cellDia + cellDiaExtra +
			    wallThickness
		    ],
		    center = true);

		// battery hole
		translate([ 0, compPosExtra / 2 - compNegExtra / 2, 0 ])
		translate([ 0, 0, wallThickness ])
		cube([ cellDia + cellDiaExtra, cellLength + compPosExtra + compNegExtra, cellDia + cellDiaExtra ],
		     center = true);

		// positive terminal cutout
		translate([
			0, cellLength / 2 + compPosExtra + wallThickness / 2,
			cellDia / 2 - termHeight / 2 + wallThickness / 2 + cellDiaExtra / 2
		])
		color("red") cube([ termWidth + termWidthExtra, wallThickness + 0.2, termHeight + 0.1 ], center = true);

		// negative terminal cutout
		translate([
			0, -cellLength / 2 - compNegExtra - wallThickness / 2,
			cellDia / 2 - termHeight / 2 + wallThickness / 2 + cellDiaExtra / 2
		])
		color("red") cube([ termWidth + termWidthExtra, wallThickness + 0.2, termHeight + 0.1 ], center = true);
	}
}
