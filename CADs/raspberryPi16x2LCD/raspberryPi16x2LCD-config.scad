// raspberryPi16x2LCD-config.scad

// include NopSCADLib
include <../../OpenSCADlibraries/NopSCADlib/core.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/displays.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/inserts.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/pcbs.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/screws.scad>

// what to show
print = true;

printBottom = false;
printLid = true;

// LCD cutout
hasLCD = false;

// buttons
hasButtons = false;

// threaded inserts
hasInserts = true;

// Raspberry Pi and mount posts
raspWidth = 85;
raspDepth = 56;
raspHeight = 17;

raspExtraHeight = 2;

mountPostDia = 10;
mountPostTopDia = 7;

mountPostHeight = 5;
mountPostTopHeight = 2;

mountHoleDia = 5;

// lid
lidRecess = 1;

lidMountDia = 9;
lidMountHeight = 8;

lidScrewHoleDia = 3.5;

lidMountScrewDia = 5;

// LCD
displayWidth = 72;
displayDepth = 25;
displayExtra = 0;

LCDXOffset = 0;
LCDYOffset = 10;

displayXOffset = 0;
displayYOffset = 0;

LCDProtrusion = 0;

// Buttons
buttonDia = 6;

buttonTexts = [ "1", "2", "3", "4" ];
buttonColor = [ "yellow", "blue", "green", "red" ];

textXOffset = 0;
textYOffset = -10;

buttonsXOffset = 0;
buttonsYOffset = -20;

font = "Liberation Sans";
textSize = 5;

// the box
wallThickness = 2;

extraXPlus = 0;
extraXMinus = 0;

extraYPlus = 0;
extraYMinus = 0;

extraZ = 0;

raspClearance = 1;

makeMountHoles = true;
boxMountsDia = 4.5;

ventilationX = true;
ventilationY = true;

// cutouts for RPi in box
phonoDia = 7;

pwWidth = 10;
pwHeight = 5;

hdmiWidth = 20;
hdmiHeight = 8;

ethernetWidth = 18;
ethernetHeight = 15;

usbWidth = 16;
usbHeight = 17;

// display
postHeightDisp = 6;
postDiaDisp = 6;
mountHoleDiaDisp = 2.5;

// misc
roundness = 100;

///// calculatons, don't touch!
boxWidth = raspWidth + wallThickness * 2 + raspClearance * 2 + extraXPlus +
           extraXMinus;
boxDepth = raspDepth + wallThickness * 2 + raspClearance * 2 + extraYPlus +
           +extraYMinus +
           (lidMountScrewDia + (lidMountDia - lidMountScrewDia) / 2) * 2;
boxHeight = wallThickness + mountPostHeight + mountPostTopHeight + raspHeight +
            raspExtraHeight + lidRecess + extraZ + 2;

mountPostZ = -mountPostHeight / 2 - mountPostTopHeight;
postPos = [
    [ -raspWidth / 2 + 3.5, -raspDepth / 2 + 3.5, mountPostZ ],
    [ -raspWidth / 2 + 3.5 + 58, -raspDepth / 2 + 3.5, mountPostZ ],
    [ -raspWidth / 2 + 3.5 + 58, -raspDepth / 2 + 3.5 + 49, mountPostZ ],
    [ -raspWidth / 2 + 3.5, -raspDepth / 2 + 3.5 + 49, mountPostZ ]
];

lidMountPosZ = -lidMountHeight / 2 + raspHeight + extraZ + raspExtraHeight;
mountWallThickness = min((lidMountDia - lidMountScrewDia) / 2, wallThickness);
lidMountPos = [
    [
        -boxWidth / 2 + lidMountDia / 2 + wallThickness - mountWallThickness,
        -boxDepth / 2 + lidMountDia / 2 + wallThickness - mountWallThickness,
        lidMountPosZ
    ],
    [
        boxWidth / 2 - lidMountDia / 2 - wallThickness + mountWallThickness,
        -boxDepth / 2 + lidMountDia / 2 + wallThickness - mountWallThickness,
        lidMountPosZ
    ],
    [
        boxWidth / 2 - lidMountDia / 2 - wallThickness + mountWallThickness,
        boxDepth / 2 - lidMountDia / 2 - wallThickness + mountWallThickness,
        lidMountPosZ
    ],
    [
        -boxWidth / 2 + lidMountDia / 2 + wallThickness - mountWallThickness,
        boxDepth / 2 - lidMountDia / 2 - wallThickness + mountWallThickness,
        lidMountPosZ
    ]
];

boxBottomPos =
    0 - mountPostHeight - mountPostTopHeight - wallThickness + wallThickness;

boxBottomCornersPos = [
    [ -boxWidth / 2 + 0.05, -boxDepth / 2 + 0.05, boxBottomPos ],
    [ boxWidth / 2 - 0.05, -boxDepth / 2 + 0.05, boxBottomPos ],
    [ boxWidth / 2 - 0.05, boxDepth / 2 - 0.05, boxBottomPos ],
    [ -boxWidth / 2 + 0.05, boxDepth / 2 - 0.05, boxBottomPos ]
];

cutOutDepthX = wallThickness + extraXPlus + raspClearance + 0.2;
cutOutDepthY = wallThickness + extraYMinus + raspClearance +
               (lidMountScrewDia + (lidMountDia - lidMountScrewDia) / 2) + 0.2;

LCDMountPos = [
    [ -75 / 2, -31 / 2, -8 + postHeightDisp / 2 + 1 ],
    [ 75 / 2, -31 / 2, -8 + postHeightDisp / 2 + 1 ],
    [ 75 / 2, 31 / 2, -8 + postHeightDisp / 2 + 1 ],    [ -75 / 2, 31 / 2, -8 + postHeightDisp / 2 + 1 ]];buttonsCount = len(buttonTexts);