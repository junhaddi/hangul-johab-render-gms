// if (sprite_exists(charSpr))
    // sprite_delete(charSpr);
// surface_free(winTex);

// reset char data
var _charlen = ds_list_size(charData);
for (var i=0; i<_charlen; i++)
{
    var _data = charData[| i];
    
    if (!is_array(_data))
        continue;
    
    if (surface_exists(_data[@ CHAR.BAKED])) surface_free(_data[@ CHAR.BAKED]);
    if (surface_exists(_data[@ CHAR.MASK])) surface_free(_data[@ CHAR.MASK]);
}
ds_list_clear(charData);
ds_list_destroy(charData);

surface_free(glyphTex);
surface_free(maskPreview);
surface_free(maskOverlay);
surface_free(maskTemp);
surface_free(fntTex);