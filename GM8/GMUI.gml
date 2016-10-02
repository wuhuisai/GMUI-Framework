#define GMUI_Form
/// Playbook to create all of the UI component objects for the project
//
// PLEASE READ THE MANUAL ONLINE FOR INSTRUCTIONS ON HOW TO USE GMUI!
//
// Called by GMUI_Create. Argument can be used optionally to have different
// forms for different GMUI instances to use:
var OptionalInterfaceName; OptionalInterfaceName = argument0;

//
//
// Syntax: GMUI_Add("Name", "Type String", 
//                  cell# x, cell# y, cells wide (min 1), cells high (min 1), 
//                  Layer**, Anchor***)


// Cell#'s start at 0 and increment by 1 for each size of cell over the x & y axis
// ** Layer can be used to show pop-up or slide windows and disable lower layers temporarily (0 is default)
// *** See GMUI_Init for Anchor codes. E.g.: AnchorBottomRight will be determined by cells away from room width/height (0=default)

// Types: textint, textdecimal, textstring, button , slider , dropdown , custom*
// * To use custom, type the object name you would like to use as a reference to the GMUI cell
// Note: MUST BE VALID TYPE NAME. If not, it will default to an 'X'

// Assign names to the controls to reference in your code
// e.g. SizeSlider = GMUI_Add("SizeSlider",...), then use: GMUI_GetValue("SizeSlider");

// Custom controls should call Create: GMUI_ControlInit, Draw: GMUI_ControlDraw

//GMUI_Add("New1" , GMUI_custom , 0 , 0 , 1 , 1 , 0 , 0 , 1 , 0 , AnchorTopLeft );
// gmuiaddlabel ()

//Group can be used move, disable, or hide a set of controls from within the same layer
//...



// If using multiple grids, you can switch between interfaces (optional):
switch (OptionalInterfaceName) {
    case "MyGrid":
    default: // < Remove default, & match name to GMUI_Create(name,,)

    
    // DEMO INTERFACE:
    var layer;
        // Create a control group if you would like: (layer number, group number (> 0), CellX, CellY, CellWide, CellHigh, anchor)
        
        layer = 0;
        // Right side group
        GMUI_CreateGroup(1,     20,3,   layer, global.GMUIAnchorTopRight);
        GMUI_GroupSetSize(1,    18,4,   layer);
        // Left side group
        GMUI_CreateGroup(2,     2,3,    layer, global.GMUIAnchorTopLeft);
        
        with (GMUI_Add("Test1","textstring",            1,0,    16,2,   layer, global.GMUIAnchorTopLeft)) {
            GMUI_ControlSetAttributes(20,0,0,0);
            GMUI_ControlSetInitValue("Select");
            GMUI_ControlAddToGroup(1);
        }
        
        with (GMUI_Add("Test2", "textint",              0,0,    10,2,   layer, global.GMUIAnchorTopLeft)) {
            GMUI_ControlSetAttributes(5,0,-1000,1000);
            GMUI_ControlSetStyle(hsv(120,120,120),rgb(20,20,20),-1,-1,-1,-1,-1,-1,-1,-1);
            GMUI_ControlAddToGroup(2);
        }
        
        with (GMUI_Add("Test3", "textdecimal",          0,3,    10,2,   layer, global.GMUIAnchorTopLeft)) {
            GMUI_ControlSetAttributes(10,10,-999,999);
            GMUI_ControlAddToGroup(2);
        }
        
        with (GMUI_Add("Test4", "intpicker",            0,6,   10,2,   layer, global.GMUIAnchorTopLeft)) {
            GMUI_ControlSetAttributes(0,0,-20,20);
            GMUI_ControlAddToGroup(2);
        }
        
        with (GMUI_Add("TestButton", "textbutton",      3,9,   5,3,    layer, global.GMUIAnchorTopLeft)) {
            GMUI_ControlSetButton("Test!", -1, -1, -1, -1);
            GMUI_ControlSetStyle(-1, -1, c_red, 1, 0.85, -1, -1, -1, -1, -1);
            GMUI_ControlAddToGroup(2);
        }
        
        with (GMUI_Add("DebugButton", "textbutton",     1,3,    5,3,    layer, global.GMUIAnchorBottomLeft)) {
            GMUI_ControlSetButton("Debug", -1, -1, -1, -1);
            GMUI_ControlSetStyle(-1, -1, c_gray, 1, 0.85, -1, -1, -1, -1, -1);
        }
        
        with (GMUI_Add("DisableButton", "textbutton",      8,3,    5,3,    layer, global.GMUIAnchorBottomLeft)) {
            GMUI_ControlSetButton("Disable"+chr(13)+"Test",-1,-1,-1,-1);
        }
        
        with (GMUI_Add("HideButton", "textbutton",      15,3,    5,3,    layer, global.GMUIAnchorBottomLeft)) {
            GMUI_ControlSetButton("Hide"+chr(13)+"Group",-1,-1,-1,-1);
        }
        
        with (GMUI_Add("MoveButton", "textbutton",      22,3,    6,3,    layer, global.GMUIAnchorBottomLeft)) {
            GMUI_ControlSetButton("Bump"+chr(13)+"Group",-1,-1,-1,-1);
        }
        
        with (GMUI_Add("ExitButton", "textbutton",      0,0,    1,1,     layer, global.GMUIAnchorTopRight)) {
            GMUI_ControlSetButton("x", -1, -1, -1, -1);
            // (Example:) Minor adjustment so that the control isnt cut off
            GMUI_ControlSetPositioning(-1,0,0,0);
        }
        
    break;
}

#define GMUI_Actions
/// Specify the actions performed when a control is clicked, if it has an action ability
// GMUI_Actions("control name")
// Controls with actions: button, textbutton, 

