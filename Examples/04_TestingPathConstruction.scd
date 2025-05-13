// 火 13  5 2025 16:36
// Debugging construction of path.
// Do translate, rotate end previous path and start a new one?

//:
w = Window.new.front;
w.view.background_(Color.white);
c = 0;
w.drawFunc = {
	var n = 5, sideLength = 40;
	Pen.translate(100, 100);
	// Pen.moveTo(100, 100);
	Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
		n do: { | i |
			Pen.lineTo(sideLength@0);
			Pen.translate(sideLength, 0);
			Pen.rotate(pi / (n / 2));
			// Pen.stroke;
			// Pen.fill;
			Pen.stroke;
		};
};
//:
//
//   Pen.translate(220, 200);
	Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
	Pen.moveTo(0@0); // you have to set a starting point...
	Pen.lineTo(50@100);
	Pen.lineTo(100@100);
	Pen.rotate(0.2pi);
	Pen.lineTo(0@150);
	Pen.lineTo(-100@100);
	Pen.lineTo(-50@100);
	Pen.lineTo(0@0);
	Pen.fill;
	c = c + 0.1