#define build_char_surface
///build_char_surface(index)
/*
    Updates glyph surface of glyph given the glyph index
*/

// var
var index = argument0;

if (index < 0)
    return -1;
    
var data = charData[| index];
build_char_surface_to(index, data[@ CHAR.BAKED]);
/*
// Build character to draw
var data = charData[| index];
var glyphX = index % gridWid, glyphY = index div gridWid, char = "";

if (data[@ CHAR.SOURCE] != "")
    char = data[@ CHAR.SOURCE];
else
    char = get_default_char(index);


var maskSurf = data[@ CHAR.MASK];
var finalSurf = data[@ CHAR.BAKED];

// Build mask .. or "hole"
surface_set_target(maskTemp);
draw_clear(c_black);
draw_set_blend_mode(bm_subtract);
draw_surface(maskSurf, 0, 0);
draw_set_blend_mode(bm_normal);
surface_reset_target();


// Apply mask
draw_set_font(fntCurrent);

surface_set_target(finalSurf);
draw_clear_alpha(0, false);

// origin content
// use RSH for integer division instead of dividing by 2
// because fractions are basically mortal enemy to textures.. especially pixelated fonts
iui_align_center();
iui_label(charWid >> 1, charHei >> 1, char, c_white);
iui_align_pop();

// mask
/*
draw_set_blend_mode(bm_subtract);
draw_surface(maskTemp, 0, 0);
draw_set_blend_mode(bm_normal);


surface_reset_target();

draw_set_font(fntOWO);
*/

#define build_char_surface_to
///build_char_surface_to(index, surface)
/*
    Draws mask-applied character surface to the surface you want
    The surface must be in size of character or you'il get some teeny weeny small characters
*/

// var
var index = argument0, surface = argument1;
    
if (index < 0)
    return -1;

// Build character to draw
var data = charData[| index];
var glyphX = index % gridWid, glyphY = index div gridWid, char = "";

if (data[@ CHAR.SOURCE] != "")
    char = data[@ CHAR.SOURCE];
else
    char = get_default_char(index);


var maskSurf = data[@ CHAR.MASK];

// Build mask .. or "hole"
surface_set_target(maskTemp);
draw_clear(c_black);
draw_set_blend_mode(bm_subtract);
draw_surface(maskSurf, 0, 0);
draw_set_blend_mode(bm_normal);
surface_reset_target();


// Apply mask
draw_set_font(fntCurrent);
surface_set_target(surface);
draw_clear_alpha(0, false);

// origin content
// use RSH for integer division instead of dividing by 2
// because fractions are basically mortal enemy to textures.. especially pixelated fonts
iui_align_center();
iui_label(charWid >> 1, charHei >> 1, char, c_white);
iui_align_pop();

// mask
draw_set_blend_mode(bm_subtract);
draw_surface(maskTemp, 0, 0);
draw_set_blend_mode(bm_normal);

surface_reset_target();
draw_set_font(fntOWO);

#define build_char_surface_preview
///build_char_surface_preview(index)
/*
    Updates glyph surface from glyph index for mask preview
*/

// var
var index = argument0;

var data = charData[| index];
var char = "";
if (data[@ CHAR.SOURCE] != "")
    char = data[@ CHAR.SOURCE];
else
    char = get_default_char(index);


// resize surf & build surf
if (surface_exists(maskTemp))
    surface_resize(maskTemp, charWid, charHei);
else
    maskTemp = surface_create(charWid, charHei);
build_char_surface_to(index, maskTemp);


// draw
surface_set_target(maskPreview);
draw_clear_alpha(0, 0);

iui_align_center();
draw_set_font(fntCurrent);
iui_label_alpha(charWid >> 1, charHei >> 1, char, c_blue, 0.5); // original glyph with tint
draw_set_font(fntOWO);
iui_align_pop();
draw_surface(maskTemp, 0, 0); // mask applied one

surface_reset_target();

