///select_char(idx)
/*
    Selects character for mask editing
*/

var idx = argument0;

var data = charData[| idx];

if (is_array(data))
{
    charSelected = idx;
    
    // Copy mask to temp surface
    if (data[@ CHAR.OCCUPIED])
        get_atlas_glyph(maskAtlas, idx, maskTemp);
    else
        clear_char_mask_to(maskTemp, 1);
        
    // Copy glyph data
    charOffX = data[@ CHAR.X];
    charOffY = data[@ CHAR.Y];
    charSrc = data[@ CHAR.SOURCE];
    
    // show_debug_message("Selected #" + string(idx));
}
