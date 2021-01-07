// Solder\ Dispenser\ n\ Tool\ Holder

use <dovetail.scad>;

include <startmodule.scad>;
include <module1.scad>;
include <module2.scad>;
include <module3.scad>;
include <module4.scad>;
include <module5.scad>;
include <stopmodule.scad>;

// dove tails
dtHeight = 5;
noTeeth = 7;
teethDepth = 8;
teethClearance = 0.3;

// which modules to print
startmod = true;
mod1 = true; // flux, flux pen and brushes
mod2 = true; // solder roll, desoldering pump
mod3 = true; // solder iron holder, velleman
mod4 = true; // tip cleaner, solder iron tips
mod5 = true; // solder paste, syringe and tips
stopmod =true;

// base
//baseY = 100;
baseZ = 5;
//baseY = 0;
edgeSpace = teethDepth; // space from item to edge

// feet recesses
feetDia = 10;
feetRecess = 1;

/////// start and stop modules  ///////
stX = edgeSpace;

/////// module 1 ///////
// flux cup
fluxDia = 50;
fluxHeight = 7;
fluxWall = 3;

// flux brush
fluxBDia = 6;
fluxBHeight = 20;
fluxBWall = fluxWall;

// flux pen
fluxPDia = 18;
fluxPHeight = 30;
fluxPWall = fluxWall;

// pliers
plierX = 10;
plierY = 3;
plierZ = 15;
plierWall = fluxWall;
noPliers = 4;

mod1X = fluxDia + fluxWall * 2 + edgeSpace * 2;
//mod1Y = fluxDia + fluxWall * 2 + plierX + plierWall * 2 + 2 * (fluxBDia + fluxWall * 2) + edgeSpace * 5;
mod1Y = fluxDia + fluxWall * 2 + plierX + plierWall * 2 + 2 * (fluxBDia + fluxWall * 2) + edgeSpace * 3;

/////// module 2 ///////
// tin roll
rollX = 40;
rollDia = 55;
rollWall = fluxWall;

solderSlotX = 2;

// desolder braid
braidDia = 55;
braidDepth = 15;
braidWall = fluxWall;

// desoldering pump
pumpDia = 22;
pumpY = 40;

pumpRecess = 20;

pumpWall = fluxWall;

pumpTipDia = 7;
pumpTipY = 15;

mod2X = max(rollX + rollWall * 2 + edgeSpace * 2, braidDia + braidWall * 2 + edgeSpace * 2);
mod2Y = rollDia + rollWall * 2 + pumpDia + pumpWall * 2 + edgeSpace * 3 + braidDepth + braidWall;

/////// module 3 ///////
// solder iron stand
standOuterX = 85;
standThick = 1.5;
standWall = fluxWall;
standZ = 5;

mod3X = standOuterX + standWall * 2 + edgeSpace * 2;
mod3Y = 0;

/////// module 4 ///////
// tip cleaner holder
tipCleanDia = 92;
tipCleanHeight = 7;
tipCleanWall = fluxWall;

noSolderTips = 4;
solderTipDia = 8;
solderTipZ = 15;
solderTipWall = fluxWall;

mod4X = tipCleanDia + tipCleanWall * 2 + edgeSpace * 2;
mod4Y = tipCleanDia + tipCleanWall * 2 + solderTipDia + solderTipWall * 2 + edgeSpace * 3;
//mod4Y = tipCleanDia + tipCleanWall * 2 + edgeSpace * 2;

/////// module 5 ///////
// solder paste etc
solderPDia = 50;
solderPZ = 15;
solderPWall = fluxWall;

noSyrs = 2;

syrDia1 = 18;
syrDia2 = 10;

syrZTot = 50;
syrZWaist = 8;
syrZTip = 30;

syrTipDia = 6;

noTips = 4;

syrWall = fluxWall;

mod5X = solderPDia + solderPWall * 2 + edgeSpace * 2;
mod5Y = solderPDia + solderPWall * 2 + syrDia1 + solderPWall * 2 + syrTipDia + solderPWall * 2 + edgeSpace * 4;

// rendering options
roundness = 100;
// Set to 0.01 for higher definition curves (renders slower)
$fs = 0.25;
// center
centerIs = 0;

// calculated variables
baseHeight = baseZ;
baseY = max(mod1Y, mod2Y, mod3Y, mod4Y, mod5Y);
//baseY = 108;

teeth = [noTeeth, teethDepth, teethClearance];

echo(baseY);

/////// Rendering ///////
if(startmod) { /////// start module ///////
  startmodule();
}

if(mod1) { /////// module 1 ///////
     module1();
}

if(mod2) {	/////// module 2 ///////
     module2();
}

if(mod3) { /////// module 2 ///////
     module3();
}

if(mod4) { /////// module 4 ///////
     module4();
}

if(mod5) { /////// module 5 ///////
     module5();
}

if(stopmod) { /////// module 1 ///////
  stopmodule();
}

module doves(xWidth, yDepth) {
     // dovetails
	  intersection() {
	  dimension = [yDepth, xWidth + teethDepth * 2, dtHeight];
	  cube(size=[yDepth, xWidth + teethDepth * 2, dtHeight], center=true);
	  cutter(position=[0, (xWidth)/ 2 - teethDepth / 2 - teethClearance / 2, 0], dimension=dimension, teeths=teeth, male=true);
	  cutter(position=[0, -(xWidth  + teethDepth * 2) / 2  + teethDepth / 2+ teethClearance / 2, 0], dimension=dimension, teeths=teeth, male=false);
     }
}

module dovesstart(xWidth, yDepth) {
  // dovetails
  intersection() {
    dimension = [yDepth, xWidth + teethDepth * 2, dtHeight];
    cube(size=[yDepth, xWidth + teethDepth * 2, dtHeight], center=true);
    cutter(position=[0, -(xWidth  + teethDepth * 2) / 2  + teethDepth / 2+ teethClearance / 2, 0], dimension=dimension, teeths=teeth, male=false);
  }
}

module dovesstop(xWidth, yDepth) {
  // dovetails
  intersection() {
    dimension = [yDepth, xWidth + teethDepth * 2, dtHeight];
    cube(size=[yDepth, xWidth + teethDepth * 2, dtHeight], center=true);
    cutter(position=[0, (xWidth)/ 2 - teethDepth / 2 - teethClearance / 2, 0], dimension=dimension, teeths=teeth, male=true);
  }
}
