#!/usr/bin/env wish
# Test script of a Tcl/Tk GUI to throw data into an Octave 3D Plot

package require Tk

# GUI Layout stuff
grid [ttk::frame .f -padding "10 10 10 10"] -column 0 -row 0 -sticky nwes
grid columnconfigure . 0 -weight 1
grid rowconfigure . 0 -weight 1

set row 0

# X Range stuff
grid [ttk::label .f.xl -text "X Range:"] -column 0 -row $row -sticky w
grid [ttk::entry .f.xstart -width 7] -column 1 -row $row
grid [ttk::label .f.xdash -text "to"] -column 2 -row $row
grid [ttk::entry .f.xend -width 7] -column 3 -row $row
grid [ttk::label .f.xstep_l -text "Step:"] -column 4 -row $row
grid [ttk::entry .f.xstep -width 5] -column 5 -row $row

incr row

# Y Range stuff
grid [ttk::label .f.yl -text "Y Range:"] -column 0 -row $row -sticky w
grid [ttk::entry .f.ystart -width 7] -column 1 -row $row
grid [ttk::label .f.ydash -text "to"] -column 2 -row $row
grid [ttk::entry .f.yend -width 7] -column 3 -row $row
grid [ttk::label .f.ystep_l -text "Step:"] -column 4 -row $row
grid [ttk::entry .f.ystep -width 5] -column 5 -row $row

incr row

# Z Expression shit
grid [ttk::label .f.zl -text "Z Expression (use X, Y):"] -column 0 -row $row -sticky w
grid [ttk::entry .f.zexpr -width 30] -column 1 -row $row -columnspan 5 -sticky we

incr row

# Plot Button :)
grid [ttk::button .f.plot -text "Plot" -command plot] -column 0 -row $row -columnspan 6 -sticky w

# Default placeholder values
.f.xstart insert 0 "-3"
.f.xend insert 0 "3"
.f.xstep insert 0 "0.1"
.f.ystart insert 0 "-3"
.f.yend insert 0 "3"
.f.ystep insert 0 "0.1"
.f.zexpr insert 0 "peaks(X, Y)"

# Plot Procedure
proc plot {} {
    # 1. Get values
    set x_start [.f.xstart get]
    set x_end [.f.xend get]
    set x_step [.f.xstep get]
    set y_start [.f.ystart get]
    set y_end [.f.yend get]
    set y_step [.f.ystep get]
    set z_expr [.f.zexpr get]

    # 2. Validate inputs
    if {![string is double -strict $x_start] || ![string is double -strict $x_end] || ![string is double -strict $x_step] ||
        ![string is double -strict $y_start] || ![string is double -strict $y_end] || ![string is double -strict $y_step]} {
        tk_messageBox -icon error -message "Invalid input! All values must be numbers."
        return
    }

    # 3. Build Octave command
    set octave_script [file normalize "plot_3d_gui.m"]
    set cmd [list octave --persist $octave_script $x_start $x_end $x_step $y_start $y_end $y_step $z_expr]

    # 4. Execute
    try {
        exec {*}$cmd >@stdout 2>@stderr
    } on error {err} {
        tk_messageBox -icon error -message "Error: $err"
    }
    
    # 5. ???
    
	# 6. Profit :^)
}
