///ui_button(x, y, w, h, string)
/**
    iui_button()
**/

/// Setup
// box edges
var boxL = argument0, boxT = argument1
var boxR = (boxL + argument2); boxB = (boxT + argument3);

/// Get label and ID.
var stringArray = iui_get_all(argument4);
var ID     = stringArray[0];
var LABEL  = stringArray[1];

/// Button logic
var isClicky = false;

// is hover
if (point_in_rectangle(iui_inputX, iui_inputY, boxL, boxT, boxR, boxB))
{
    iui_hotItem = ID;
    
    // ... and is clicked
    if (iui_activeItem == -1 && iui_inputDown)
        iui_activeItem = ID;
}

// is 'Pressed" (AKA The user pressed and released the button)
if (iui_hotItem == ID && iui_activeItem == ID && !iui_inputDown)
    isClicky = true;


/// Button draw
var _labelcol;
var _border = 1;
var isActive = (iui_activeItem == ID);
var isHot    = (iui_hotItem == ID);

if (iuiButtonShadow)
    iui_rect(argument0 + 8, argument1 + 8, argument2, argument3, COL.GRAY);

// Hovering
if (isHot)
{
    // and clicked
    if (isActive)
    {
        iui_rect(argument0, argument1, argument2, argument3, COL.WHITE); // border
        iui_rect(argument0 + _border, argument1 + _border, argument2 - (_border << 1), argument3 - (_border << 1), COL.BASE);
        _labelcol = COL.WHITE;
    }
    else // nope
    {
        iui_rect(argument0, argument1, argument2, argument3, COL.WHITE);
        iui_rect(argument0 + _border, argument1 + _border, argument2 - (_border << 1), argument3 - (_border << 1), COL.GRAY);
        _labelcol = COL.BASE;
    }
}
else // Nope
{
    // Default
    iui_rect(argument0, argument1, argument2, argument3, COL.GRAY);
    iui_rect(argument0 + _border, argument1 + _border, argument2 - (_border << 1), argument3 - (_border << 1), COL.WHITE);
    _labelcol = COL.BASE;
}

// label
iui_align_center();
iui_label(argument0 + (argument2 >> 1), argument1 + (argument3 >> 1), LABEL, _labelcol);
iui_align_pop();

return isClicky;