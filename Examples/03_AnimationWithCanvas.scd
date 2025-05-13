// 火 13  5 2025 15:44
// Using the animate method of canvas for animations
c = Canvas();
//: Draw polygons
c animate: { | canvas |
	loop {
		(3..15).palindrome do: { | i |
			c draw: Ngon(i);
			0.1.wait;
		};
	}
};
//: Draw filled polygons
c animate: { | canvas |
	loop {
		(3..15).palindrome do: { | i |
			c draw: Ngon(i, drawMethod: \fillStroke);
			0.1.wait;
		};
	}
};
//:Stop animation and close window:
c.close;
//:Different example. Rotating slowly
c animate: { | canvas |
	inf do: { | j |
		(3..15).palindrome do: { | i |
			canvas draw: [Protate(j / 10, j * 5, j * 5), Ngon(i)];
			0.1.wait;
		};
		Protate(0.1)
	}
};
//: As above, with different pen color, for distinction
c animate: { | canvas |
	inf do: { | j |
		(3..15).palindrome do: { | i |
			canvas draw: [
				{
					Pen.strokeColor = Color.red;
					Pen.fillColor = Color.blue;
				},
				Protate(j / 10, j * 5, j * 5),
				Ngon(i),
			];
			0.1.wait;
		};
		Protate(0.1)
	}
};