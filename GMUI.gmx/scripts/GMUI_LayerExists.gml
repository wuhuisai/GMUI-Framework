#define GMUI_LayerExists
///GMUI_LayerExists(Layer Number)
/// Checks that the layer number given exists in GMUI

if (!is_real(argument0))
    return false;

var L;L = floor(argument0);

return (ds_list_find_index((GMUII()).GMUI_gridlist,L) != -1);


