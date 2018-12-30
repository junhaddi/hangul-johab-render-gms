///build_font_tex()
/*
    Build font texture by blitting glyphs surface
*/
// Update surface
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
    }
}

// Glyphs
var _charlen = gridWid * gridHei;
var _data;
for (var i=0; i<_charlen; i++)
{
    _data = charData[| i];
    var _x = (i % gridWid) * charWid;
    var _y = (i div gridWid) * charHei;
    
    build_char_surface(i);
    draw_surface(_data[@ CHAR.BAKED], _x, _y);
    
    // draw_surface(glyphTex, _x, _y);
}
show_debug_message("DRAWN " + string(_charlen) + " CHARACTERS TOTAL");

surface_reset_target();