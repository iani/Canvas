//火 13  5 2025 14:16
// Create a window for drawing in.
// The drawing function is provided as agrument.

Canvas {
	var <x = 10, <y = 10, <width = 800, <height = 800;
	var <centerx = 400, <centery = 400;
	var <window, <drawFunc;
	var <routine;
	var <>keepWindow = true;

	*new { | x = 10, y = 10, width = 800, height = 800 |
		^this.newCopyArgs(x, y, width, height).makeWindow;
	}

	makeWindow {
		// postln("Make window called. window is" + window;);
		window !? { window.close };
		window = Window().bounds = Rect(x, y, width, height);
		window.onClose = { this.windowClosed; };
		window.front;
	}

	windowClosed { window = nil; }

	draw { | func |
		window ?? {
			keepWindow.if {
				this.makeWindow
			}{
				routine.stop;
				routine = nil;
			}
		};
		window.drawFunc = {
			Pen.translate(centerx, centery);
			if (func isKindOf: Array) {
				func do: _.value;
			}{
				func.value;
			}
		};
		window.refresh;
	}

	animate { | routineFunc |
		CmdPeriod add: this;
		routine !? { routine.stop; };
		keepWindow = true;
		// postln("calling animate. Window is:" + window);
		window ?? {
			// "I WILL make a window".postln;
			this.makeWindow
		};
		routine = {
			routineFunc.(this);
		} fork: AppClock;
	}

	center_ { | x = 400, y = 400 |
		this.centerx = x;
		this.centery = y;
	}

	centerx_ { | argx |
		centerx = argx;
		window.refresh;
	}

	centery_ { | argy |
		centery = argy;
		window.refresh;
	}


	doOnCmdPeriod {
		routine = nil;
	}

	close {
		keepWindow = false;
		window !? { window.close };
		routine.stop;
	}
}