switch (argument0)
{
    case "ControlName1":
        // Put actions here
    
    break;
    
    case "DebugButton":
        // Show/hide debug for the first interface
        if ((GMUIid(1)).DebugData)
            (GMUIid(1)).DebugData = false;
        else
            (GMUIid(1)).DebugData = true;
    
    break;
    
    case "TestButton":
        // Get all the values and display them:
        var t1,t2,t3,t4;
        t1 = GMUI_GetValueString("Test1");
        t2 = GMUI_GetValueString("Test2");
        t3 = GMUI_GetValueString("Test3");
        t4 = GMUI_GetValueString("Test4");
        show_message("Result:
        " + t1 + "
        " + t2 + "
        " + t3 + "
        " + t4);
    break;
    
    case "DisableButton":
        GMUI_ControlDisable("TestButton",1-GMUI_ControlIsDisabled("TestButton"));
    break;
    
    case "HideButton":
        GMUI_GroupHide(2, 0, 1-GMUI_ControlIsHidden("TestButton"));
    break;
    
    case "MoveButton":
        var MyButton,MyButtonText;
        MyButton = GMUI_GetControl("MoveButton");
        
        if (MyButton >= 0)
            MyButtonText = MyButton.ControlButtonText;
            
        if (MyButtonText == "Bump"+chr(13)+"Group") {
            with (MyButton) GMUI_ControlSetButton("Return"+chr(13)+"Group",-1,-1,-1,-1);
            GMUI_GroupSetPosition(0,1,20,8,0,0);
        }
        else {
            with (MyButton) GMUI_ControlSetButton("Bump"+chr(13)+"Group",-1,-1,-1,-1);
            GMUI_GroupSetPosition(0,1,20,3,0,0);
        }
    break;
    
    
    case "ExitButton":
        game_end();
    break;
}

#define GMUI_Settings
/// Settings for GMUI - Do not delete! Modify to fit your preferences
// Called from the initialization of each GMUI interface


// Define the controls' object!
GMUI_controlobject = GMUI_control;


// Flexibility to add graphical effects settings to the controls:
var basic, good, best; basic = 0; good = 1; best = 2;
graphicsSetting = best;

// Initial depth (z-index) value. Other objects will have depths relative to this
depth = -9999;

// Other specific functionality settings that can be turned off if unwanted
GMUIRemoveExtraDecimalZeros = true;     // Trim extra zeroes in decimal-type controls
GMUIAllowDoubleSelect = true;           // If double selected, the control will overwrite the contents
GMUIEnableTabbing = true;               // Tab key will advance to the next control
GMUIEnableEnterKey = true;              // Enter key will deselect the control

// Enable setting debug data for testing
DebugData = false;




// Argument can be used optionally for different GMUI instances
var OptionalInterfaceName; OptionalInterfaceName = argument0;
if (OptionalInterfaceName == "") {
    // Do Something
}




#define GMUI_SetLayerDepths
/// Creates a set of layers with their relative depth values from the GMUI default
// This is called by the Create script
// GMUI_SetLayerDepths()

layerDepth = depth;

// Each of the control layers are relative to this value, lowest layer on the bottom:
layerDepth_layers = layerDepth-1;

// If you really need more than 100 layers, you can change this (each layer may have tooltips or other objects):
layerDepth_messages = layerDepth_layers - (100*3);

// Windows are above all layers and basic messages (MAY GET RID OF THIS ONE)
//layerDepth_windows = layerDepth_messages - 10;

// Menus show over basic messages and windows
layerDepth_menus = layerDepth_messages - 100;

// Pop-ups show over menus, windows, and messages (each menu may have tooltips or other objects)
layerDepth_popups = layerDepth_menus - (100*3) - 1;

// Warnings are for anything from menus to popups
layerDepth_warnings = layerDepth_popups - 100;


#define GMUI_SetControlDefaults
/// Sets the default values for all controls if they are not specified in GMUI_Form

// ! NOTE ! These values must pass validation or else errors will occur!

// Set the default control styling (Background Color, Border color, Hover color, hover border/rect, hover alpha,
// overwrite color, overwrite alpha, select color, select alpha, 
// showcursor)
GMUI_ControlSetStyle(
    rgb(250,250,255),hsv(135,30,100),rgb(20,160,230),true,0.5,
    rgb(40,40,40),0.1,rgb(240,140,40),0.3,
    true
    );

// Default font style (font, font color, font align)
GMUI_ControlSetFontStyle(fontNumeric,rgb(42,42,42), fa_left);

// Set the default control attributes(id, Max string length/Whole number padding(KEEP @ 0!), max decimal (if applicable), Min value, Max value)
GMUI_ControlSetAttributes(0,0,0,999);



// Specific control initializations //

// Picker controls ( region width, region height, 
// direction type (see below), right/up sprite, left/down sprite )
GMUI_ControlSetPicker(
    sprite_get_width(GMUIspr_arrow) + 4,sprite_get_height(GMUIspr_arrow) + 4,
    global.GMUIDirectionTypeSideVertical,GMUIspr_arrowup,GMUIspr_arrow
    );
// Direction types: global.GMUIDirectionTypeHorizontal: 0, global.GMUIDirectionTypeVertical: 1, global.GMUIDirectionTypeSideVertical: 2


// Text Button control (Text or "", graphic in button or -1, button image sprite or -1, text alignment, hover color or -1)
GMUI_ControlSetButton("Button", -1, -1, -1, -1);
    

#define GMUI_DrawDebug
// DEBUGGING SCRIPT! Call this in the draw event of the GMUI main object 
// Run only if DebugData is on
if (DebugData) {

    var gridW,gridH,w,h;
    gridW = ds_grid_width((GMUII()).GMUI_grid[0]);
    gridH = ds_grid_height((GMUII()).GMUI_grid[0]);
    
    // draw the grid lines 
    color_alpha(c_black,0.1);
    for (w=0;w<gridW;w+=1) {
        draw_line(w*cellsize,0,w*cellsize,room_height);
    }
    for (h=0;h<gridH;h+=1) {
        draw_line(0,h*cellsize_h,room_width,h*cellsize_h);
    }
    
    // draw the errors
    if (GMUI_ErrorNumber > 0) {
        color_alpha(c_red,0.5);
        align(fa_center,fa_bottom);
        draw_text(room_width/2,room_height-64,string(GMUI_ErrorNumber) + ".) " + GMUI_LastError());
    }
    
    
    // draw the group boundaries
    color_alpha(c_green,0.5);
    var groupId, layer;
    for(i=0;i<ds_list_size((GMUII()).GMUI_gridlist);i+=1) {
        layer = ds_list_find_value((GMUII()).GMUI_gridlist,i);
        
        for(j=0;j<ds_list_size((GMUII()).GMUI_groupList[layer]);j+=1) {
            groupId = ds_list_find_value((GMUII()).GMUI_groupList[layer],j);
            
            draw_rectangle(GMUI_groupActualX[layer,groupId],GMUI_groupActualY[layer,groupId],
                GMUI_groupActualX[layer,groupId] + GMUI_groupCellsW[layer,groupId]*cellsize,
                GMUI_groupActualY[layer,groupId] + GMUI_groupCellsH[layer,groupId]*cellsize_h,
                true);
        }
    }


}

#define GMUI_Init
/// Call this initialization script before creating any GMUI interfaces
//
// !WARNING! MODIFYING THE GMUI SCRIPTS CAN BREAK FUNCTIONALITY AND CAUSE ERRORS! TRY TO EDIT THE OBJECTS INSTEAD!
//
// Copyright 2016 Alert Studios (Mark Palnau). Initially designed by Alert Studios and released as Open-Source.
//
// If you would like to help make GMUI better, please submit a ticket or pull request on the project on GitHub!
//
//
//


// Index of global GMUI's
global.GMUIii = 0;


// Common GMUI values:

// AHOY MATEYS - Please note that the cell#'s for new controls are relative to their anchor position (0 is default: TopLeft)
global.GMUIAnchorRight = 1;
global.GMUIAnchorTopRight = 2;
global.GMUIAnchorTop = 3;
global.GMUIAnchorTopLeft = 4;
global.GMUIAnchorLeft = 5;
global.GMUIAnchorBottomLeft = 6;
global.GMUIAnchorBottom = 7;
global.GMUIAnchorBottomRight = 8;

// Hovering directions for special controls
global.GMUIHoveringDirection_None = 0;
global.GMUIHoveringDirection_Right = 1;
global.GMUIHoveringDirection_Up = 2;
global.GMUIHoveringDirection_Left = 3;
global.GMUIHoveringDirection_Down = 4;

// Direction types
global.GMUIDirectionTypeHorizontal = 0;
global.GMUIDirectionTypeVertical = 1;
global.GMUIDirectionTypeSideVertical = 2;

#define GMUI_Create
/// Call creation of the grid interfaces and variables

// Create resizable method for window?


// // Create grid variables
    // Is this already using a GMUI? Assign the instance number as long as its not
    var isOk,G;
    isOk = 1;
    for (G=1;G<=global.GMUIii;G+=1) {
        if (id = global.GMUIiid[G]) {
            isOk = 0;
            break;
        }
    }
        
    if (!isOk)
        return 0;
    else {
        // New ID
        global.GMUIii += 1;
    }

    // Define the instance & number running GMUI
    global.GMUIiid[global.GMUIii] = id;
    GMUInumber = global.GMUIii;
    // Current grid is now this one
    global.GMUIiid = id;
    
    
    // Initial time to not execute any actions from the grid
    InitalDisable = floor(room_speed/20); // Default 1/20th of a second
    // Layer that is currently enabled (0 is the bottom-most)
    UILayer = 0;
    // Highest layer, for reference
    UILayerTop = 0;
    
    // Other specific functionality settings that can be turned off if unwanted
    GMUI_Settings(argument0);
    
    // Set the default layering depths
    GMUI_SetLayerDepths();
    
    // Previous values of the mouse to determine if it has moved or not
    mouse_px = 0;
    mouse_py = 0;
    previousHoveringControl = -1;
    
    // Debug information
    if (DebugData) {
        TestInRegion = -1;
        TestOnDirection = -1;
        TestHoverObject = -1;
    }

    
// Get cellsize arguments (w,h)
if (argument1 < 1)
    cellsize = 16;
else
    cellsize = argument1;
if (argument2 < 1)
    cellsize_h = cellsize;
else
    cellsize_h = argument2;
    
// Rather pointless to be redundant but it gives more flexibility if you really need it...
persistence = persistent;


// Grid setup (New layers will have their own grids)
GMUI_grid[0] = ds_grid_create(ceil(room_width/cellsize),ceil(room_height/cellsize_h));
GMUI_grid_x[0] = 0;
GMUI_grid_y[0] = 0;

GMUI_gridlist = ds_list_create();
ds_list_add(GMUI_gridlist,0);

// Error management (DEBUG)
GMUI_Error[0] = "";
GMUI_ErrorNumber = 0;

// Initial Disable steps for the Grid checks
InitialDisable = 5;


// Map setup for control name keys to instances
GMUI_map = ds_map_create();

// List of all controls
GMUI_controlList = ds_list_create();

// Create all of the default control settings
GMUI_SetControlDefaults();

// Currently hovering or selecting on control for controls to revert if not them
HoveringControl = -1;
SelectedControl = -1;
PreviousSelectedControl = -1;


// Grouping variables
// List of groups per layer [layer number; default 0]
GMUI_groupList[0] = ds_list_create();
// List of controls per group [layer number, group number]
GMUI_groupControlList = ds_list_create();
//Positioning
GMUI_groupCellX[0,0] = 0;
GMUI_groupCellY[0,0] = 0;
GMUI_groupActualX[0,0] = 0;
GMUI_groupActualY[0,0] = 0;
GMUI_groupRelativeX[0,0] = 0;
GMUI_groupRelativeY[0,0] = 0;
GMUI_groupCellsW[0,0] = 0;
GMUI_groupCellsH[0,0] = 0;
GMUI_groupRelativeCellX[0,0] = 0;
GMUI_groupRelativeCellY[0,0] = 0;
GMUI_groupAnchor[0,0] = global.GMUIAnchorTopLeft;

// Call the form code to create the interface
GMUI_Form(argument0);
GMUI_GridSetRegions();

// Upon success, give the GMUI id back
return GMUInumber;


#define GMUI_Add
/// Adds a component(instance) to the GMUI grid 
// GMUI_Add("Name", "Type String", cell# x, cell# y, cells wide (min 1), cells high (min 1), 
//                  Layer**, Anchor***)

var _Layer,_Anchor,_CellX,_CellY;
_Layer = argument6;
_Anchor = argument7;
_CellX = argument2;
_CellY = argument3;

// Check that the layer exists first
if (!GMUI_LayerExists(_Layer)) {
    GMUI_ThrowError("The layer does not exist. GMUI_Add('" + string(argument0) + "',...");
    return -1;
}


// Check grid positioning first and assign after created
var gridW, gridH;
// Get the dimensions and round down for grids that have even grid sizes
gridW = ds_grid_width((GMUII()).GMUI_grid[_Layer]);
gridH = ds_grid_height((GMUII()).GMUI_grid[_Layer]);

if (!GMUI_ValidCellBounds(_Anchor,_CellX,_CellY,gridW,gridH)) {
    GMUI_ThrowError("Cell values out of bounds. GMUI_Add('" + string(argument0) + "'," + string(argument1) + "," + string(_CellX) + "...");
    return -1;
}


// Check that it hasn't already been created
if (ds_map_exists((GMUII()).GMUI_map,argument0)) {
    GMUI_ThrowError("The control name has already been defined. GMUI_Add('" + string(argument0) + "',...");
    return -1;
}


// Check for type and either reference provided instance or create a new one. MUST BE A VALID TYPE
var thetype,thecontrol,isinput,isbutton;isinput=0;isbutton=0;
if (is_string(argument1)) {
    thetype = string_lower(string_replace(argument1," ",""));
    switch (thetype) {
        case "textint":
        case "textdecimal":
        case "textstring":
        case "intpicker":
        case "doublepicker":
            isinput = 1; // Input fields = 1;
            break;
        case "button":
        case "textbutton":
            isbutton=1;
        case "slider":
        case "dropdown":
            // valid
        break;
        default:
            // invalid
            thetype = "invalid";
        break;
    }
    
    thecontrol = instance_create(0,0,(GMUII()).GMUI_controlobject); // Default is: GMUI_control
}
else {
    thecontrol = instance_create(0,0,argument1);
}

// Well... this problem should never happen.. in theory
if (!instance_exists(thecontrol))
    return -1;
else
    GMUI_ControlInit(thecontrol);

// Add control to control list for reference
ds_list_add((GMUII()).GMUI_controlList,thecontrol);

// Set up control vars
thecontrol.valueName = argument0;
thecontrol.ControlType = thetype;
thecontrol.ControlInput = isinput;
thecontrol.CellWide = argument4;
thecontrol.CellHigh = argument5;
thecontrol.Layer = _Layer;
thecontrol.Group = 0;
thecontrol.depth = (GMUII()).layerDepth_layers-(_Layer*3);
thecontrol.persistent = persistence; // This is kind of unnecessary but could be used at some point?

// Store the relative values provided that reference against the anchor position
thecontrol.Anchor = _Anchor;
thecontrol.RelativeCellX = _CellX;
thecontrol.RelativeCellY = _CellY;

// Specific setup for particular types
if (thetype == "textstring") {
    thecontrol.value = "";
    thecontrol.valueString = "";
}

// Relative is to the anchor, this position is the actual:
// The relative values when the grid is adjusted has four relative positions: Middle X's, Middle Y's, Right X's, Bottom Y's)
thecontrol.CellX = GMUI_GetAnchoredCellX(gridW,_CellX,_Anchor);
thecontrol.CellY = GMUI_GetAnchoredCellY(gridH,_CellY,_Anchor);


// Actual position based on its grid position
thecontrol.ActualX = GMUI_CellGetActualX(thecontrol.CellX);
thecontrol.ActualY = GMUI_CellGetActualY(thecontrol.CellY);

// Map the name to the instance
ds_map_add((GMUII()).GMUI_map,argument0,thecontrol);



// Set the default style properties (set from the gmui controller)
GMUI_ControlSetDefaultStyle(thecontrol);

// Set the default font style properties (set from the gmui controller)
GMUI_ControlSetDefaultFontStyle(thecontrol);

// Set the default attribute properies (set from the gmui controller)
GMUI_ControlSetDefaultAttributes(thecontrol);

// Set the default picker properties (set from the gmui controller)
GMUI_ControlSetDefaultPicker(thecontrol);

// Set the default button properties (set from the gmui controller)
GMUI_ControlSetDefaultButton(thecontrol);

// Override defaults for specific controls (Avoid defaults conflicts)
if (isbutton) {
    thecontrol.ControlFontAlign = fa_center;
    thecontrol.ControlShowCursor = false;
}


return thecontrol;




#define GMUI_Add_relativetest
// The relative values when the grid is adjusted has four relative positions: Middle X's, Middle Y's, Right X's, Bottom Y's)
if (argument10 != global.GMUIAnchorTopLeft)
{
    var gridW, gridH, gridW2, gridH2;
    // Get the dimensions and round up/down depending on which side the control is on (solves even grid sizes with no real middle cell)
    gridW = ds_grid_width((GMUII()).GMUI_grid[argument8]);
    gridH = ds_grid_height((GMUII()).GMUI_grid[argument8]);
    if (argument2 < gridW / 2 + 0.5)
        gridW2 = ceil(gridW / 2 + 0.5);
    else
        gridW2 = floor(gridW / 2);
    if (argument3 < gridH / 2 + 0.5)
        gridH2 = ceil(gridH / 2 + 0.5);
    else
        gridH2 = floor(gridH / 2 + 0.5);
    // The Mid X's, else the Right X's
    if (argument10 == global.GMUIAnchorTop || argument10 == global.GMUIAnchorBottom)
        thecontrol.RelativeCellX = argument2 - gridW2;
    else if (argument10 == global.GMUIAnchorTopRight || argument10 == global.GMUIAnchorRight || argument10 == global.GMUIAnchorBottomRight)
        thecontrol.RelativeCellX = argument2 - gridW;
    // The Mid Y's else the Bottom Y's
    if (argument10 == global.GMUIAnchorLeft || argument10 == global.GMUIAnchorRight)
        thecontrol.RelativeCellY = argument3 - gridH2;
    else if (argument10 == global.GMUIAnchorBottomLeft || argument10 == global.GMUIAnchorBottom || argument10 == global.GMUIAnchorBottomRight)
        thecontrol.RelativeCellY = argument3 - gridH;
}

#define GMUI_AddLabel
/// Add a label fixed to a control....
// or have the label take a cell block
// a text button should be used if you want it clickable

#define GMUI_AddLayer
/// Adds a new grid layer to GMUI for controls to exist on
// GMUI_AddLayer(Layer Number,x offset, y offset)
// returns false on failure (bad params)

var _Layer;
_Layer = floor(argument0);

if (!is_real(argument1))
    return false;
if (!is_real(argument2))
    return false;
    
if (GMUI_LayerExists(_Layer))
    return false;

// If the layer doesn't exist, add it to the list and create it
ds_list_add((GMUII()).GMUI_gridlist,floor(_Layer));

// Add a group list to the layer in case its used
(GMUII()).GMUI_groupList[_Layer] = ds_list_create();

// Assign
(GMUII()).GMUI_grid[_Layer] = ds_grid_create(ceil(room_width/(GMUII()).cellsize),ceil(room_height/(GMUII()).cellsize_h));
(GMUII()).GMUI_grid_x[_Layer] = argument1;
(GMUII()).GMUI_grid_y[_Layer] = argument2;

if ((GMUII()).UILayerTop < _Layer)
    (GMUII()).UILayerTop = _Layer;

return true;

#define GMUI_LayerExists
/// Checks that the layer number given exists in GMUI
// GMUI_LayerExists(Layer Number)

if (!is_real(argument0))
    return false;

var L;L = floor(argument0);

return (ds_list_find_index((GMUII()).GMUI_gridlist,L) != -1);


#define GMUI_SwitchLayer
/// Switches the layer to the top-most visible layer

//

// Disable hovering and selection on all controls

#define GMUI_CreateGroup
/// Adds a group to a GMUI layer that controls can be put into
// GMUI_CreateGroup (layer number, group number, cell# x, cell# y, cells wide, cells high, Anchor)


// Arguments
var _groupNumber,_CellX,_CellY,_layerNumber,_Anchor;
_groupNumber = argument0;
_CellX = argument1;
_CellY = argument2;
_layerNumber = argument3;
_Anchor = argument4;


// Validate
if (!is_real(_groupNumber) || !is_real(_layerNumber) || !is_real(_CellX) || !is_real(_CellY)) {
    GMUI_ThrowError("Invalid parameters for GMUI_CreateGroup");
    return false;
}

if (_groupNumber <= 0) {
    GMUI_ThrowError("Group number must be greater than 0");
    return false;
}

if (!GMUI_LayerExists(_layerNumber)) {
    GMUI_ThrowError("Layer " + string(_layerNumber) + " doesn't exist. GMUI_CreateGroup");
    return false;
}

// Create group; add to GMUI group list and create a control list
ds_list_add((GMUII()).GMUI_groupList[_layerNumber],_groupNumber);

with (GMUII()) {
    GMUI_groupControlList[_layerNumber,_groupNumber] = ds_list_create();

    // Set defaults
    GMUI_groupRelativeX[_layerNumber,_groupNumber] = 0;
    GMUI_groupRelativeY[_layerNumber,_groupNumber] = 0;
    
    // Set position
    GMUI_groupCellX[_layerNumber,_groupNumber] = GMUI_GetAnchoredCellX(ds_grid_width((GMUII()).GMUI_grid[_layerNumber]),_CellX,_Anchor);
    GMUI_groupCellY[_layerNumber,_groupNumber] = GMUI_GetAnchoredCellY(ds_grid_height((GMUII()).GMUI_grid[_layerNumber]),_CellY,_Anchor);
    GMUI_groupActualX[_layerNumber,_groupNumber] = GMUI_CellGetActualX(GMUI_groupCellX[_layerNumber,_groupNumber]);
    GMUI_groupActualY[_layerNumber,_groupNumber] = GMUI_CellGetActualY(GMUI_groupCellY[_layerNumber,_groupNumber]);
    GMUI_groupCellsW[_layerNumber,_groupNumber] = 1;
    GMUI_groupCellsH[_layerNumber,_groupNumber] = 1;
    GMUI_groupRelativeCellX[_layerNumber,_groupNumber] = _CellX;
    GMUI_groupRelativeCellY[_layerNumber,_groupNumber] = _CellY;
    GMUI_groupAnchor[_layerNumber,_groupNumber] = _Anchor;
}



return true;

#define GMUI_ControlAddToGroup
/// Adds control to a group if it exists in the layer
// GMUI_ControlAddToGroup(group number)

var _Group, _Layer;
_Group = argument0;
// Layer value exists in the control
_Layer = Layer;

// Must be control
if (!GMUI_IsControl()) {
    GMUI_ThrowError("Invalid control for GMUI_ControlAddToGroup");
    return false;
}

// Validate
if (!is_real(_Group)) {
    GMUI_ThrowError("Invalid group for GMUI_ControlAddToGroup");
    return false;
}
if (_Group <= 0) {
    GMUI_ThrowError("Invalid group for GMUI_ControlAddToGroup");
    return false;
}
    
// Control must have a layer that exists (should always be the case)
if (!GMUI_LayerExists(_Layer)) {
    GMUI_ThrowError("Control in layer that doesn't exist: " + string(id) + ". GMUI_ControlAddToGroup");
    return false;
}
    

// Add control to group's control list and assign to control
ds_list_add((GMUII()).GMUI_groupControlList[_Layer,_Group],id);
Group = _Group;


// Reset positioning to base on group's position
CellX = GMUI_GetAnchoredCellX((GMUII()).GMUI_groupCellsW[_Layer,_Group],CellX,Anchor) + (GMUII()).GMUI_groupCellX[_Layer,_Group];
CellY = GMUI_GetAnchoredCellY((GMUII()).GMUI_groupCellsH[_Layer,_Group],CellY,Anchor) + (GMUII()).GMUI_groupCellY[_Layer,_Group];

ActualX = GMUI_CellGetActualX(CellX);
ActualY = GMUI_CellGetActualY(CellY);


// If control is outside of the group boundaries, expand the group to fit it
if (CellX + CellWide > (GMUII()).GMUI_groupCellX[_Layer,_Group] + (GMUII()).GMUI_groupCellsW[_Layer,_Group]) {
    (GMUII()).GMUI_groupCellsW[_Layer,_Group] = CellX + CellWide - (GMUII()).GMUI_groupCellX[_Layer,_Group];
}
if (CellY + CellHigh > (GMUII()).GMUI_groupCellY[_Layer,_Group] + (GMUII()).GMUI_groupCellsH[_Layer,_Group]) {
    (GMUII()).GMUI_groupCellsH[_Layer,_Group] = CellY + CellHigh - (GMUII()).GMUI_groupCellY[_Layer,_Group];
}
    
    

#define GMUI_GroupExists
/// Checks that the group number given exists in the layer in GMUI
// GMUI_GroupExists(Layer Number, Group Number)

if (!is_real(argument0))
    return false;
    
if (!is_real(argument0))
    return false;

var L,G;
L = floor(argument0);
G = floor(argument1);

return (ds_list_find_index((GMUII()).GMUI_groupList[L],G) != -1);

#define GMUI_GroupSetSize
/// Set the cell size of the group
//GMUI_GroupSetSize(Group, cells wide, cells high, Layer)

var _groupNumber, _CellsW, _CellsH, _layerNumber;
_groupNumber = argument0;
_CellsW = argument1;
_CellsH = argument2;
_layerNumber = argument3;

GMUI_groupCellsW[_layerNumber,_groupNumber] = _CellsW;
GMUI_groupCellsH[_layerNumber,_groupNumber] = _CellsH;

#define GMUI_GroupSetPosition
/// Change the position of the group (and all of the controls inside it)
// GMUI_GroupSetPosition(Layer Number, Group Number, Cell X, Cell Y, X Adjustment, Y Adjustment)

// Arguments
var _LayerNumber,_GroupNumber,_CellX,_CellY,_AdjustmentX,_AdjustmentY, ctrl;
_LayerNumber = argument0;
_GroupNumber = argument1;
_CellX = argument2;
_CellY = argument3;
_AdjustmentX = argument4;
_AdjustmentY = argument5;


// Validate
if (!is_real(_GroupNumber) || !is_real(_LayerNumber) || !is_real(_CellX) || !is_real(_CellY)) {
    GMUI_ThrowError("Invalid parameters for GMUI_GroupSetPosition");
    return false;
}

if (_GroupNumber <= 0) {
    GMUI_ThrowError("Group number must be greater than 0");
    return false;
}

if (!GMUI_LayerExists(_LayerNumber)) {
    GMUI_ThrowError("Layer " + string(_LayerNumber) + " doesn't exist. GMUI_GroupSetPosition");
    return false;
}

if (!GMUI_GroupExists(_LayerNumber,_GroupNumber)) {
    GMUI_ThrowError("Group " + string(_GroupNumber) + " doesn't exist on layer " + string(_LayerNumber) + ". GMUI_GroupSetPosition");
}


// Change group position
GMUI_groupCellX[_LayerNumber,_GroupNumber] = GMUI_GetAnchoredCellX(ds_grid_width((GMUII()).GMUI_grid[_LayerNumber]),_CellX,GMUI_groupAnchor[_LayerNumber,_GroupNumber]);
GMUI_groupCellY[_LayerNumber,_GroupNumber] = GMUI_GetAnchoredCellY(ds_grid_height((GMUII()).GMUI_grid[_LayerNumber]),_CellY,GMUI_groupAnchor[_LayerNumber,_GroupNumber]);
GMUI_groupActualX[_LayerNumber,_GroupNumber] = GMUI_CellGetActualX(GMUI_groupCellX[_LayerNumber,_GroupNumber]);
GMUI_groupActualY[_LayerNumber,_GroupNumber] = GMUI_CellGetActualY(GMUI_groupCellY[_LayerNumber,_GroupNumber]);
GMUI_groupRelativeX[_LayerNumber,_GroupNumber] = _AdjustmentX;
GMUI_groupRelativeY[_LayerNumber,_GroupNumber] = _AdjustmentY;

// Re-position all controls within the group
var i;
for(i=0;i<ds_list_size((GMUII()).GMUI_groupControlList[_LayerNumber,_GroupNumber]);i+=1) {
    // Get the control id
    ctrl = ds_list_find_value((GMUII()).GMUI_groupControlList[_LayerNumber,_GroupNumber],i);
    
    if (!instance_exists(ctrl))
    {
        GMUI_ThrowError("Control no longer exists. GMUI_GroupSetPosition(" + _LayerNumber + "," + _GroupNumber + ")");
    }
    else {
        var pCellX,pCellY,groupWidth;
        groupWidth = (GMUII()).GMUI_groupCellsW[_LayerNumber,_GroupNumber];
        pCellX = GMUI_GetAnchoredCellX(groupWidth,(ctrl).RelativeCellX,(ctrl).Anchor);
        pCellY = GMUI_GetAnchoredCellY(groupWidth,(ctrl).RelativeCellY,(ctrl).Anchor);
        // Reset positioning based on group's position
        (ctrl).CellX = GMUI_GetAnchoredCellX(groupWidth,pCellX,(ctrl).Anchor)
            + (GMUII()).GMUI_groupCellX[_LayerNumber,_GroupNumber];
        (ctrl).CellY = GMUI_GetAnchoredCellY(groupWidth,pCellY,(ctrl).Anchor)
            + (GMUII()).GMUI_groupCellY[_LayerNumber,_GroupNumber];
        
        (ctrl).ActualX = GMUI_CellGetActualX((ctrl).CellX);
        (ctrl).ActualY = GMUI_CellGetActualY((ctrl).CellY);
    }
}

// Reset all control regions for the layer
GMUI_GridSetRegionsLayer(_LayerNumber);


#define GMUI_GroupPositionControls
/// Internal: Re-position the controls of the group, or a specific one
// GMUI_GroupPositionControls(

#define GMUI_GroupHide
/// Hide all of the controls within the specified group
//GMUI_GroupHide(group number, layer number, Hide(1) or show(0))

var _Group, _Layer, _Hide, i, ctrl;
_Group = argument0;
_Layer = argument1;
_Hide = argument2;

// Change the value for each of the controls within the group
for(i=0;i<ds_list_size((GMUII()).GMUI_groupControlList[_Layer,_Group]);i+=1) {
    // Get the control id
    ctrl = ds_list_find_value((GMUII()).GMUI_groupControlList[_Layer,_Group],i);
    
    if (!instance_exists(ctrl))
    {
        GMUI_ThrowError("Control no longer exists. GMUI_GroupHide(" + _Layer + "," + _Group + ")");
    }
    else {
        (ctrl).Hidden = _Hide;
    }
}

#define GMUI_ControlInit
/// Initialize the values to use with a GMUI control
// These values are controlled by the GMUI controller, and if commented, they are actually intialized by the Add script.
// GMUI_ControlInit(control object to instantiate)

var i; i = argument0;

if (!instance_exists(i))
    return false;

i.Hovering = 0;
i.Selected = 0;
i.ControlType = "";
i.ControlInput = 1;
i.DoubleSelected = 0;

// For specific controls
i.checkMouseX = 0;
i.checkMouseY = 0;
i.HoveringDirection = 0; // 0 = middle/none (HoveringDirection_None), HoveringDirection_Right=1;HoveringDirection_Up=2;HoveringDirection_Left=3;HoveringDirection_Down=4;

// Custom disable
i.Disabled = 0;

// Custom hidden
i.Hidden = 0;

// NonClickable may be used when a control is moving, for instance. It does not show disabled, but will not register a click
i.NonClickable = 0;

// All of these values are set when added ::

// Layer can disable the control if a higher layer is opened (0 is default)
//Layer = 0;

// Group allows actions for a group of controls, such as disabling, moving, and hiding (0 is no-group)
//Group = 0;

// Cells work like the room grid and are assigned numbers baised on the cell dimensions given
//CellWide = 1;
//CellHigh = 1;
//CellX = 0;
//CellY = 0;

//
//ControlFontAlign = fa_left;
i.ControlFontAlignV = fa_middle;

// ::


// Positioning variables
i.IsAdjusted = false;
// Actual size may be used to use pixel-baised boundary box for the control; still must be within cell block (0 is full cell)
i.ActualW = 0;
i.ActualH = 0;

// Relative position is used if the boundary box should be adjusted
i.RelativeX = 0;
i.RelativeY = 0;

// Actual location may be used when moving controls, however the selection will need to change the grid cell it is in
i.ActualX = x;
i.ActualY = y;

// Graphical variables
i.outboundMax = ceil(room_speed/3);
i.outbound = 0;
i.inboundMax = ceil(room_speed/3);
i.inbound = 0;

// Value variables
i.value = 0;
i.valueString = "0";
i.valuePrevious = i.value;
i.valueStringPrevious = i.valueString;
i.valueChangeDetected = 0;




/// ???:
// The control will be disabled for this many steps before allowing action
//i.Disable = floor(room_speed/20);

#define GMUI_ControlFilterInput
/// Modifies keyboard string to be acceptable for the control. Typcially called on a keypress.

// GMUI_ControlFilterInput(Control Type, Input String - keyboard_string)
// Returns: new input string

var filter, CT, ks;
CT = argument0;
ks = argument1;

switch (CT)
{
// Numerics
    case "intpicker":
    case "textint":
    case "textdecimal":
        if (CT == "textint" || CT == "intpicker")
        {
            ks = string_copy(string_digits(ks),1,18);
        }
        else if (CT == "textdecimal")
        {
            // Check that the last character entered is valid
            filter = string_copy(ks,string_length(ks),1);
            if (string_digits(filter) == "" && filter != ".")
            {
                if (!(string_length(ks) == 1 && string_copy(ks,1,1) == "-"))
                    ks = string_copy(ks,1,string_length(ks)-1);
            }
             
            ks = string_copy(ks,1,18);
        }
        
        // Only one minus sign and decimal point allowed
        filter = string_copy(ks,string_length(ks),1);
        if (filter == "-" || filter == ".")
        {
            if (string_count("-",ks) > 1 || string_count(".",ks) > 1)
                ks = string_copy(ks,1,string_length(ks)-1);
        }
        else
        {
            // Apply zero's rule
            if (string_copy(ks,1,2) == "00")
                ks = string_copy(ks,2,string_length(ks)-1);
            else if (string_copy(ks,1,1) == "0" && string_length(ks) > 1 && string_copy(ks,2,1) != ".")
                ks = string_copy(ks,2,string_length(ks)-1);
        }
        break;
    case "textstring": //Text-based
        // Any string limitations can go here.
        // (They will probably be optional, like only allow alphabet or alphanumeric or custom or something...
        
        break;
}

return ks;
                    

#define GMUI_ControlDraw
/// The actions done per step for a control added to the grid, along with drawing things
// GMUI_ControlDraw(Draw the control [bool])


// TEMPORARY SOLUTION??:
if (Hidden) return false;

// Extra drawing:
if (Hovering)
{
}


if (Selected)
{
    // Filter keyboard string to type of input allowed
    if (ControlInput && (keyboard_lastkey > 20 || keyboard_lastkey == vk_backspace))
    {
        if (keyboard_check(vk_anykey))
        {
            // On keypress, sanitize input per the type
            keyboard_string = GMUI_ControlFilterInput(ControlType,keyboard_string);
            
            // Max characters allowed for the control's string
            if (ControlMaxStringLength > 0)
                keyboard_string = string_copy(keyboard_string,1,ControlMaxStringLength);
            
            // If 'Overwriting', then reset back to just selected
            if (DoubleSelected)
            {
                if (string_length(keyboard_string) > 0 && string_length(GMUI_ControlFilterInput(ControlType,keyboard_lastchar)) > 0)
                    keyboard_string = string_copy(keyboard_string,string_length(keyboard_string),1);
                else
                    keyboard_string = "";
                    
                DoubleSelected = false;
            }
        }
        
        // Only does assignment of the value once the key is released
        if (keyboard_check_released(vk_anykey))
        {
            // On release, we need to filter again incase somebody "fat-fingers" multiple keys fast enough to miss the first filter.. interesting.
            keyboard_string = GMUI_ControlFilterInput(ControlType,keyboard_string);
            
            // Assign keyboard string as the value string
            valueString = keyboard_string;
            
            if (ControlType == "textint" || ControlType == "textdecimal" || ControlType = "intpicker")
            {
                // As long as the string is valid, assign stripped zeros to value string, and then assign value
                if (valueString != "." && valueString != "-")
                {
                    valueString = keyboard_string;
                    value = real(valueString);
                    if (ControlType == "textint")
                    {
                        value = round(value);
                    }
                    
                    // Found the change!
                    valueChangeDetected = 1;
                }
            }
            else if (ControlType == "textstring")
            {
                value = valueString;
            }
        }
    }
}

if (valueChangeDetected)
{
    // This may need some checks on if it should be allowed to set value... we'll see
                
    // Convert the control type to the data type, as there can be multiple control types with the same data type.
    var DataType;
    switch (ControlType)
    {
        case "textint":
        case "intpicker":
            DataType = "integer";
            break;
        case "textdecimal":
        case "doublepicker":
            DataType = "decimal";
            break;
        case "textstring":
        default:
            DataType = "string";
            break;
    }
    GMUI_SetValue(valueName,value,DataType);
    
    //Reset
    valueChangeDetected = 0;
}



// DRAW //

if (argument0 == true)
{
    // Draw the control
    // Cell x,y and Cell width/height x,y
    var cx, cy, cwx, chy;
    //cx = (GMUII()).cellsize * CellX + RelativeX;
    //cy = (GMUII()).cellsize_h * CellY + RelativeY;
    cx = ActualX + RelativeX;
    cy = ActualY + RelativeY;
    
    if (ActualW > 0)
        cwx = cx + ActualW;
    else
        cwx = cx + ((GMUII()).cellsize * CellWide);
    if (ActualH > 0)
        chy = cy + ActualH;
    else
        chy = cy + ((GMUII()).cellsize * CellHigh);
    
    // Background
    color_alpha(ControlBackgroundColor,ControlBackgroundAlpha);
    draw_rectangle(cx, cy, cwx, chy, 0);
    
    // Border
    color_alpha(ControlBorderColor,ControlBackgroundAlpha);
    draw_rectangle(cx, cy, cwx, chy, 1);
    

    if (Hovering || Selected)
    {
        // Draw the hovering effect
        if (!Selected)
            color_alpha(ControlHoverColor,ControlHoverAlpha);
        else
            color_alpha(ControlSelectColor,ControlSelectAlpha);
        draw_rectangle(cx+1,cy+1,cwx-1,chy-1, ControlHoverBorder);
    }
    
    if (DoubleSelected && ControlInput)
    {
        // Draw 'Overwrite' affect
        color_alpha(ControlOverwriteColor,ControlOverwriteAlpha);
        draw_rectangle(cx+2,cy+2,cwx-2,chy-2,0);
    }
    
    // Draw special features for the other types
    // Integer Picker
    if (ControlType == "intpicker")
    {
        // draw arrows (origin should be on the right and to the corner it is placed at)
        // Top arrow and bottom arrow
        draw_sprite(ControlPickerSpriteRightOrUp,0,cwx-2,cy+2);
        draw_sprite(ControlPickerSpriteLeftOrDown,0,cwx-2,chy-2);
        
        if (ControlPickerDirection == global.GMUIDirectionTypeSideVertical)
        {
            color_alpha(ControlHoverColor,ControlHoverAlpha);
            switch (HoveringDirection)
            {
                case global.GMUIHoveringDirection_Up:
                    draw_rectangle(cwx-2-ControlPickerWidth,cy,cwx-1,cy+(chy-cy)/2,0);
                    break;
                case global.GMUIHoveringDirection_Down:
                    draw_rectangle(cwx-2-ControlPickerWidth,chy-(chy-cy)/2,cwx-1,chy,0);
                    break;
            }
        }
        
    }
    
    
    // Draw the text inside of the keyboard string or value
    var Text, dtx, midHeight;
    if (ControlInput)
    {
        if (Selected)
            Text = keyboard_string;
        else
            Text = valueString;
    }
    else if (ControlType == "textbutton")
    {
        Text = ControlButtonText;
    }
    else
        Text = "";
    
    // Default is for fa_left:
    dtx = cx + 4;    
    if (ControlFontAlign == fa_center)
        dtx = cx+(cwx-cx)/2;
    else if (ControlFontAlign == fa_right)
        dtx = cwx - 4;
    else if (ControlFontAlign != fa_left)
    {
        ControlFontAlign = (GMUII()).ControlFontAlign;
        GMUI_ThrowError("Invalid font align in GMUI_ControlDraw");
    }
    
    if (ActualH > 0)
        midHeight = ActualH / 2;
    else
        midHeight = CellHigh * (GMUII()).cellsize_h / 2;
        
    // Set control font and alignment
    draw_set_font(ControlFont);
    align(ControlFontAlign,ControlFontAlignV);
    
    // Specific controls may override display
    if (ControlType == "textbutton" && ControlButtonTextHoveringOn && Hovering)
        color_alpha(ControlButtonTextHoverColor,ControlFontAlpha);
    else
        color_alpha(ControlFontColor,ControlFontAlpha);
        
    // TEMPORARY SOLUTION! :
    if (Disabled)
        draw_set_alpha(ControlFontAlpha / 2);
        
    
    if (ControlShowCursor && Selected && !DoubleSelected)
        Text = Text + "|";
    draw_text(dtx, cy + midHeight,Text);
    
}
//

#define GMUI_ControlSetStyle
/// Set the style of the controls that will be used for new controls (to override the defaults)
//GMUI_ControlSetStyle(Background Color, Border color, Hover color, hover border/rect, border alpha, Select color, Select alpha, show cursor)
if (!GMUI_IsControl() && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetStyle");
    return false;
}

// If any values are given as negative numbers, those values will remain as the control default

if (argument0 >= 0)
ControlBackgroundColor = argument0;
if (argument1 >= 0)
ControlBorderColor = argument1;
if (argument2 >= 0)
ControlHoverColor = argument2;
if (argument3 >= 0)
ControlHoverBorder = argument3; // Draw a second border on hover (1), or rectangle over control (0)
if (argument4 >= 0)
ControlHoverAlpha = minmax(argument4,0,1);
if (argument5 >= 0)
ControlOverwriteColor = argument5;
if (argument6 >= 0)
ControlOverwriteAlpha = argument6;
if (argument7 >= 0)
ControlSelectColor = argument7;
if (argument8 >= 0)
ControlSelectAlpha = argument8;
if (argument9 >= 0)
ControlShowCursor = argument9;

    
// Defaults that can be optional in the future
ControlBackgroundAlpha = 1;

return true;
    

#define GMUI_ControlSetFontStyle
/// Set the style of the controls that will be used for new controls (to override the defaults)
//GMUI_ControlSetStyle(Background Color, Border color, Hover color, hover border/rect, border alpha, font, font color, font align)
if (!GMUI_IsControl() && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetStyle");
    return false;
}

ControlFont = argument0;
ControlFontColor = argument1;
ControlFontAlign = argument2;
    
// Defaults that can be optional in the future
ControlFontAlpha = 1;
    
return true;
    

#define GMUI_ControlSetAttributes
/// Set the attributes of the control for the different types (to override the defaults)
//GMUI_ControlSetAttributes(max string length(or 0 for none), max decimal length (if applicable), min value, max value, )
if (!GMUI_IsControl() && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetAttributes");
    return false;
}


    ControlMaxStringLength = argument0;
    ControlMaxDecimalLength = argument1; // If applicable
    ControlMinValue = argument2;
    ControlMaxValue = argument3;

return true;
    

#define GMUI_ControlSetPositioning
/// Set the relative positioning and sizing of the control within its cell
// GMUI_ControlSetPositioning( relative x, relative y, actual width, actual height )

if (!GMUI_IsControl() && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetPositioning");
    return false;
}

// Actual width and height has more exact mouse boundaries (0 for full), BUT only 1 control can be in the same cell block
ActualW = argument2;
ActualH = argument3;

// Relative position is used if the boundary box should be adjusted
RelativeX = argument0;
RelativeY = argument1;

// Store that this object has an adjusted position
if (ActualW != 0 || ActualH != 0 || RelativeX != 0 || RelativeY != 0)
    IsAdjusted = true;
else
    IsAdjusted = false;

return true;



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
    

#define GMUI_ControlSetButton
/// Set the picker values of the control (to override the defaults)
//GMUI_ControlSetButton(Text in button or "" , graphic inside button or -1 , sprite to replace drawn button or -1, font alignment or -1, text color on hover or -1)
if (!GMUI_IsControl() && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetButton");
    return false;
}

    ControlButtonText = string(argument0);
    
    if (sprite_exists(argument1))
        ControlButtonGraphic = argument1;
    else
        ControlButtonGraphic = -1;
        
    if (sprite_exists(argument2))
        ControlButtonReplaceImage = argument2;
    else
        ControlButtonReplaceImage = -1;
    
    // Uses same alignment as set in font style
    if (argument3 != -1)
        ControlFontAlign = argument3;
        
    if (argument4 != -1)
    {
        ControlButtonTextHoveringOn = true;
        ControlButtonTextHoverColor = argument4;
    }
    else
    {
        ControlButtonTextHoveringOn = false;
        ControlButtonTextHoverColor = 0;
    }
    

return true;
    

#define GMUI_ControlSetInitValue
/// Set the 'default' value (value/string) for the control, but not the actual value

// GMUI_ControlSetInitValue(value)

if (!GMUI_IsControl() && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetInitValue");
    return false;
}

value = argument0;
valueString = string(argument0);
    
return true;

#define GMUI_ControlSetDefaultStyle
/// Get the default style values from the grid controller
//GMUI_ControlSetDefaultStyle(id)

if (!instance_exists(argument0))
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetDefaultStyle");
    return false;
}

