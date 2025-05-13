// Simple ways to change the drawing in time

//: Create a canvas
c = Canvas();
//: Draw different polygons in a row
r = {
	loop {
		(3..15).palindrome do: { | i |
			c draw: Ngon(i);
			0.1.wait;
		};
	}
}.fork(AppClock);
//: As above, but change side length of polygon.
r = {
	loop {
		(3..15).palindrome do: { | i |
			c draw: Ngon(i, 40 - (i * 2));
			0.1.wait;
		};
	}
}.fork(AppClock);
//: Introduce rotation at the end of each polygon series
r = {
	inf do: { | j |
		(3..15).palindrome do: { | i |
			c draw: [Protate(j / 10, j * 5, j * 5), Ngon(i)];
			0.1.wait;
		};
		Protate(0.1)
	}
}.fork(AppClock);

//: stop the animation
r.stop;
//
