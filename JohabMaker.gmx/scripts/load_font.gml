///load_font(fontDir, size)
/*
    Exec this when you change the font
*/

fntPath = argument0;

if (font_exists(fntTemp))
    font_delete(fntTemp);

// REMEMBER : font_add with .ttf will add """ALL""" the glyphs in the font
fntTemp = font_add(fntPath, argument1, false, false, 666, 666); // weird flex but ok
fntName = font_get_fontname(fntTemp);
fntSize = argument1;

// reset_char_surfaces();
// build_glyph_surface_preview(-1);

// Resize surfaces
surface_resize(glyphSurf, charWid, charHei);
surface_resize(glyphSurfOverlay, charWid, charHei);
surface_resize(maskSurfA, charWid, charHei);
surface_resize(maskSurfB, charWid, charHei);

updateFontSurf = true;