with (argument0)
{
    GMUI_ControlSetStyle(
    (GMUII()).ControlBackgroundColor,
    (GMUII()).ControlBorderColor,
    (GMUII()).ControlHoverColor,
    (GMUII()).ControlHoverBorder,
    (GMUII()).ControlHoverAlpha,
    (GMUII()).ControlOverwriteColor,
    (GMUII()).ControlOverwriteAlpha,
    (GMUII()).ControlSelectColor,
    (GMUII()).ControlSelectAlpha,
    (GMUII()).ControlShowCursor
    );
}

return true;

#define GMUI_ControlSetDefaultFontStyle
/// Get the default style values from the grid controller
//GMUI_ControlSetDefaultStyle(id)

if (!instance_exists(argument0))
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetDefaultFontStyle");
    return false;
}

with (argument0)
{
    GMUI_ControlSetFontStyle(
    (GMUII()).ControlFont,
    (GMUII()).ControlFontColor,
    (GMUII()).ControlFontAlign
    );
}

return true;

#define GMUI_ControlSetDefaultAttributes
/// Set the default attributes of the control from the controller
//GMUI_ControlSetDefaultAttributes(id)

if (!instance_exists(argument0))
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetDefaultAttributes");
    return false;
}

with (argument0)
{
    GMUI_ControlSetAttributes(
    (GMUII()).ControlMaxStringLength,
    (GMUII()).ControlMaxDecimalLength,
    (GMUII()).ControlMinValue,
    (GMUII()).ControlMaxValue
    );
}


