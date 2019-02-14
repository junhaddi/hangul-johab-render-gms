///hj_draw_dkb_ext(x, y, str, len, xscale, yscale, rotation, colour, alpha)
/*
    변형된 한글을 드로우 합니다.
    (도깨비 8x4x4벌 형식)
    ==================================
    x, y : 글자 그리는 좌표
    str : 그릴 문자열
    xscale, yscale : 글자의 크기
    rotation : 글자 각도
    colour : 글자 색
    alpha : 글자 알파 (투명도)
*/

// 변수
var _str = argument2;
var _strx = argument0, _stry = argument1; // 글자 위치
var _offx = _strx, _offy = _stry; // 글자 위치에 더해지는 오프셋 변수 (줄바꿈 & 정렬... ETC에 사용)
// var _originx = 0, _originy = 0; // 오프셋 원본 위치
var _strcol = argument3, _stralpha = argument4;
var _strlen = string_length(_str);

// 글자 렌더링 준비
// string_char_at 이 드럽게 느려서 배열로 바꿔줍니다. 배열로 바꿔주는 김에 초/중/종성 인덱스도 같이 캐시해줍니다.
// https://forum.yoyogames.com/index.php?threads/draw_wrapped_colored_text-optimization-the-mother-of-all-textboxes.35901/
var _strarray = -1;
if (global.hjCache[? _str+"_data"] == undefined)
{
    _strarray = hj_dkb_compile_str(_str);
    global.hjCache[? _str+"_data"] = _strarray;
}
else
{
    _strarray = global.hjCache[? _str+"_data"];
    _strlen = array_length_1d(_strarray);
}

// 글자 렌더링 루틴
var _data = -1, _curord = $BEEF;
var _prevchr = ""; // 바로 전 글자
var _dx, _dy, _kr;
var _type, _idx1, _idx2, _idx3;
for (var i=0; i<_strlen; i++)
{
    // 현재 위치의 글자 가져오기 & 오프셋 계산
    // _curchr = string_char_at(_str, i + 1); // string_char_at() = 프레임 잡아먹는 괴몰;;
    _data = _strarray[@ i];
    _type = _data[@ 0];
    _idx1 = _data[@ 1];
    // _dx = _strx + _offx;
    // _dy = _stry + _offy;
    
    switch (_type)
    {
        case 0: // 다음 줄
            _offx = _strx;
            _offy += global.hjGlyphLineheight + global.hjCharHeiAscii;
            break;
        case 1: // ASCII
            draw_sprite_ext(global.hjSpriteAscii, _idx1, _offx, _offy, 1, 1, 0, _strcol, 1);
            
            // 오프셋 증가
            _offx += global.hjCharWidAscii + global.hjGlyphKerning;
            break;
        case 2: // 조합형 한글
            _idx2 = _data[@ 2];
            _idx3 = _data[@ 3];
            
            draw_sprite_ext(global.hjSpriteHan, _idx1, _offx, _offy, 1, 1, 0, _strcol, 1);
            draw_sprite_ext(global.hjSpriteHan, _idx2, _offx, _offy, 1, 1, 0, _strcol, 1);
            draw_sprite_ext(global.hjSpriteHan, _idx3, _offx, _offy, 1, 1, 0, _strcol, 1);
            
            // 오프셋 증가
            _offx += global.hjCharWidHan + global.hjGlyphKerning;
            break;
            
        case 3: // 한글 자모
            draw_sprite_ext(global.hjSpriteHan, _idx1, _offx, _offy, 1, 1, 0, _strcol, 1);
            
            // 오프셋 증가
            _offx += global.hjCharWidHan + global.hjGlyphKerning;
            break;
    }
}