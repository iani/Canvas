// 火 13  5 2025 19:51
// Redoing path construction for polygons from start.
// NOTE: This can also become the start for building
// ==-------------  Formula from Poe ----------
/*
// Translated:
Given
	[x1, y1] the origin points,
	r the side length of the vector (the side of the polygon)
	th the angle of rotation (as we rotate for each edge)
	The x2, y2 new coordinates of the next point are:
[x2, y2] =[x1 + (r * cos(th)), y1 + (r * sin(th))]

*/
// The increment for calculating the angle r as we produce
// the edges successively would be:
~angle = { | n = 3 | n = n.clip(3, 100); ^2pi / n };
// So we would do:
~angles = { | n = 3 | (0..n-1) collect: { | t | 2pi / n * t }; };
//:
~angles.(5);
// [ 0.0, 1.2566370614359, 2.5132741228718, 3.7699111843078, 5.0265482457437 ]
//: Starting from an origin point [0, 0], calculate the end points
// of the vectors as they rotate around the cirle. These are the edges of the polygon
~edges =  { | n = 3, r = 10, x = 0, y = 0 | // r = radius ~ length
	var angles, points;
	n = n.clip(3, 100);
	angles = (0..n-1) collect: { | t | 2pi / n * t };
	points = angles collect: { | th |
		[x + (r * cos(th)), y + (r * sin(th))];
	};
	points;
};
//:
~edges.(4).round(0.01);
// [ [ 10.0, 0.0 ], [ 0.0, 10.0 ], [ -10.0, 0.0 ], [ 0.0, -10.0 ] ]
/* // a square rotated by 45% ("Diamond"), rotating clockwise.

0: right corner
1: bottom middle
2: left corner
3: upper middle

*/