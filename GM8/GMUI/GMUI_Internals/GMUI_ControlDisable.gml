#define GMUI_ControlDisable
/// Disable or enable a control
// argument0 is the string of the key (control)
// argument1 is to disable (1) or enable (0)

with (GMUII()) {
    // Retrieve control from the reference map
    var control;
    control = ds_map_find_value(GMUI_map,string(argument0));
    if (string(control) == "0")
        return false;
    else {
        (control).Disabled = argument1;
        return true;
    }
}
