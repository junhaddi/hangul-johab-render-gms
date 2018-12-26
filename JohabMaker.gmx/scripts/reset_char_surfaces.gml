///init_char_surfaces()
ds_list_clear(charData);
for (var i=0; i<charLen; i++)
{
    var _data = charData[| i];
    if (is_array(_data) && surface_exists(_data[@ CHAR.SURFACE]))
        surface_free(_data[@ CHAR.SURFACE]);
    
    var _arr = -1;
    _arr[CHAR.SAMPLE] = "";
    _arr[CHAR.SURFACE] = surface_create(charWid, charHei);
    _arr[CHAR.BBOX] = false;
    _arr[CHAR.X] = 0;
    _arr[CHAR.Y] = 0;
    _arr[CHAR.W] = charWid;
    _arr[CHAR.H] = charHei;
    charData[| i] = _arr;
}