#define build_glyph_old
///build_char_surfaces()
/*
    Build font surfaces
    The problem -- Surfaces in Gamemaker is hella """volatile"""
    So I'm gonna try save them into buffer
    
    ========
    "Also just a heads up it's BGRA format, but if you look at the buffer in the Debugger,
    it's displayed in ARGB. Made debugging confusing.
    Also, for some reason, buffer_set_surface() only works if you __don't modify the buffer__ at all.
    I thought I got it to work once, but i can't find my post that i'd have posted if i did."
    
    .. Dear god yoyo games plzfix asap
*/

// #args font

// set vars
// gridHei = 7;

// if (USE_ASCII)
//     gridHei = 12;

// rebuild
// charLen = gridWid * gridHei;
// reset_char_surfaces();

/*
    BUILD LIST OF SURFACES
    ====================
*/
/*
var _surf = ds_list_create();//surface_create(charWid, charHei);
var _midX = charWid>>1, _midY = charHei>>1;

for (var i=0; i<charLen; i++)
{
    _surf[| i] = surface_create(charWid, charHei);
}
*/
/*
surface_set_target(_surf);
draw_clear_alpha(0,0);
iui_label(_midX, _midY, string(i), c_white);
surface_reset_target();
*/

/*
    WRITE GLYPHS
    ====================
*/
// draw_set_halign(1);draw_set_valign(1);

/*
    Compat Jamo range -- $3130 ~ $3163
    For Choseong, Jungseong, Jongseong & Compat. Jamo
*/
/*
if (font_exists(fntTemp))
    font_delete(fntTemp);
fntTemp = font_add(font, fntSize, false, false, $3130, $3163);
*/
/*
draw_set_font(fntTemp);
var lut = "ㄱㄲㄴㄷㄸㄹㅁㅂㅃㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎ";
var offset = 0;
var _idx, _data, _char;

// Build Chosung (Row 1 & 2)
for (var i=0; i<string_length(lut); i++)
{
    _idx = i + offset;
    
    // BEOL #1
    _data = charData[| _idx];
    if (_data[@ CHAR.SAMPLE] == "")
        _char = chr($AC00 + ((i * 21) + 0) * 28 + 16);
    else
        _char = _data[@ CHAR.SAMPLE];
    // _char = string_char_at(lut, i + 1); // rebuild hangul from cho-jung-jongseong
        
    surface_set_target(_surf[| _idx]);
    draw_clear(0);
    iui_label(_midX, _midY, _char, c_white);
    surface_reset_target();
    
    // BEOL #2
    _idx += gridWid;
    _data = charData[| _idx];
    if (_data[@ 0] == "")
        _char = chr($AC00 + ((i * 21) + 8) * 28 + 16);
    else
        _char = _data[@ CHAR.SAMPLE];
    
    surface_set_target(_surf[| _idx]);
    draw_clear(0);
    iui_label(_midX, _midY, _char, c_white);
    surface_reset_target();
}

// Build Jungseong
offset = 2 * gridWid;
lut = "ㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ";

for (var i=0; i<string_length(lut); i++)
{
    _idx = i + offset;
    // _char = string_char_at(lut, i + 1);
    
    _data = charData[| _idx];
    if (_data[@ CHAR.SAMPLE] == "")
        _char = chr($AC00 + i * 28 + 16);
    else
        _char = _data[@ CHAR.SAMPLE];
        // TODO!!
    
    surface_set_target(_surf[| _idx]);
    draw_clear(0);
    iui_label(_midX, _midY, _char, c_white);
    surface_reset_target();
}

// Build Jongseong (Row 4 & 5)
offset = 3 * gridWid + 1; // leave first one empty
lut = "ㄱㄲㄳㄴㄵㄶㄷㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅄㅅㅆㅇㅈㅊㅋㅌㅍㅎ";

for (var i=0; i<string_length(lut); i++)
{
    _idx = i + offset;
    // _chr = string_char_at(lut, i + 1);
    
    // BEOL #1
    _data = charData[| _idx];
    if (_data[@ 0] == "")
        _char = chr($AC00 + i + 1);
    else
        _char = _data[@ 0];
    surface_set_target(_surf[| _idx]);
    draw_clear(0);
    iui_label(_midX, _midY, _char, c_white);
    surface_reset_target();
    
    // BEOL #2
    _idx += gridWid;
    _data = charData[| _idx];
    if (_data[@ 0] == "")
        _char = chr($AC00 + ((1 * 21) + 8) * 28 + i + 1);
    else
        _char = _data[@ 0];
    surface_set_target(_surf[| _idx]);
    draw_clear(0);
    iui_label(_midX, _midY, _char, c_white);
    surface_reset_target();
}

// Build Compat. Jamo (Row 6 & 7)
offset = 5 * gridWid + 1;
lut = "ㄱㄲㄳㄴㄵㄶㄷㄸㄹㄺㄻㄼㄽㄾㄿㅀㅁㅂㅃㅄㅅㅆㅇㅈㅉㅊㅋㅌㅍㅎㅏㅐㅑㅒㅓㅔㅕㅖㅗㅘㅙㅚㅛㅜㅝㅞㅟㅠㅡㅢㅣ";

for (var i=0; i<string_length(lut); i++)
{
    _char = string_char_at(lut, i + 1);
    
    surface_set_target(_surf[| i + offset]);
    draw_clear(0);
    iui_label(_midX, _midY, _char, c_white);
    surface_reset_target();
}
*/

