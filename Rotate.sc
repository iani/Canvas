// 火 13  5 2025 15:01
// Rotate Pen
// Note: We cannot use Rotate because it is taken by
// JoshUGen Ambisonics.sc

Protate {
	var <>angle = 0, <>x = 0, <>y = 0;
	*new { | angle = 0, x = 0, y = 0 |
		^this.newCopyArgs(angle, x, y)
	}

	value { Pen.rotate(angle, x, y) }
}