return true;

#define GMUI_ControlSetDefaultPicker
/// Set the default attributes of the control from the controller
//GMUI_ControlSetDefaultPicker(id)

if (!instance_exists(argument0))
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetDefaultPicker");
    return false;
}

with (argument0)
{
    GMUI_ControlSetPicker(
    (GMUII()).ControlPickerWidth,
    (GMUII()).ControlPickerHeight,
    (GMUII()).ControlPickerDirection,
    (GMUII()).ControlPickerSpriteRightOrUp,
    (GMUII()).ControlPickerSpriteLeftOrDown
    );
}


return true;

#define GMUI_ControlSetDefaultButton
/// Set the default attributes of the control from the controller
//GMUI_ControlSetDefaultButton(id)

if (!instance_exists(argument0))
{
    GMUI_ThrowError("Invalid control for GMUI_ControlSetDefaultButton");
    return false;
}

with (argument0)
{
    GMUI_ControlSetButton(
    (GMUII()).ControlButtonText,
    (GMUII()).ControlButtonGraphic,
    (GMUII()).ControlButtonReplaceImage,
    (GMUII()).ControlFontAlign,
    (GMUII()).ControlButtonTextHoverColor
    );
}


return true;

#define GMUI_IsControl
/// Checks that the object calling script is a control in GMUI
// GMUI_IsControl()

