///build_font_tex()
/*
    Build font texture from glyphs
*/
/*
// Update surface attrib
var _newWid = gridWid * charWid;
var _newHei = gridHei * charHei;
if (surface_exists(fntTex))
    surface_resize(fntTex, _newWid, _newHei);
else
    fntTex = surface_create(_newWid, _newHei);


// Redraw surface contents
surface_set_target(fntTex);

// clear
draw_clear_alpha(0,0);

// Draw glyph sprites
for (var i=0; i<sprite_get_number(charSpr); i++)
{
    // get gridwise position
    var _gx = (i % gridWid);
    var _gy = (i div gridWid);
    
    // draw
    draw_sprite(charSpr, i, _gx * charWid, _gy * charHei);
}

surface_reset_target();
*/

// Update surface attrib
var _newWid = gridWid * charWid;
var _newHei = gridHei * charHei;
if (surface_exists(fntTex))
    surface_resize(fntTex, _newWid, _newHei);
else
    fntTex = surface_create(_newWid, _newHei);

// Update contents
surface_set_target(fntTex);

// clear
draw_clear(0);

// Grid
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
        // iui_label(_worldX, _worldY, string(Y), c_red);
    }
}

// Glyphs
for (var i=0; i<charLen; i++)
{
    var _x = (i % gridWid) * charWid;
    var _y = (i div gridWid) * charHei;
    
    build_glyph_surface(i);
    
    draw_surface(glyphSurf, _x, _y);
}

surface_reset_target();
