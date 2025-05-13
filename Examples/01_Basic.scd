// Draw some basic shapes.

//: Create a canvas
c = Canvas();
//: Draw a hexagon
c draw: Ngon(6);

//: Draw a triangle
c draw: Ngon(3, 200);

//: Daw a square, a triangle, and a pentagon;
a = [Ngon(4, 100), Ngon(3, 200), Ngon(5, 100)];
c draw: a;

//: Draw square, triangle, pentagon, roating between drawing
a = [Ngon(4, 100), Protate(0.3), Ngon(3, 200), Protate(0.3), Ngon(5, 100)];
c draw: a;