// Call the actual check with the current object's ID
return GMUI_IsControlID(id);

#define GMUI_IsControlID
/// Checks that the object ID provided is a control
// GMUI_IsControlID(id)

return (ds_list_find_index((GMUII()).GMUI_controlList,argument0) != -1);

#define GMUI_GridEnabled
/// Returns if the entire grid is enabled to be used

if (InitialDisable > 0)
{
    InitialDisable -= 1;
    return false;
}
else
{
    return true;
}

#define GMUI_GridDraw
/// Actions done to operate the grid, executed by the GMUI object in the draw event


// Count down initial disable before executing actions
if (GMUI_GridEnabled())
{
    //do grid stuff:
    
    // Assign mouse values here to easily switch out later if needed
    var MX, MY, inRegion, onDirection;
    MX = mouse_x;
    MY = mouse_y;
    inRegion = false;
    
    // Check if the mouse has moved before checking for any changed selections
    if (MX != mouse_px || MY != mouse_py)
    {
        // Get the mouse position on the current top layer visible:
        var mouseHor,mouseVert;
        mouseHor = GMUI_GridGetMouseCellX(MX);
        mouseVert = GMUI_GridGetMouseCellY(MY);

        // Find if there is a control at that position
        ctrlObject = ds_grid_get(GMUI_grid[UILayer],mouseHor,mouseVert);
        if (ctrlObject != 0)
        {
            // Found object number, do checks before assigning hovering or selected flag
            if (instance_exists(ctrlObject))
            {
                if (DebugData) TestHoverObject = ctrlObject;
                if (ctrlObject != previousHoveringControl && !ctrlObject.Disabled && !ctrlObject.NonClickable)
                {
                    GMUI_ResetControlStatus("Hovering");
                    if (ctrlObject.IsAdjusted)
                    {
                        if (GMUI_MouseInAdjustedRegion(ctrlObject,MX,MY))
                            inRegion = true;
                    }
                    else
                        inRegion = true;
                    
                    if (inRegion)
                    {
                        // The int picker has a region on the right side for up/down
                        if (ctrlObject.ControlType == "intpicker")
                        {
                            onDirection = GMUI_MouseInSpecialRegion(ctrlObject,MX,MY);
                            
                            if (onDirection != global.GMUIHoveringDirection_None)
                                ctrlObject.HoveringDirection = onDirection;
                            else
                                ctrlObject.Hovering = 1;
                        }
                        else
                            ctrlObject.Hovering = 1;
                    }
                    
                    HoveringControl = ctrlObject;
                }
                
            }
            else
                GMUI_ThrowError("Instance recorded is not a control object or no longer exists @ GMUI_GridStep : " + string(ctrlObject));
        }
        else if (HoveringControl != -1)
        {
            GMUI_ResetControlStatus("Hovering");
            if (DebugData) TestHoverObject = -1;
        }
    
    
        // Reset previous position
        mouse_px = MX;
        mouse_py = MY;
    }
    
    // Mouse click on grid
    if (mouse_check_button_pressed(mb_left))
    {
        GMUI_ResetControlStatus("Selected");
    
        // Get the mouse position on the current top layer visible:
        var mouseHor,mouseVert;
        mouseHor = GMUI_GridGetMouseCellX(MX);
        mouseVert = GMUI_GridGetMouseCellY(MY);
        // Find if there is a control at that position
        ctrlObject = ds_grid_get(GMUI_grid[UILayer],mouseHor,mouseVert);
        if (ctrlObject != 0)
        {
            if (instance_exists(ctrlObject))
            {
                if ((!ctrlObject.Disabled) && (!ctrlObject.NonClickable) && (!ctrlObject.Hidden))
                {
                    // Switch between special types, general input types, and other controls
                    if (ctrlObject.ControlType == "intpicker")
                    {
                        switch (ctrlObject.HoveringDirection)
                        {
                            case global.GMUIHoveringDirection_Up:
                            case global.GMUIHoveringDirection_Right:
                                GMUI_SetValue(ctrlObject.valueName,ctrlObject.value + 1,"integer");
                                break;
                            case global.GMUIHoveringDirection_Left:
                            case global.GMUIHoveringDirection_Down:
                                GMUI_SetValue(ctrlObject.valueName,ctrlObject.value - 1,"integer");
                                break;
                            case global.GMUIHoveringDirection_None:
                                GMUI_GridSelect(ctrlObject);
                                break;
                        }
                    }
                    else if (ctrlObject.ControlInput)
                    {
                        GMUI_GridSelect(ctrlObject);
                    }
                    else
                    {
                        // Control buttons clicked
                        GMUI_Actions(ctrlObject.valueName);
                    }
                }
            }
        }
    }
    
    // Any key event will trigger a set value on a selected control in GMUI_ControlDraw, so here    ..
    if (SelectedControl != -1)
    {
        if (keyboard_check_pressed(vk_tab))
        {
            GMUI_GridNextControl();
        }
        else if (keyboard_check_pressed(vk_enter))
        {
            GMUI_ResetControlStatus("Selected");
        }
    }
    
    
    
    // Check if the room size has changed to move any anchored controls positions
    // each control needs a relative position...
    

}


