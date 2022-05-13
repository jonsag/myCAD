// ArduinoUnoR3.scad

// include some NOP scad libraries by nophead, https://github.com/nophead/NopSCADlib
include <../../OpenSCADlibraries/NopSCADlib/utils/core/core.scad>
include <../../OpenSCADlibraries/NopSCADlib/vitamins/pcb.scad>
//include <../../OpenSCADlibraries/NopSCADlib/vitamins/screw.scad>
//include <../../OpenSCADlibraries/NopSCADlib/vitamins/screws.scad>

my_ArduinoUno3 = ["ArduinoUno3", "Arduino Uno R3", 68.58, 53.34, 1.6, 0, 3.3, 0, "#2140BE", false, [[15.24, 50.8],[66.04, 35.56],[66.04, 7.62],[13.97, 2.54]],
    [[30.226, -2.54, 0, "2p54socket", 10, 1],
     [54.61,  -2.54, 0, "2p54socket", 8, 1],
     [36.83,   2.54, 0, "2p54socket", 8, 1],
     [57.15,   2.54, 0, "2p54socket", 6, 1],
     [64.91,  27.89, 0, "2p54header", 2, 3],
     [18.796, -7.00, 0, "2p54header", 3, 2],
     [ 6.5,   -3.5,  0, "button_6mm"],
     [4.7625,  7.62, 180,"barrel_jack"],
     [1.5875, 37.78, 180,"usb_B"],
     [46.99,  17,    270,"pdip", 28, "ATMEGA328", true], // true for holder
    ],
    [],[],
    inch([
     [-1.35, -1.05],
     [-1.35,  1.05],
     [ 1.19,  1.05],
     [ 1.25,  0.99],
     [ 1.25,  0.54],
     [ 1.35,  0.44],
     [ 1.35, -0.85],
     [ 1.25, -0.95],
     [ 1.25, -1.05],
    ]),
    M2p5_pan_screw
   ];

pcb(my_ArduinoUno3);

//echo(M2p5_pan_screw);
