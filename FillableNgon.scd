// 火 13  5 2025 16:58
// an Ngon contstructed with lineTo/translate/rotate
// cannot be filled with a color - because the path
// is not complete.  (Interruption of path may be a bug?)
// Constructing an algorithm that gives the complete path as
// absolute coordinates, to make the polygon fillable.
// From chat gpt:
/*

import math

def regular_polygon_vertices(n, side_length):
    if n < 3:
        raise ValueError("Polygon must have at least 3 sides.")

    angle = 2 * math.pi / n  # Central angle between vertices
    R = side_length / (2 * math.sin(math.pi / n))  # Radius of circumscribed circle

    # Center of polygon (to make first vertex at (0,0) and second at (s,0))
    angle_offset = math.pi / n
    cx = -R * math.cos(angle_offset)
    cy = -R * math.sin(angle_offset)

    vertices = []
    for i in range(n):
        theta = angle * i
        x = cx + R * math.cos(theta + angle_offset)
        y = cy + R * math.sin(theta + angle_offset)
        vertices.append((x, y))

    return vertices

*/
//: In supercollider:
~regular_polygon_vertices = { | n = 3, side_length = 10 |
	var angle, angle_offset, vertices, radius, cx, cy, x, y, theta;
	n = n.clip(3, 100); // constrain between 3 and 100 sides.

	angle = 2 * pi / n;
	radius = side_length / (2 * sin(pi / n));
	angle_offset = pi / n;
	cx = radius.neg * cos(angle_offset);
	cy = radius.neg * sin(angle_offset);

	n do: { | i |
		theta = angle * i;
		x = cx + radius * cos(theta + angle_offset);
		y = cy + radius * sin(theta + angle_offset);
		vertices = vertices add: [x, y]
	};
	vertices;
}
//:
~regular_polygon_vertices.(4, 10);
//:Corrected algorithm - version 2
~regular_polygon_vertices2 = { | n = 3, side_length = 10 |
	var angle, vertices, radius, cx, cy, x, y, theta;
	n = n.clip(3, 100); // constrain between 3 and 100 sides.

	angle = 2 * pi / n;
	radius = side_length / (2 * sin(pi / n));

	// Center the polygon so that first edge is from (0,0) to (side_length, 0)
	cx = radius - (side_length / 2);
	cy = 0;

	n.do { |i|
		theta = angle * i;
		x = cx + radius * cos(theta);
		y = cy + radius * sin(theta);
		vertices = vertices add: [x, y];
	};
	vertices;
};
//:
~regular_polygon_vertices.(4, 10);
//:
w = Window.new.front;
w.view.background_(Color.white);
c = 0;
w.drawFunc = {
	var n = 5, sideLength = 400, v;
	Pen.translate(150, 100);
	// Pen.moveTo(100, 100);
	v = ~regular_polygon_vertices.(3, sideLength);
	Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
		(v add: v[0]) do: { | xy |
			xy.postln;
			Pen.lineTo(xy[0]@xy[1]);
			Pen.stroke;
		};
};
//:
/*
[ 58.57864376269, 58.57864376269 ]
[ -58.57864376269, 58.578643762691 ]
[ -58.57864376269, -58.57864376269 ]
[ 58.57864376269, -58.578643762691 ]



*/
//:
~regular_polygon_vertices.(4, 100);
/*

[ [ 14.644660940673, 14.644660940673 ], [ -14.644660940673, 14.644660940673 ], [ -14.644660940673, -14.64
	4660940673 ], [ 14.644660940673, -14.644660940673 ] ]
No good eiher:

		var n = 5, sideLength = 400, v, v2;
	Pen.translate(150, 100);
	// Pen.moveTo(100, 100);
	v = ~regular_polygon_vertices.(4, sideLength);
	v2 = [v[1], v[0], v[3], v[2], v[1]];
*/


// ================================================



