#define GMUI_MouseInAdjustedRegion
/// Checks to see if the mouse is in the adjusted region of the control (true/false)
// GMUI_MouseInAdjustedRegion(Control Object, mouse x, mouse y)

var _Control, _MX, _MY, _CW, _CH;
_Control = argument0;
_MX = argument1;
_MY = argument2;

// Check region of control if valid cotrol
if (!GMUI_IsControlID(_Control) && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_MouseInAdjustedRegion");
    return false;
}

// Get the proper width/height of the cell
if ((_Control).ActualW != 0)
    _CW = (_Control).ActualW;
else
    _CW = (_Control).CellWide * ((GMUII()).cellsize);

if ((_Control).ActualY != 0)
    _CH = (_Control).ActualH;
else
    _CH = (_Control).CellHigh * ((GMUII()).cellsize_h);
    
// Check if coordinates are inside the adjusted control based on what adjustments are set
if ((_MX >= (_Control).ActualX + (_Control).RelativeX && _MX <= (_Control).ActualX + (_Control).RelativeX + _CW) &&
    (_MY >= (_Control).ActualY + (_Control).RelativeY && _MY <= (_Control).ActualY + (_Control).RelativeY + _CH)
    )
    return true;
else
    return false;