#define GMUI_GridSelect
/// Selects a control object from the grid (Called by GMUI_GridStep)

// GMUI_GridSelect(control object)


// Set the keyboard string to the value string
(argument0).valuePrevious = (argument0).value;
(argument0).valueStringPrevious = (argument0).valueString;

keyboard_string = (argument0).valueString;

(GMUII()).SelectedControl = argument0;
(argument0).Selected = 1;

// Double selection will overwrite the current value
if ((GMUII()).PreviousSelectedControl == argument0)
{
    if ((GMUII()).GMUIAllowDoubleSelect)
        (argument0).DoubleSelected = 1;   
}

#define GMUI_GridAdjust
/// Adjusts grid for all layers of the GMUI instance
// GMUI_GridAdjust(cells wide , cells high)

var layer;
for(i=0;i<ds_list_size((GMUII()).GMUI_gridlist);i+=1) {

    layer = ds_list_find_value((GMUII()).GMUI_gridlist,i);
    
    if (layer >= 0) {
        GMUI_GridAdjustLayer(layer,argument0,argument1);
    }
}

#define GMUI_GridAdjustLayer
/// Adjusts the layer's grid based on new dimensions and moves the controls according to their anchors
// GMUI_GridAdjustLayer(Layer Number, cells wide, cells high)

// Layer needs to exist
if (!GMUI_LayerExists(argument0))
    return false;


var _Layer, CW, CH;
_Layer = floor(argument0);

// If cells wide/high are 0, then it is assumed to be adjusted to the room dimensions. If using views, the cells should be specified to avoid glitching.
if (argument1 == 0)
    CW = ceil(room_width/(GMUII()).cellsize);
else
    CW = argument1;

if (argument2 == 0)
    CH = ceil(room_height/(GMUII()).cellsize_h);
else
    CH = argument2;

ds_grid_resize((GMUII()).GMUI_grid[_Layer],CW,CH);

// Get grid dimensions
var gridW, gridH, anc, relX, relY, pCellX, pCellY;
gridW = ds_grid_width((GMUII()).GMUI_grid[_Layer]);
gridH = ds_grid_height((GMUII()).GMUI_grid[_Layer]);

// Move any controls that are anchored to other positions
var ctrl;
for(i=0;i<ds_list_size((GMUII()).GMUI_controlList);i+=1) {
    // Get control value
    ctrl = ds_list_find_value((GMUII()).GMUI_controlList,i);
    
    if (!instance_exists(ctrl)) {
        GMUI_ThrowError("Control no longer exists. GMUI_GridAdjustLayer()");
    }
    else if ((ctrl).Layer == _Layer && ctrl.Group == 0) {
        // The relative values when the grid is adjusted has four relative positions: Middle X's, Middle Y's, Right X's, Bottom Y's)
    
        // Use the anchor and position relative to it 
        anc = (ctrl).Anchor;
        relX = (ctrl).RelativeCellX;
        relY = (ctrl).RelativeCellY;
        pCellX = (ctrl).CellX;
        pCellY = (ctrl).CellY;        
        
        // Use grid's dimensions unless part of a group (handled by group move)
        (ctrl).CellX = GMUI_GetAnchoredCellX(gridW,relX,anc);
        (ctrl).CellY = GMUI_GetAnchoredCellY(gridH,relY,anc);
        
        // Actual position based on its grid position
        (ctrl).ActualX = GMUI_CellGetActualX((ctrl).CellX);
        (ctrl).ActualY = GMUI_CellGetActualY((ctrl).CellY);
        
        // Check boundaries
        if (!GMUI_ValidCellBounds(anc,(ctrl).CellX,(ctrl).CellY,gridW,gridH)) {
            GMUI_ThrowError("Cell values out of bounds. GMUI_GridAdjustLayer() on ('" + string((ctrl).Layer) + "'," + string(argument1) + "," + string(argument2) + "...");
        }
    }
}

