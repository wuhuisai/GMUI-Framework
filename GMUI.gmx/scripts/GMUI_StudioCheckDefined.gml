///GMUI_StudioCheckDefined(value) Returns if the argument is defined or not (GM:Studio)

var a0; a0 = argument0;

//GM8:
if (global.GMUIGameMaker8)
    return true;
    
//var notStudio; notStudio = secure_mode; //COMMENT OUT THIS LINE, AND:

//Studio: UNCOMMENT THE NEXT LINE IN GM:STUDIO
return !is_undefined(a0);
