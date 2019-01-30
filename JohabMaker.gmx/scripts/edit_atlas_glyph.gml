///edit_atlas_baked(sprite, glyphindex, surface)
/*
    Edits the part of baked sprite atlas with given surface
    returns new sprite and deletes the given sprite argument
*/

var _atlas = argument0, _idx = argument1, _surf = argument2;
var _atlaswid, _atlashei;

// check sprite
if (sprite_exists(_atlas))
{
    _atlaswid = sprite_get_width(_atlas);
    _atlashei = sprite_get_height(_atlas);
}
else
{
    _atlaswid = charWid * charLen;
    _atlashei = charHei;
}

// check surface
if (!surface_exists(atlasTemp))
    atlasTemp = surface_create(_atlaswid, _atlashei);
else
    surface_resize(atlasTemp, _atlaswid, _atlashei);

surface_set_target(atlasTemp);
// get surface
draw_clear_alpha(0, 0);
if (sprite_exists(_atlas))
    draw_sprite(_atlas, 0, 0, 0);


// Edit surface
var _u = charWid * (_idx % gridWid);
var _v = charHei * (_idx div gridWid);
// Clear area & draw
draw_set_blend_mode(bm_subtract);
iui_rect_alpha(_u, _v, charWid, charHei, c_black, 1);
draw_set_blend_mode(bm_normal);
draw_surface(_surf, _u, _v);
//
surface_reset_target();

// Assign sprite
if (sprite_exists(_atlas))
    sprite_delete(_atlas);
_atlas = sprite_create_from_surface(atlasTemp, 0, 0, _atlaswid, _atlashei, false, false, 0, 0);
return _atlas;