/*
    ASCII -- 0 ~ 255
    AEUHHHH!?!?!?!?!
*/
/*
if (USE_ASCII)
{
    // if (font_exists(fntTemp))
    //    font_delete(fntTemp);
    // fntTemp = font_add(font, fntSize, false, false, 0, 255);
    
    offset = 7 * gridWid;
    var remain = charLen - offset;
    for (var i=0; i<remain; i++)
    {
        _chr = chr(i);
        
        surface_set_target(_surf[| i + offset]);
        draw_clear(0);
        iui_label(_midX, _midY, _chr, c_white);
        surface_reset_target();
    }
}
*/

/*
    Assign sprites
*/
/*
sprite_delete(charSpr);
// charSpr = sprite_create_from_surface(_surf[| 0], 0, 0, charWid, charHei, false, false, 0, 0);
for (var i=0; i<charLen; i++)
{
    if (sprite_exists(charSpr)) // exists
        sprite_add_from_surface(charSpr, _surf[| i], 0, 0, charWid, charHei, false, false);
    else // nyet
        charSpr = sprite_create_from_surface(_surf[| i], 0, 0, charWid, charHei, false, false, 0, 0);
}
*/


// Redraw surface contents
/*
surface_set_target(fntTex);

// clear
draw_clear_alpha(0,0);

// Draw glyph sprites
for (var i=0; i<charLen; i++)
{
    // get gridwise position
    var _gx = (i % gridWid);
    var _gy = (i div gridWid);
    
    // draw
    // draw_sprite(charSpr, i, _gx * charWid, _gy * charHei);
    draw_surface(_surf[| i], _gx * charWid, _gy * charHei);
}

// grid??
var _texW = _newWid;
var _texH = _newHei;
for (var X=0; X<=gridWid; X++)
{
    for (var Y=0; Y<=gridHei; Y++)
    {
        var _worldX = X * charWid;
        var _worldY = Y * charHei;
        iui_rect(_worldX - 1, 0, 2, _texH, $FF00FF);
        iui_rect(0, _worldY - 1, _texW, 2, $FF00FF);
    }
}

surface_reset_target();
*/
/*
sprite_delete(charSpr);
charSpr = sprite_create_from_surface(_surf, 0, 0, charWid, charHei, false, false, 0, 0);
for (var i=0; i<charLen; i++)
{
    if (sprite_exists(charSpr)) // exists
    {
        sprite_add_from_surface(charSpr, _surf, 0, 0, charWid, charHei, false, false);
    }
    else // nyet
    {
        charSpr = sprite_create_from_surface(_surf, 0, 0, charWid, charHei, false, false, 0, 0);
    }
}
*/
/*
    DESTROY LIST OF SURFACES
    ====================
*/
/*
for (var i=0; i<charLen; i++)
{
    surface_free(_surf[| i]);
}
ds_list_destroy(_surf);

draw_set_halign(0);draw_set_valign(0);
draw_set_font(fntOWO);
*/