// Move any groups that are anchored to other positions
var groupId;
for(i=0;i<ds_list_size((GMUII()).GMUI_groupList[_Layer]);i+=1) {
    groupId = ds_list_find_value((GMUII()).GMUI_groupList[_Layer],i);
    
    GMUI_GroupSetPosition(_Layer,groupId,GMUI_groupCellX[_Layer,groupId],GMUI_groupCellY[_Layer,groupId],GMUI_groupRelativeX[_Layer,groupId],GMUI_groupRelativeY[_Layer,groupId]);
}

// Reset the regions for the layer
GMUI_GridSetRegionsLayer(_Layer);



return true;


#define GMUI_GridSetRegions
/// Set the control regions for all layers

// Cycle through each grid layer to set region
var i,l;
for(i=0;i<ds_list_size((GMUII()).GMUI_gridlist);i+=1) {
    l = ds_list_find_value((GMUII()).GMUI_gridlist,i);
    GMUI_GridSetRegionsLayer(l);
}

#define GMUI_GridSetRegionsLayer
/// Set the control regions for the given layer

var _Layer,_Grid;
_Layer = argument0;
_Grid = (GMUII()).GMUI_grid[_Layer];

// Clear grid out first
ds_grid_clear(_Grid,0);

// Loop through all controls in the layer
var i,ctrl;
for(i=0;i<ds_list_size((GMUII()).GMUI_controlList);i+=1) {
    // Get control value
    ctrl = ds_list_find_value((GMUII()).GMUI_controlList,i);
    
    if (!instance_exists(ctrl)) {
        GMUI_ThrowError("Control no longer exists. GMUI_GridSetRegionsLayer()");
    }
    else if ((ctrl).Layer == _Layer) {
        // Map the control to the grid[layer#] - Warning: This will overwrite any existing instance values (overlapping)
        ds_grid_set_region(_Grid,(ctrl).CellX,(ctrl).CellY,(ctrl).CellX+(ctrl).CellWide-1,(ctrl).CellY+(ctrl).CellHigh-1,ctrl);
    }
    
}

#define GMUI_GridResetControlRegion
/// Resets any control values in the control's previous region
//GMUI_GridResetControlRegion(Layer, previous CellX, previous CellY, Cell Width, Cell Height, control id)


var _Layer, _pCellX, _pCellY, _CellW, _CellH, _CtrlId;
_Layer = argument0;
_pCellX = argument1;
_pCellY = argument2;
_CellW = argument3;
_CellH = argument4;
_CtrlId = argument5;

// Loop through region to reset control value to 0
var i,j;
for (i=0;i<_CellW;i+=1) {
    for (j=0;j<_CellH;j+=1) {
        if (ds_grid_get((GMUII()).GMUI_grid[_Layer],_pCellX+i,_pCellY+j) == _CtrlId) {
                ds_grid_set((GMUII()).GMUI_grid[_Layer],_pCellX+i,_pCellY+j,0);
        }
    }
}

#define GMUI_GridNextControl
/// Changes the selected control to the next control in the list by ID

// Select the first control if none are selected, otherwise pull the next ID
var ctrlIndex,ctrl;
if ((GMUII()).SelectedControl != -1)
{
    ctrlIndex = ds_list_find_index((GMUII()).GMUI_controlList,(GMUII()).SelectedControl);
    if (ctrlIndex < 0)
        ctrlIndex = -1;
}
else
    ctrlIndex = -1;

GMUI_ResetControlStatus("Selected");

ctrl = ds_list_find_value((GMUII()).GMUI_controlList,ctrlIndex + 1);
if (ctrl > 0 && instance_exists(ctrl))
{
    if ((!ctrl.Disabled) && (!ctrl.NonClickable) && (!ctrl.Hidden))
    {
        GMUI_GridSelect(ctrl);
        return true;
    }
}


return false;

#define GMUI_GridGetMouseCellX
/// Returns the horizontal cell block that the mouse is on
// argument0 is usually mouse_x

return ceil((argument0-(GMUII()).GMUI_grid_x[(GMUII()).UILayer])/(GMUII()).cellsize)-1;



#define GMUI_GridGetMouseCellY
/// Returns the vertical cell block that the mouse is on
// argument0 is usually mouse_y

return ceil((argument0-(GMUII()).GMUI_grid_y[(GMUII()).UILayer])/(GMUII()).cellsize_h)-1;



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

#define GMUI_MouseInSpecialRegion
/// Returns direction if mouse is in the adjusted region of the control
// GMUI_MouseInAdjustedSpecialRegion(Control Object, mouse x, mouse y)

var _Control, _MX, _MY, _D, _CW, _CH, sizingW, sizingH;
_Control = argument0;
_MX = argument1;
_MY = argument2;
sizingW = 0;
sizingH = 0;

// Check region of control if valid cotrol
if (!GMUI_IsControlID(_Control) && id != global.GMUIiid)
{
    GMUI_ThrowError("Invalid control for GMUI_MouseInSpecialRegion");
    return global.GMUIHoveringDirection_None;
}

// Get the proper width/height of the cell
if ((_Control).ActualW != 0)
    _CW = (_Control).ActualW;
else
    _CW = (_Control).CellWide * ((GMUII()).cellsize);

if ((_Control).ActualH != 0)
    _CH = (_Control).ActualH;
else
    _CH = (_Control).CellHigh * ((GMUII()).cellsize_h);
    
_D = (_Control).ControlPickerDirection;
    
// if sizing mode is half of cell, then use the direction to find midpoints, otherwise use picker size
if (_D == global.GMUIDirectionTypeSideVertical)
{
    sizingW = (_Control).ControlPickerWidth;
    sizingH = _CH / 2;
}
else if (_D == global.GMUIDirectionTypeVertical)
{
    sizingH = (_Control).ControlPickerHeight + 2; // +2 borders
}
else
{
    sizingW = (_Control).ControlPickerWidth + 2; // +2 borders
}
    
// Check if coordinates are inside the adjusted control based on what adjustments are set
if (_D == global.GMUIDirectionTypeHorizontal)
{
    if ((_MX >= (_Control).ActualX + (_Control).RelativeX) && 
        (_MX <= (_Control).ActualX + (_Control).RelativeX + sizingW))
        return global.GMUIHoveringDirection_Left;
    else if ((_MX >= (_Control).ActualX + (_Control).RelativeX + _CW - sizingW) && 
        (_MX <= (_Control).ActualX + (_Control).RelativeX + _CW))
        return global.GMUIHoveringDirection_Right;
}
else if (_D == global.GMUIDirectionTypeSideVertical)
{
    if ((_MY >= (_Control).ActualY + (_Control).RelativeY) && 
        (_MY <= (_Control).ActualY + (_Control).RelativeY + sizingH) &&
        (_MX >= (_Control).ActualX + _CW - sizingW))
        return global.GMUIHoveringDirection_Up;
    else if ((_MY >= (_Control).ActualY + (_Control).RelativeY + _CH - sizingH) &&
        (_MY <= (_Control).ActualY + (_Control).RelativeY + _CH) &&
        (_MX >= (_Control).ActualX + _CW - sizingW))
    return global.GMUIHoveringDirection_Down;
}

// No Conditions were met
return global.GMUIHoveringDirection_None;



#define GMUI_GetValue
/// Return the value of a control back to use in user code
// argument0 is the string of the key

with (GMUII()) {
    // Retrieve control from the reference map
    var control;
    control = ds_map_find_value(GMUI_map,string(argument0));
    if (string(control) == "0")
        return 0;
    else
        return (control).value;
}

#define GMUI_GetValueString
/// Return the value string of a control back to use in user code
// argument0 is the string of the key

with (GMUII()) {
    // Retrieve control from the reference map
    var control;
    control = ds_map_find_value(GMUI_map,string(argument0));
    if (string(control) == "0")
        return 0;
    else
        return (control).valueString;
}

#define GMUI_SetValue
/// Set the value of a control back to use in user code
// argument0 is the string of the id key
// argument1 is the value to set
// argument2 is the type of value (string(0), integer(1), decimal(2))

with (global.GMUIiid)
{
    // Retrieve control from the reference map
    var control,a2,c;
    control = ds_map_find_value(GMUI_map,argument0);
    
    a2 = string(argument2);
    // If integer or decimal, we will need to do some work to convert the string to an acceptable format
    if (a2 == "0" || string_lower(a2) == "string")
    {
        (control).value = string_copy(string(argument1),0,(control).ControlMaxStringLength);
        (control).valueString = (control).value;
    }
    else if (a2 == "1" || string_lower(a2) == "integer" || string_lower(a2) == "int")
    {
        (control).value = minmax(round(real(argument1)),(control).ControlMinValue,(control).ControlMaxValue);
        (control).valueString = string((control).value);
    }
    else if (a2 == "2" || string_lower(a2) == "decimal")
    {
        (control).value = minmax(real(argument1),(control).ControlMinValue,(control).ControlMaxValue);
        // Remove any trailing zeros if option is turned on, otherwise use simple format
        var formatValue,c,z,strLenFmtVal;
        formatValue = string_format((control).value,(control).ControlMaxStringLength,(control).ControlMaxDecimalLength);
        
        if (GMUIRemoveExtraDecimalZeros && formatValue != "0")
        {
            z = 0;
            strLenFmtVal = string_length(formatValue);
            for (c=0;c<=strLenFmtVal;c+=1) {
                if (string_char_at(formatValue,strLenFmtVal-c) == '0')
                    z += 1;
                else
                    break;
            }
            formatValue = string_copy(formatValue,0,strLenFmtVal-z);
            if (string_char_at(formatValue,string_length(formatValue)) == '.')
            formatValue = string_copy(formatValue,0,string_length(formatValue)-1);
        }
        (control).valueString = formatValue;
    }
    else
    {
        GMUI_ThrowError("Unknown value type for GMUI_SetValue()");
    }
}

#define GMUI_GetControl
/// Return the control id back to use in user code
// argument0 is the string of the key

with (GMUII()) {
    // Retrieve control from the reference map
    var control;
    control = ds_map_find_value(GMUI_map,string(argument0));
    if (string(control) == "0")
        return -1;
    else
        return control;
}

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

#define GMUI_ControlIsDisabled
/// Is control of name disabled
// argument0 is the string of the key (control)

