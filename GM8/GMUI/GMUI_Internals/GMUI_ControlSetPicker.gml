#define GMUI_ControlSetPicker
/// Set the picker values of the control (to override the defaults)
//GMUI_ControlSetPicker(picker width, picker height, picker direction, picker_right/up sprite, picker_left/down sprite)
if (!GMUI_IsControl() && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetPicker");
    return false;
}


    ControlPickerWidth = argument0;
    ControlPickerHeight = argument1;
    ControlPickerDirection = argument2;
    ControlPickerSpriteRightOrUp = argument3;
    ControlPickerSpriteLeftOrDown = argument4;
    

return true;
    

