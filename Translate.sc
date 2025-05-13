// 火 13  5 2025 15:01
// Translate Pen

Translate {
	var <>x = 0, <>y = 0;
	*new { | x = 0, y = 0 |
		^this.newCopyArgs(x, y)
	}

	value { Pen.translate(x, y) }
}