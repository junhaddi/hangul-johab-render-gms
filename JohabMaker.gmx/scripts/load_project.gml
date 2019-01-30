///load_project(fname)
/*
    Loads project
*/

var _dir = argument0;
var _filebuffer = buffer_load(_dir);
var _maskbuffer, _bakedbuffer;

// READ HEADER
buffer_seek(_filebuffer, buffer_seek_start, 0);
var _magic = buffer_read(_filebuffer, buffer_string);

// FAILSAFE
show_debug_message("MAGIC WORD : " + _magic);
if (_magic != "JORT")
{
    show_debug_message("LOAD] INVALID FILE : WRONG MAGIC WORD!!");
    return false;
}

// READ PROJECT INFO
/*
    buffer_write(_filebuffer, buffer_u16, gridWid); // grid size
    buffer_write(_filebuffer, buffer_u16, gridHei);
    buffer_write(_filebuffer, buffer_u16, charWid); // glyph size
    buffer_write(_filebuffer, buffer_u16, charHei);
    buffer_write(_filebuffer, buffer_u8, choRows); // beols
    buffer_write(_filebuffer, buffer_u8, jungRows);
    buffer_write(_filebuffer, buffer_u8, jongRows);
    buffer_write(_filebuffer, buffer_u8, jamoRows);
    buffer_write(_filebuffer, buffer_u8, asciiRows);
    buffer_write(_filebuffer, buffer_u8, FNT_ASCII); // use ascii?
*/
gridWid = buffer_read(_filebuffer, buffer_u16); // grid size
gridHei = buffer_read(_filebuffer, buffer_u16);
charWid = buffer_read(_filebuffer, buffer_u16); // glyph size
charHei = buffer_read(_filebuffer, buffer_u16);
fntSize = buffer_read(_filebuffer, buffer_u8); // font size
choRows = buffer_read(_filebuffer, buffer_u8); // beols
jungRows = buffer_read(_filebuffer, buffer_u8);
jongRows = buffer_read(_filebuffer, buffer_u8);
jamoRows = buffer_read(_filebuffer, buffer_u8);
asciiRows = buffer_read(_filebuffer, buffer_u8);
FNT_ASCII = buffer_read(_filebuffer, buffer_bool); // use ascii
cbAscii = FNT_ASCII;

// READ SIZES AND OFFSETS
var _masksize = buffer_read(_filebuffer, buffer_u32); // sizes
var _bakedsize = buffer_read(_filebuffer, buffer_u32);

var _atlaswid = buffer_read(_filebuffer, buffer_u32); // atlas sizes
var _atlashei = buffer_read(_filebuffer, buffer_u32);

var _maskoff = buffer_read(_filebuffer, buffer_u32); // offsets
var _bakedoff = buffer_read(_filebuffer, buffer_u32);
show_debug_message("OFFSET : ["+string(_maskoff)+","+string(_bakedoff)+"]");

// fuck you sandboxing
var _path = buffer_read(_filebuffer, buffer_string); // font path

// find filename of ttf
var _strlen = string_length(_path);
var _fontname = "", _fontpath = "";
for (var i=_strlen; i>=1; i--)
{
    var _char = string_char_at(_path, i);
    if (_char == "\")
    {
        i++;
        _fontpath = string_copy(_path, 1, i - 1);
        _fontname = string_copy(_path, i, _strlen - i + 1);
        break;
    }
}

show_debug_message("FULL : ["+_path+"]");
show_debug_message("PATH : ["+_fontpath+"]");
show_debug_message("NAME : ["+_fontname+"]");

_path = "";
while (_path == "")
{
    _path = get_open_filename_ext(".ttf 폰트 파일|*.ttf", _fontname, _fontpath, "원본 폰트를 선택해주세요. (겜메 샌드박싱 망해라)");
}
fntPath = _path;
load_font(fntPath, fntSize);

// BUILD BUFFERS & READ SURFACES
_maskbuffer = buffer_create(1, buffer_grow, 1); // surface buffers!
_bakedbuffer = buffer_create(1, buffer_grow, 1);

buffer_copy(_filebuffer, _maskoff, _masksize, _maskbuffer, 0);
buffer_copy(_filebuffer, _bakedoff, _bakedsize, _bakedbuffer, 0);

// prep surfaces
clear_atlas();
if (!surface_exists(atlasTemp))
    atlasTemp = surface_create(_atlaswid, _atlashei);
else
    surface_resize(atlasTemp, _atlaswid, _atlashei);

// build mask sprite.. pixel by pixel wtf yoyogames please fix buffer_set_surface()
// buffer_set_surface(_maskbuffer, atlasTemp, 0, 0, 0);
surface_set_target(atlasTemp);
draw_clear_alpha(0, 0);
var _idx = 0;
for (var i=0; i<_masksize; i+=4)
{
    // get pixel stuff
    var _b = buffer_read(_maskbuffer, buffer_u8);
    var _g = buffer_read(_maskbuffer, buffer_u8);
    var _r = buffer_read(_maskbuffer, buffer_u8);
    var _a = buffer_read(_maskbuffer, buffer_u8);
    
    
    // draw... argh
    var _u = _idx % _atlaswid;
    var _v = _idx div _atlaswid;
    // show_debug_message("(R:"+string(_r)+" G:"+string(_g)+" B:"+string(_b)+" A:"+string(_a)+")");
    iui_rect_alpha(_u, _v, 1, 1, make_colour_rgb(_r, _g, _b), _a / 255);
    _idx++;
}
surface_reset_target();

if (sprite_exists(maskAtlas))
    sprite_delete(maskAtlas);
maskAtlas = sprite_create_from_surface(atlasTemp, 0, 0, _atlaswid, _atlashei, false, false, 0, 0);
surface_save(atlasTemp, working_directory + "/debug/atlas_mask.png");

// build baked sprite
surface_set_target(atlasTemp);
draw_clear_alpha(0, 0);
var _idx = 0;
for (var i=0; i<_bakedsize; i+=4)
{
    // get pixel stuff
    var _b = buffer_read(_bakedbuffer, buffer_u8);
    var _g = buffer_read(_bakedbuffer, buffer_u8);
    var _r = buffer_read(_bakedbuffer, buffer_u8);
    var _a = buffer_read(_bakedbuffer, buffer_u8);
    
    
    // draw... argh
    var _u = _idx % _atlaswid;
    var _v = _idx div _atlaswid;
    // show_debug_message("(R:"+string(_r)+" G:"+string(_g)+" B:"+string(_b)+" A:"+string(_a)+")");
    iui_rect_alpha(_u, _v, 1, 1, make_colour_rgb(_r, _g, _b), _a / 255);
    _idx++;
}
surface_reset_target();

if (sprite_exists(bakedAtlas))
    sprite_delete(bakedAtlas);
bakedAtlas = sprite_create_from_surface(atlasTemp, 0, 0, _atlaswid, _atlashei, false, false, 0, 0);
surface_save(atlasTemp, working_directory + "/debug/atlas_baked.png");
// DELET
buffer_delete(_filebuffer);
buffer_delete(_maskbuffer);
buffer_delete(_bakedbuffer);
