
uiActive = true;

tbFntSize = "12";
tbCellWid = "16";
tbCellHei = "16";
cbAscii = true;
cbExportGrid = false;
cbExportBG = false;

// colorem boyy
enum COL
{
    BASE = $151414,
    WHITE = $ecfbfc,
    GRAY = $4f493f,
    TEAL = c_teal,
    BLUE = $88262d,
    HIGHLIGHT = $ab960b, //$3ba6fd
    HIGHLIGHT2 = $3ba6fd
}
uBGCol = COL.BASE;
uTextCol = COL.WHITE;

// top bar
uToolbarHei = 170;

// tool tab
uCurrentTab = 0;

// Tooltip
uiTooltipMsg = "DANK LOL";
uiTooltipShow = false;

// Cursor
/*
    0 - Nrml
    1 - Add
    2 - Del
    3 - Rect
*/
uiCursor = 0;
uiCursorInCrop = false;

// Highlight
uiModal = false;
uiModalMsg = "<ESC> 키로 나가기";
uiModalState = UI_MODAL.PREVIEW;
uiModalInfo = false;

enum UI_MODAL
{
    PREVIEW = 0,
    EXPORT,
    DEBUG,
    LOADING,
    MESSAGE
}

// hangul input
uInputKor = false;
uInputBackCtr = 0;
uInputBackHolding = false;
uTestInputActive = false;
uFontInputActive = false;
var _testStr = "키스의 조건은 다람쥐가 헌 쳇바퀴를#와장창 쾅 우지끈 하고 터트리는것이다!#곰놈돔롬 똠방각하 구와아아악#ABCD 1234567890 !@\#$%^&*()<>/[]_+-=#A quick brown fox died of dysentery#Rest in pepsi,,, press X to die";//"다람쥐 헌 쳇바퀴 타고파#A lazy dog jumps over the quick brown fox#1234567890#ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ#똠방각하#맨도롱 또똣하다";
uTestInput = _testStr;
uFontInput = _testStr;


// Style
// Button
iuiButtonShadow = true;

// Checkbox
iuiColCheckboxBorder = COL.WHITE;
iuiColCheckboxBG = COL.BASE;
iuiColCheckboxFG = COL.HIGHLIGHT2; // the checker colour

// Text box
iuiTextBoxRainbow   = true; // rainbow colour when active
iuiColTextBoxFill   = COL.WHITE;
iuiColTextBoxBorder = c_black;
iuiColTextBoxText   = COL.BASE;
iuiColTextBoxActiveFill     = COL.WHITE;
iuiColTextBoxActiveBorder   = c_black;
iuiColTextBoxActiveText     = COL.BASE;
iuiColTextBoxHotFill    = iuiColTextBoxFill;
iuiColTextBoxHotBorder  = iuiColTextBoxBorder;
iuiColTextBoxHotText    = iuiColTextBoxText;
