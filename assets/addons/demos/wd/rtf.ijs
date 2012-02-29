NB. creates some RTF (example from User Manual)

rtfdata=: 0 : 0
{
{\fonttbl{\f0\fcourier Courier New;}}
{\colortbl
\red0\green0\blue0;
\red0\green0\blue255;
\red255\green0\blue0;}
\f0
black
\par
\b
\cf1
bold blue
\par
\i
\cf2
\fs60
big bold italic red
}
)

wd 0 : 0
pc abc closeok;
xywh 148 9 34 12;cc close button;cn "Close";
xywh 9 7 128 69;cc rid richeditm es_autovscroll es_sunken;
pas 6 6;pcenter;
rem form end;
)

abc_close_button=: abc_cancel=: abc_close=: wd bind 'pclose'

wd 'set rid *',rtfdata
wd 'pshow'
