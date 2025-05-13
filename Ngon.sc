// 火 13  5 2025 14:36
// Draw a regular polygon using rotate.

Ngon {
	var <>n = 3, <>sideLength = 20;

	*new { | n = 3, sideLength = 20, drawMethod = \stroke |
		^this.newCopyArgs(n.clip(3, 100), sideLength.clip(2, 1000), drawMethod);
	}

	value {
		n do: { | i |
			Pen.lineTo(sideLength@0);
			Pen.translate(sideLength, 0);
			Pen.rotate(pi / (n / 2));
			Pen.stroke;
		};
		// Pen.stroke;
	}


	/* // wrong prototype
		value {
		n do: {
		Pen.lineTo(sideLength@0);
		Pen.stroke;
		Pen.rotate(pi / n);
		Pen.translate(sideLength, 0);
		}
		}
	*/
}