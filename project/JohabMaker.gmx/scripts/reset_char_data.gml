#define reset_char_data
///reset_char_data(ind)
/*
    Updates character data & resets character attribs of single character
*/

var ind = argument0;

// reset char data
var _data = charData[| ind];
var _arr = -1;

// Check if the font is viable for drawing
var _chr = ord(get_default_char(ind));
_arr[CHAR.OCCUPIED] = (check_hangul_range(_chr) || (_chr <= 127)) && chr(_chr) != "";

// Build remaining char data
_arr[CHAR.SOURCE] = "";
// _arr[CHAR.BAKED] = _baked; -- unused, those uses atlas sprite instead.
// _arr[CHAR.MASK] = _mask;
_arr[CHAR.X] = 0;
_arr[CHAR.Y] = 0;
charData[| ind] = _arr;

#define reset_char_data_all
///reset_char_data_all()
/*
    Updates character data & resets character attribs of all characteres
*/

// reset char data
/*
// unused, those uses atlas sprite instead. see clear_atlas()
// free all baked & mask surfaces assigned to a glyph
var _charlen = ds_list_size(charData);
for (var i=0; i<_charlen; i++)
{
    var _data = charData[| i];
    
    if (!is_array(_data))
        continue;
    
    // if (surface_exists(_data[@ CHAR.BAKED])) surface_free(_data[@ CHAR.BAKED]);
    // if (surface_exists(_data[@ CHAR.MASK])) surface_free(_data[@ CHAR.MASK]);
    // if (sprite_exists(_data[@ CHAR.BAKED])) sprite_delete(_data[@ CHAR.BAKED]);
    // if (sprite_exists(_data[@ CHAR.MASK])) sprite_delete(_data[@ CHAR.MASK]);
}
*/
ds_list_clear(charData);

// update char data
update_font_attribs();
charLen = gridWid * gridHei;

// reset char data
for (var i=0; i<charLen; i++)
{
    reset_char_data(i);
}