with (GMUII()) {
    // Retrieve control from the reference map
    var control;
    control = ds_map_find_value(GMUI_map,string(argument0));
    if (string(control) == "0") {
        GMUI_ThrowError("Control doesn't exist in GMUI_ControlIsDisabled()");
        return false;
    }
    else {
        return (control).Disabled;
    }
}

#define GMUI_ControlHide
/// Hide or show a control
// argument0 is the string of the key (control)
// argument1 is to hide (1) or show (0)

with (GMUII()) {
    // Retrieve control from the reference map
    var control;
    control = ds_map_find_value(GMUI_map,string(argument0));
    if (string(control) == "0")
        return false;
    else {
        (control).Hidden = argument1;
        return true;
    }
}

#define GMUI_ControlIsHidden
/// Is control of name hidden
// argument0 is the string of the key (control)

with (GMUII()) {
    // Retrieve control from the reference map
    var control;
    control = ds_map_find_value(GMUI_map,string(argument0));
    if (string(control) == "0") {
        GMUI_ThrowError("Control doesn't exist in GMUI_ControlIsHidden()");
        return false;
    }
    else {
        return (control).Hidden;
    }
}

#define GMUI_CellGetActualX
/// Internal: Return the actual X of the cell number
// GMUI_CellGetActualX(X Cell #);

return argument0 * ((GMUII()).cellsize);

#define GMUI_CellGetActualY
/// Internal: Return the actual Y of the cell number
// GMUI_CellGetActualY(Y Cell #);

return argument0 * ((GMUII()).cellsize_h);

#define GMUI_GetAnchoredCellX
/// Returns the new X cell position in the grid based on the anchoring
// GMUI_GetAnchoredCellX(GMUII, Layer, Cell X given, Anchor Type)

// Width of a GMUI grid is usually: ds_grid_width((GMUII()).GMUI_grid[Layer]);

var __GridW, __CellX, __Anchor;
__GridW = argument0;
__CellX = argument1;
__Anchor = argument2;

// Left anchors by default will not need to calculate the grid dimensions or any adjustments
if (__Anchor == global.GMUIAnchorTopLeft || __Anchor == global.GMUIAnchorLeft || __Anchor == global.GMUIAnchorBottomLeft) {
    return __CellX;
}
else {
    // The Mid X's, else the Right X's 
    if (__Anchor == global.GMUIAnchorTop || __Anchor == global.GMUIAnchorBottom) {
        // Half-width accounts for the cell 0 added to the width.
        // (On even widths, 0 is left of the middle and 1 is right of the middle)
        return floor(__GridW / 2 - 0.5) + __CellX;
    }
    else if (__Anchor == global.GMUIAnchorTopRight || __Anchor == global.GMUIAnchorRight || __Anchor == global.GMUIAnchorBottomRight)
        return __GridW - __CellX - 1;
    else
        return __CellX;
}

#define GMUI_GetAnchoredCellY
/// Returns the new X cell position in the grid based on the anchoring
// GMUI_GetAnchoredCellY(GMUII, Layer, Cell Y given, Anchor Type)

// Height of a GMUI grid is usually: ds_grid_height((GMUII()).GMUI_grid[Layer]);

var __GridH, __CellY, __Anchor;
__GridH = argument0;
__CellY = argument1;
__Anchor = argument2;

// Top anchors by default will not need to calculate the grid dimensions or any adjustments
if (__Anchor == global.GMUIAnchorTopLeft || __Anchor == global.GMUIAnchorTop || __Anchor == global.GMUIAnchorTopRight) {
    return __CellY;
}
else {  
    // The Mid Y's else the Bottom Y's
    if (__Anchor == global.GMUIAnchorLeft || __Anchor == global.GMUIAnchorRight) {
        // Half-height accounts for the cell 0 added to the height.
        // (On even height, 0 is top of the middle and 1 is bottom of the middle)
        return floor(__GridH / 2 - 0.5) + __CellY;
    }
    else if (__Anchor == global.GMUIAnchorBottomLeft || __Anchor == global.GMUIAnchorBottom || __Anchor == global.GMUIAnchorBottomRight)
        return __GridH - __CellY - 1;
    else
        return __CellY;
}

#define GMUI_ThrowError
/// GMUI can store errors and can choose to save/report them if needed

//GMUI_ThrowError(Error Message)

(GMUII()).GMUI_ErrorNumber += 1;
(GMUII()).GMUI_Error[(GMUII()).GMUI_ErrorNumber] = string(argument0);

#define GMUI_LastError
/// Return the last error reported from the error list

return (GMUII()).GMUI_Error[(GMUII()).GMUI_ErrorNumber];

#define GMUI_ResetControlStatus
/// Resets the hovering or selected values of the controls
// GMUI_GridStep ("Hovering" / "Selected", GridID)

var a0,ff,ffo; a0 = string(argument0);

if (string_lower(a0) == "selected" || a0 == "1")
{
    (GMUII()).SelectedControl = -1;
    ff = ds_map_find_first((GMUII()).GMUI_map);
    if (string(ff) == "0")
        GMUI_ThrowError("No controls exist for GMUI_ResetControlStatus()");
    else
    {
        // Set all controls' selected variable to false and find previous selection if there is one
        PreviousSelectedControl = -1;
        
        while(string(ff) != "0")
        {
            ffo = ds_map_find_value((GMUII()).GMUI_map,ff);
            if ((ffo).Selected)
                PreviousSelectedControl = ffo;
            (ffo).Selected = 0;
            (ffo).DoubleSelected = 0;
            ff = ds_map_find_next((GMUII()).GMUI_map,ff);
        }
    }
}
else
{
    // Quiet failure if incorrect arguments provided, but still do hovering value
    if (string_lower(a0) != "hovering" && a0 != "0")
        GMUI_ThrowError("Incorrect parameter given to GMUI_ResetControlStatus()");
    
    (GMUII()).HoveringControl = -1;
    ff = ds_map_find_first((GMUII()).GMUI_map);
    if (string(ff) == "0")
        GMUI_ThrowError("No controls exist for GMUI_ResetControlStatus()");
    else
    {
        // Set all controls' hover variable to false
        while(string(ff) != "0")
        {
            ffo = ds_map_find_value((GMUII()).GMUI_map,ff);
            (ffo).Hovering = 0;
            (ffo).HoveringDirection = 0;
            ff = ds_map_find_next((GMUII()).GMUI_map,ff);
        }
    }
    
}

#define GMUI_ValidCellBounds
/// This procedure will lightly check the boundaries for each anchor position, as controls outside the grid will not be recognized properly
// Only checks for max bounds such as negative or over the width/height. User should notice anything else, so I don't think it needs to be a strict check.... for now at least.
// GMUI_ValidCellBounds(anchor,cellX,cellY,gridW,gridH)

// The X cell values 
if (
argument0 == global.GMUIAnchorLeft || argument0 == global.GMUIAnchorTopLeft || argument0 == global.GMUIAnchorBottomLeft || 
argument0 == global.GMUIAnchorTopRight || argument0 == global.GMUIAnchorRight || argument0 == global.GMUIAnchorBottomRight
)
{
    if (argument1 < 0 || argument1 > argument3 - 1)
        return false;
}
//else if ( ... strict check on centered controls


// The Y cell values
if (
argument0 == global.GMUIAnchorTopLeft || argument0 == global.GMUIAnchorTopRight || argument0 == global.GMUIAnchorTop || 
argument0 == global.GMUIAnchorBottomLeft || argument0 == global.GMUIAnchorBottomRight || argument0 == global.GMUIAnchorBottom
)
{
    if (argument2 < 0 || argument2 > argument4 - 1)
        return false;
}
// else if ( ... strict check on centered controls

// Passed
return true;

#define GMUII
/// INTERNAL USE: Returns the current GMUI object instance
// (GMUII()).Value

return global.GMUIiid;

#define GMUIid
/// Returns the GMUI object instance with the given GMUI number
// GMUIid(number)
// Usage: with (GMUIid(1)) { do something; }
// Alternate Usage: if (GMUIid(1)) { call GMUI commands; }

if (!is_real(argument0))
    return - 1;

if (argument0 > 0 && argument0 <= global.GMUIii) {
    if (instance_exists(global.GMUIiid[argument0])) {
        // Change current GMUI to this one:
        global.GMUIiid[0] = global.GMUIiid[argument0];
        return global.GMUIiid[argument0];
    }
}

return -1;

#define hsv
/// Shortcut for making an hsv based color
return make_color_hsv(argument0,argument1,argument2);


#define rgb
/// Shortcut for making a rgb based color
return make_color_rgb(argument0,argument1,argument2);


#define color_alpha
/// Shortcut to set the color and alpha in one call
draw_set_color(argument0);
draw_set_alpha(argument1);

#define align
/// Shortcut to set both horizontal and vertical align in one call
draw_set_halign(argument0);
draw_set_valign(argument1);

#define minmax
/// Shortcut to keep the value within the min & max range given
if (is_real(argument0))
    return min(max(argument0,argument1),argument2);
else
    return argument1;

#define easeExpOut
/// Exponential Ease for moving controls smoothly
// easeExpOut(t,b,c,d) where t is current time, b is start value, c is change in value, and d is duration

var _t,_b,_c,_d;

_t = argument0;
_b = argument1;
_c = argument2;
_d = argument3;


return _c * ( -power( 2, -10 * _t/_d ) + 1 ) + _b;

#define easeBounceOut
/// Bounce Ease for moving controls smoothly
// easeBounceOut(t,b,c,d) where t is current time, b is start value, c is change in value, and d is duration

var t,_b,_c,_d;

_t = argument0;
_b = argument1;
_c = argument2;
_d = argument3;

_t = _t/_d;
if (_t < ( 1 / 2.75 ) )
    return _c * (7.5625 *_t*_t) + _b;
else if (_t < ( 2 / 2.75 ) )
{
    _t -= (1.5/2.75);
    return _c * (7.5625 *_t*_t + .75 ) + _b;
}
else if (_t < ( 2.5 / 2.75 ) )
{
    _t -= (2.25/2.75);
    return _c * (7.5625 *_t*_t + .9375 ) + _b;
}
else
{
    _t -= (2.625/2.75);
    return _c * (7.5625 *_t*_t + .984375 ) + _b;
}

#define easeElasticOut
/// Elastic Ease for moving controls smoothly
// easeElasticOut(t,b,c,d) where t is current time, b is start value, c is change in value, and d is duration

var _t,_b,_c,_d, _p,_s;
_t = argument0;
_b = argument1;
_c = argument2;
_d = argument3;

_t = _t/_d;
if (t == 1)
    return _b + _c;
    
_p = _d * .3;
_s = _p / 4;

return (_c * power( 2, -10 * _t ) * sin(((_t*_d)-_s) * (2*pi)/_p) + _c + _b );
