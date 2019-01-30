#define build_char_surface
///build_char_surface(index)
/*
    Updates glyph surface of glyph given the glyph index
*/

// check index
var index = argument0;
if (index < 0)
    return -1;
    
// prep temp surface
if (!surface_exists(glyphTemp))
    glyphTemp = surface_create(charWid, charHei);
else
    surface_resize(glyphTemp, charWid, charHei);

// build & assign to atlas
build_char_surface_to(index, glyphTemp);
bakedAtlas = edit_atlas_glyph(bakedAtlas, index, glyphTemp);

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


var maskSurf = surface_create(charWid, charHei);
maskSurf = get_atlas_glyph(maskAtlas, index, maskSurf); //data[@ CHAR.MASK];

// Build mask .. or "hole"
surface_set_target(tempTexA);
draw_clear(c_black);
draw_set_blend_mode(bm_subtract);
draw_surface(maskSurf, 0, 0);
// draw_sprite(maskSurf, 0, 0, 0);
draw_set_blend_mode(bm_normal);
surface_reset_target();


// Apply mask
draw_set_font(fntCurrent);
surface_set_target(surface);
draw_clear_alpha(0, 0);

// origin content
// use RSH for integer division instead of dividing by 2
// because fractions are basically mortal enemy to textures.. especially pixelated fonts
iui_align_center();
iui_label(charWid >> 1, charHei >> 1, char, c_white);
iui_align_pop();

// mask
draw_set_blend_mode(bm_subtract);
draw_surface(tempTexA, 0, 0);
draw_set_blend_mode(bm_normal);
surface_reset_target();
draw_set_font(fntOWO);

#define build_char_surface_preview
///build_char_surface_preview(index)
/*
    Builds mask preview
*/

// var
var index = argument0;

iui_align_center();
draw_set_font(fntCurrent);

var data = charData[| index];
var dataready = is_array(data);
var char = "";
if (dataready && data[@ CHAR.SOURCE] != undefined && data[@ CHAR.SOURCE] != "")
{
    char = data[@ CHAR.SOURCE];
    // show_debug_message("SRC " + string(typeof(char)));
}
else
{
    char = get_default_char(index);
    // show_debug_message("DEF " + string(char));
}
// show_debug_message("Get char : " + string(char));

// Resize surf
if (surface_exists(tempTexA))
    surface_resize(tempTexA, charWid, charHei);
else
    tempTexA = surface_create(charWid, charHei);
    
if (surface_exists(tempTexB))
    surface_resize(tempTexB, charWid, charHei);
else
    tempTexB = surface_create(charWid, charHei);


// Make "hole" from mask surface
surface_set_target(tempTexA);
draw_clear(c_black);
draw_set_blend_mode(bm_subtract);
draw_surface(maskTemp, 0, 0);
draw_set_blend_mode(bm_normal);
surface_reset_target();

// Build mask applied one
surface_set_target(tempTexB);
draw_clear_alpha(0, 0);
iui_label(charWid >> 1, charHei >> 1, char, c_white);

draw_set_blend_mode(bm_subtract);
draw_surface(tempTexA, 0, 0);
draw_set_blend_mode(bm_normal);
surface_reset_target();


// Build mask preview
surface_set_target(maskPreview);

// draw tint
draw_clear_alpha(c_red, 0.5);
draw_set_blend_mode(bm_subtract);
draw_surface(maskTemp, 0, 0);
draw_set_blend_mode(bm_normal);

// Draw OG glyph
iui_label_alpha(charWid >> 1, charHei >> 1, char, COL.HIGHLIGHT2, 0.5); // original glyph with tint

// mask applied one
draw_surface(tempTexB, 0, 0);
surface_reset_target();

iui_align_pop();
draw_set_font(fntOWO);