// https://github.com/jonsag/myCAD
// CADs/PipeMountDistance/PipeMountDistance.scad
// jonsagebrand@gmail.com

Distance = 35;

MinorWidth = 16;
MajorWidth = 20.5;

MinorHeight = 60;
MajorHeight = 65;

MiddleHeight = 23;

PadDiameter = 18;
PadHeight = 3;

ScrewDia = 3;

MountHoleDia = 5;

CounterSinkMajorDia = 11;
CounterSinkDepth = 5;

PipeDistance = 40;

ExtraCutOut = 10;

Roundness = 100;

// ---------- no editing below this line, if you don't know what you are doing ----------

SideCutOutWidth = (MajorWidth - MinorWidth) / 2;
SideCutOutHeight = MajorHeight / 2 - MiddleHeight / 2;

module distance() {
  difference() {

  // Body
    translate([0, 0, 0])
      cube([MajorWidth, MajorHeight, Distance]);

      // Side Cut Out 1
    color(c = "red")
      translate([-ExtraCutOut, -ExtraCutOut, -ExtraCutOut / 2])
        cube([SideCutOutWidth + ExtraCutOut, SideCutOutHeight + ExtraCutOut, Distance + ExtraCutOut]);

        // Side Cut Out 2
    color(c = "red")
      translate([-ExtraCutOut, MajorHeight - SideCutOutHeight, -ExtraCutOut / 2])
        cube([SideCutOutWidth + ExtraCutOut, SideCutOutHeight + ExtraCutOut, Distance + ExtraCutOut]);

        // Side Cut Out 3
    color(c = "red")
      translate([MajorWidth - (MajorWidth - MinorWidth) / 2, MajorHeight - SideCutOutHeight, -ExtraCutOut / 2])
        cube([SideCutOutWidth + ExtraCutOut, SideCutOutHeight + ExtraCutOut, Distance + ExtraCutOut]);

        // Side Cut Out 4
    color(c = "red")
      translate([MajorWidth - (MajorWidth - MinorWidth) / 2, -ExtraCutOut, -ExtraCutOut / 2])
        cube([SideCutOutWidth + ExtraCutOut, SideCutOutHeight + ExtraCutOut, Distance + ExtraCutOut]);

        // Pad
    color(c = "red")
      translate([MajorWidth / 2, MajorHeight / 2, -ExtraCutOut])
        cylinder(d = PadDiameter, h = PadHeight + ExtraCutOut);

        // Center Hole
    color(c = "green")
      translate([MajorWidth / 2, MajorHeight / 2, -ExtraCutOut / 2])
        cylinder(d = ScrewDia, h = Distance + ExtraCutOut, $fn = Roundness);

        // Mount Hole 1
    color(c = "orange")
      translate([MajorWidth / 2, MajorHeight / 2 + PipeDistance / 2, -ExtraCutOut / 2])
        cylinder(d = MountHoleDia, h = Distance + ExtraCutOut, $fn = Roundness);

    color(c = "blue")
      translate([MajorWidth / 2, MajorHeight / 2 + PipeDistance / 2, Distance - CounterSinkDepth])
        cylinder(h = CounterSinkDepth + 0.1, d2 = CounterSinkMajorDia, d1 = MountHoleDia, $fn = Roundness);

        // Mount Hole 2
    color(c = "orange")
      translate([MajorWidth / 2, MajorHeight / 2 - PipeDistance / 2, -ExtraCutOut / 2])
        cylinder(d = MountHoleDia, h = Distance + ExtraCutOut, $fn = Roundness);

    color(c = "blue")
      translate([MajorWidth / 2, MajorHeight / 2 - PipeDistance / 2, Distance - CounterSinkDepth])
        cylinder(h = CounterSinkDepth + 0.1, d2 = CounterSinkMajorDia, d1 = MountHoleDia, $fn = Roundness);
  }
}

//if ($preview)
distance();