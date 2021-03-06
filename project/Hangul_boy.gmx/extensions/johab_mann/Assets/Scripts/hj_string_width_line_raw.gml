///hj_string_width_line_raw(str)
/*
    주어진 한글 문자열 첫 줄(만)의 너비를 반환합니다.
*/

var _in = argument0, _len = 0;
var _strlen = string_length(_in);
var _prev = "", _ch;

for (var i=1; i<=_strlen; i++)
{
    _ch = string_char_at(_in, i);
    
    // 다음줄 체크
    if (_ch == "#" && _prev != "\")
        break;
    
    // 너비 더하기
    if (ord(_ch) >= 0 && ord(_ch) <= $FF) // ASCII 문자 너비 더하기
        _len += global.hjCharWidAscii + global.hjGlyphKerning;
    else // 한글 문자 높이 더하기
        _len += global.hjCharWidHan + global.hjGlyphKerning;
    
    _prev = _ch;
}

return _len;