//: Second try (Poe instead of ChatGpt)
/* // source  code in python:
import math

def calculate_polygon_coordinates(n, l):
    # Calculate the radius of the circumscribed circle
    radius = l / (2 * math.sin(math.pi / n))

    # List to store the coordinates
    coordinates = []

    # Calculate the coordinates of each vertex
    for i in range(n):
        x = radius * math.cos(2 * math.pi * i / n)
        y = radius * math.sin(2 * math.pi * i / n)
        coordinates.append((x, y))

    return coordinates

# Example usage
n = 5  # Number of sides
l = 10  # Length of each side
polygon_coords = calculate_polygon_coordinates(n, l)

# Print the coordinates
for coord in polygon_coords:
    print(coord)
*/
//: Supercollider:
~ngon = { | n, l |
	var radius, coords;
	radius = l / (2 * sin(pi / n));
	(0..n) do: { | i |
		x = radius * cos(2 * pi * i / n);
		y = radius * sin(2 * pi * i / n);
		coords = coords add: [x, y];
	};
	coords;
 };
//: THIS WORKS
w = Window.new.front;
w.view.background_(Color.white);
w.drawFunc = {
	var n = 5, sideLength = 60, v;
	Pen.translate(150, 100);
	v = ~ngon.(4, sideLength);
	Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
	v pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};
	v.rotate pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};
	v.rotate(2) pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	}
};

//:
w = Window.new.front;
w.view.background_(Color.white);
w.drawFunc = {
	var n, sideLength = 60, v;
	Pen.translate(150, 100);
	v = ~ngon.(3, sideLength);
	Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
	v pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};
	v.rotate pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};
	v.rotate(2) pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	}
};
//:
w = Window.new.front;
w.view.background_(Color.white);
w.drawFunc = {
	var n, sideLength = 60, v;
	Pen.translate(150, 100);
	v = ~ngon.(5, sideLength);
	Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
	v pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};

	v.rotate pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};

	/*
	v.rotate(2) pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	}
	*/
};

//:
w = Window.new.front;
w.view.background_(Color.white);
w.drawFunc = {
	var n, sideLength = 40, v;
	Pen.translate(150, 120);
	v = ~ngon.(17, sideLength);
	Pen.fillColor = Color.hsv(c.fold(0, 1), 1, 1, 0.5);
	v pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};

	v.rotate pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	};
	/*
	v.rotate(2) pairsDo: { | xy1, xy2 |
		Pen.line(xy1[0]@xy1[1], xy2[0]@xy2[1]);
		Pen.stroke;
	}
	*/
};
//: Pen:beginPath and Pen:use ?

var w, run = true;
w = Window("my name is... panel", Rect(128, 64, 800, 500));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawFunc = {
    Pen.use {
        Pen.width = 2;
		Pen.beginPath;
		Pen.moveTo(Point(800.rand, 500.rand));
		Pen.lineTo(Point(800.rand, 500.rand));
		Pen.rotate(0.1);
		Pen.lineTo(Point(800.rand, 500.rand));
		Pen.fillStroke;
	};
};

//: Pen:beginPath and Pen:use ?

var w, run = true;
w = Window("my name is... panel", Rect(128, 64, 800, 500));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawFunc = {
    Pen.use {
        Pen.width = 2;
		Pen.beginPath;
		Pen.moveTo(Point(800.rand, 500.rand));
		Pen.lineTo(Point(800.rand, 500.rand));
		3 do: {
			Pen.rotate(0.1);
			Pen.lineTo(Point(800.rand, 500.rand));
		};
		Pen.fillStroke;
	};
};

//: Pen:beginPath and Pen:use ?

var w, run = true;
w = Window("my name is... panel", Rect(128, 64, 800, 500));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawFunc = {
    Pen.use {
		Pen.beginPath;
		Pen.moveTo(Point(800.rand, 500.rand));
		Pen.lineTo(Point(800.rand, 500.rand));
		3 do: {
			Pen.rotate(0.1);
			Pen.lineTo(Point(800.rand, 500.rand));
		};
		Pen.fillStroke;
	};
};

//: Pen:beginPath and Pen:use ?

var w, run = true;
w = Window("my name is... panel", Rect(128, 64, 800, 500));
w.view.background = Color.white;
w.onClose = { run = false; };
w.front;
w.drawFunc = {
    Pen.use {
		Pen.beginPath;
		Pen.moveTo(200@200);
		Pen.lineTo(Point(300, 200));
		6 do: {
			Pen.rotate(pi / 3);
			Pen.lineTo(Point(100, 100));
		};
		// Pen.lineTo(Point(300, 200));
		Pen.fillStroke;
	};
};

//: