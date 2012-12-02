package org.dykman.jn;

import java.io.UnsupportedEncodingException;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Point;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Typeface;
import android.util.Log;

public class Glcmds {

void tors (float [] z) {
z[2] = z[0] + z[2]; z[3] = z[1] + z[3];
}

private void androidarcisi (float[] v) {
float xc,yc,a,b;
float ang1,ang2;
xc = v[0] + 0.5f*v[2]; yc = v[1] + 0.5f*v[3];
tors(v);

a = v[4] - xc; b = v[5] - yc;
if(0==a) ang1 = 90f * Math.signum(b);
else ang1 = (180 / (float)Math.PI) * (float)Math.atan(b/a);
if ((0<=ang1) && (a<0)) ang1 = 180 + ang1;
else if ((0>ang1) && (a<0)) ang1 = 180 + ang1;

a = v[6] - xc; b = v[7] - yc;
if(0==a) ang2 = 90f * Math.signum(b);
else ang2 = (180 / (float)Math.PI) * (float)Math.atan(b/a);
if ((0<=ang2) && (a<0)) ang2 = 180 + ang2;
else if ((0>ang2) && (a<0)) ang2 = 180 + ang2;

v[4] = ang2;
if (0>ang1-ang2) v[5] = 360+(ang1-ang2);
else v[5] = ang1-ang2;
}

private void fliprgb (int[] da, int cnt) {
  int i,a;
  for (i = 0; i < cnt; i++)
    {
      da[i] = Integer.rotateRight(Integer.reverseBytes(da[i]), 8);
    }
}


public int[] qextentwv ( Paint paint, String text, int[] lens, int ncnt) {
Rect rect = new Rect();
int[] wlen = new int[ncnt];
int p = 0;

for (int i=0; i<ncnt; i++) {
  paint.getTextBounds(text,p,p+lens[i],rect);
  wlen[i] = rect.width();
  p = p + lens[i];
  }
return wlen;
}

public int glcmds ( Canvas canvas, Paint paint, Path path, int[] ipar, String font, int[] buf,int ncnt, int RGBSEQ ) {

final int ANDCLIPPED=0,ANDW=1,ANDH=2,ANDRGB=3,ANDTEXTX=4,ANDTEXTY=5,ANDUNDERLINE=6,ANDFONTANGLE=7,ANDPENRGB=8,ANDBRUSHRGB=9,ANDTEXTRGB=10,ANDBRUSHNULL=11,ANDORGX=12,ANDORGY=13,NODOUBLEBUF=14;

int andclipped,andw,andh,andrgb,andtextx,andtexty,andunderline,andfontangle,andpenrgb,andbrushrgb,andtextrgb,andbrushnull,andorgx,andorgy,nodoublebuf;

andclipped = ipar[ ANDCLIPPED ];
andw = ipar[ ANDW ];
andh = ipar[ ANDH ];
andrgb = ipar[ ANDRGB ];
andtextx = ipar[ ANDTEXTX ];
andtexty = ipar[ ANDTEXTY ];
andunderline = ipar[ ANDUNDERLINE ];
andfontangle = ipar[ ANDFONTANGLE ];
andpenrgb = ipar[ ANDPENRGB ];
andbrushrgb = ipar[ ANDBRUSHRGB ];
andtextrgb = ipar[ ANDTEXTRGB ];
andbrushnull = ipar[ ANDBRUSHNULL ];
andorgx = ipar[ ANDORGX ];
andorgy = ipar[ ANDORGY ];
nodoublebuf = ipar[ NODOUBLEBUF ];

float[] tarc = new float [8];

int errcnt =  0;
int cmd;
int p =  0;
int i,c,cnt;
//int i,j,c,cnt;

Log.d("JJNI", "Glcmds ncnt: " + Integer.toString(ncnt));
while (p<ncnt) {
  cnt =  buf[p];
  cmd =  buf[p+1];
  switch (cmd) {

  case 2001 :    // glarc
    {
    paint.setStyle(Paint.Style.STROKE);
    paint.setColor(andpenrgb);
    for (i=0;i<8;i++)tarc[i] = buf[p + 2 + i];
    androidarcisi(tarc);
    RectF rectf = new RectF(tarc[0],tarc[1],tarc[2],tarc[3]);
    canvas.drawArc ( rectf, tarc[4], tarc[5], false, paint);
    }
    break;

  case 2004 :    // glbrush
    andbrushrgb = andrgb;
    andbrushnull = 0;
    break;

  case 2005 :    // glbrushnull
    andbrushnull = 1;
    break;

  case 2007 : // glclear

Log.d("JJNI", "Glcmds clear: ");
    andrgb = Color.argb(255,0,0,0);
    andunderline = 0;
    andfontangle = 0;
    andorgx = 0;
    andorgy = 0;
    andpenrgb = andrgb;
    andbrushrgb = andrgb;
    paint.setStrokeWidth(2f);
    paint.setARGB(255,255,255,255);
    paint.setStyle(Paint.Style.FILL);
    canvas.drawRect(0,0,andw,andh,paint);
    andbrushnull = 1;
    andtextx = 0;
    andtexty = 0;
    andtextrgb = andrgb;
    break;

  case 2008 :    // glellipse
    {
    paint.setStyle(Paint.Style.FILL);
    paint.setColor(andbrushrgb);
    for (i=0;i<4;i++)tarc[i] = buf[p + 2 + i];
    for (i=4;i<8;i++)tarc[i] = 0;
    androidarcisi(tarc);
    RectF rectf = new RectF(tarc[0],tarc[1],tarc[2],tarc[3]);
    canvas.drawOval ( rectf,  paint);

    paint.setStyle(Paint.Style.STROKE);
    paint.setColor(andpenrgb);
    canvas.drawOval ( rectf,  paint);
    }
    break;

	case 2012:		// glfont
    try {
    String face, sizestyle;
    int bold=0,italic=0,underline=0,strikeout=0;
    float size=0f;
      byte[] textbuf = new byte[cnt-2];
      for (i=0;i<cnt-2;i++) textbuf[i] = (byte)buf[p+2+i];
      String textstring = new String(textbuf, "UTF-8");
      if (textstring.startsWith("\"")) {
        java.lang.String[] ss = textstring.substring(1).split("\"");
        face = ss[0];
        if (ss.length>1) {
        sizestyle = ss[1];
        java.lang.String[] ss1 = textstring.split(" ");
        size = Float.parseFloat(ss1[0]);
        if (ss1.length>1) {
          for (j = 1; j < ss1.length; j++) {
          if (ss1[j].equals("bold")) bold = 1;
          else if (ss1[j].equals("italic")) italic = 1;
          else if (ss1[j].equals("underline")) andunderline = 1;
          else if (ss1[j].equals("strikeout")) strikeout = 1;
             } } }
      } else {
        java.lang.String[] ss = textstring.split(" ");
        face = ss[0]; 
        if (ss.length>1) {
        size = Float.parseFloat(ss[1]);
        if (ss.length>2) {
          for (j = 2; j < ss.length; j++) {
          if (ss[j].equals("bold")) bold = 1;
          else if (ss[j].equals("italic")) italic = 1;
          else if (ss[j].equals("underline")) andunderline = 1;
          else if (ss[j].equals("strikeout")) strikeout = 1;
        } } } }    

        Typeface ft= Typeface.create(face,(bold + 2*italic));
        paint.setTypeface(ft);
        if (0f != size) paint.setTextSize(Math.abs(size*96f/72f));   // gl2 assume density for desktop

      } catch (UnsupportedEncodingException e) {}
	  break;

	case 2312:		// glfont2
    try {
	  int size10 = buf[ p + 2 ];
	  int bold = 1 & buf[ p + 3 ];
	  int italic = 2 & buf[ p + 3 ]; 
	  andunderline = 4 & buf[ p + 3 ]; 
	  int strikeout = 8 & buf[ p + 3 ]; 
	  int degree10 =  buf[ p + 4 ]; 
	  andfontangle = degree10;

    byte[] textbuf = new byte[cnt-5];
    for (i=0;i<cnt-5;i++) textbuf[i] = (byte)buf[p+5+i];
    String face = new String(textbuf, "UTF-8");

    Typeface ft= Typeface.create(face,(bold + 2*italic));
    paint.setTypeface(ft);
    paint.setTextSize(Math.abs((float)size10*0.1f*96f/72f));   // gl2 assume density for desktop

    } catch (UnsupportedEncodingException e) {}
	  break;

	case 2342:		//glfontangle
	  andfontangle = buf[ p + 2 ];
	  break;

  case 2015 :    // gllines
    paint.setColor(andpenrgb);
    paint.setStyle(Paint.Style.STROKE);
     c = (cnt - 2) / 2;
     if (0 == c) break;
    {
     path.reset();
     path.moveTo(buf[p+2],buf[p+3]);
     for (i = 0; i < c - 1; i++) path.lineTo(buf[ p + 2 + 2 * (1 + i)], buf[ p + 2 + 1 + 2 * (1 + i)]);
     canvas.drawPath(path, paint);
     path.reset();
     }
     break;

  case 2022 :    // glpen
    andpenrgb = andrgb;
    paint.setStrokeWidth(Math.max(1.3f,(float)buf[p+2]));
    break;

  case 2023 :    // glpie
   {
    paint.setStyle(Paint.Style.FILL);
    paint.setColor(andbrushrgb);
    for (i=0;i<8;i++)tarc[i] = buf[p + 2 + i];
    androidarcisi(tarc);
    RectF rectf = new RectF(tarc[0],tarc[1],tarc[2],tarc[3]);
    canvas.drawArc ( rectf, tarc[4], tarc[5], true, paint);
   }
    break;

  case 2024 :    // glpixel
    paint.setColor(andrgb);
     c = (cnt - 2) / 2;
     if (0 == c) break;
     {
     float[] pts = new float[cnt-2];
     for (i = 0; i < cnt - 2; i++) pts[i] = (float)buf[p + 2 + i];
     canvas.drawPoints(pts, paint);
     }
    break;

  case 2076 :    // glpixels
     {
     int a = buf[p + 2];
     int b = buf[p + 3];
     int w = Math.abs( buf[p + 4] );
     int h = buf[p + 5];
     if ((cnt -6) == w*h) {
     int[] colors = new int[w*h];
     System.arraycopy(buf, p + 2 + 4, colors, 0, w*h);
     if (0==RGBSEQ) fliprgb (colors, w*h);
     canvas.drawBitmap(colors, 0, w, a, b, w, h, false, paint);
     }}
    break;

  case 2029 :    // glpolygon
      c = (cnt - 2) / 2;
      if (0 == c) break;
      {
      path.reset();
      path.moveTo(buf[p+2], buf[p+3]);
      for (i=0;i<c-1;i++) path.lineTo(buf[p+2+2*(1+i)], buf[p+2+1+2*(1+i)]);
      path.close();
      if (0 == andbrushnull) {
      paint.setStyle(Paint.Style.FILL);
      paint.setColor(andbrushrgb);
      canvas.drawPath(path, paint);
      path.reset();
      path.moveTo(buf[p+2], buf[p+3]);
      for (i=0;i<c-1;i++) path.lineTo(buf[p+2+2*(1+i)], buf[p+2+1+2*(1+i)]);
      path.close();
      }
      paint.setStyle(Paint.Style.STROKE);
      paint.setColor(andpenrgb);
      canvas.drawPath(path, paint);
      path.reset();
      }
      break;

  case 2031 :    // glrect
    if (0 == andbrushnull) {
      i =  2;
      while (i<cnt ) {
        paint.setColor(andbrushrgb);
        paint.setStyle(Paint.Style.FILL);
        canvas.drawRect (buf[p+i], buf[p+i+1], buf[p+i]+buf[p+i+2], buf[p+i+1]+buf[p+i+3], paint);
        paint.setColor(andpenrgb);
        paint.setStyle(Paint.Style.STROKE);
        canvas.drawRect (buf[p+i], buf[p+i+1], buf[p+i]+buf[p+i+2], buf[p+i+1]+buf[p+i+3], paint);
        i =  i+4;
      }
    } else {
      i =  2;
      paint.setColor(andpenrgb);
      paint.setStyle(Paint.Style.STROKE);
      while (i<cnt ) {
        canvas.drawRect (buf[p+i], buf[p+i+1], buf[p+i]+buf[p+i+2], buf[p+i+1]+buf[p+i+3], paint);
        i =  i+4;
      }
    }
    break;

  case 2032 :    // glrgb
    if (1==RGBSEQ)
      andrgb = Color.argb (255, buf[p+4], buf[p+3], buf[p+2]);
    else
      andrgb = Color.argb (255, buf[p+2], buf[p+3], buf[p+4]);
    break;

  case 2038 :    // gltext
      try {
      byte[] textbuf = new byte[cnt-2];
      for (i=0;i<cnt-2;i++) textbuf[i] = (byte)buf[p+2+i];
      String textstring = new String(textbuf, "UTF-8");
      paint.setColor(andtextrgb);
      paint.setStyle(Paint.Style.FILL);
      canvas.drawText(textstring, andtextx, andtexty, paint);
      textbuf = null;
      textstring = null;
      } catch (UnsupportedEncodingException e) {}
    break;

  case 2040 :    // gltextcolor
    andtextrgb = andrgb;
    break;

  case 2056 :    // gltextxy
    andtextx = buf[p+2];
    andtexty = buf[p+3];
    break;

  default :
    Log.d("JJNI", "Glcmds: cmd not implemented " + Integer.toString(cmd));
    errcnt++;
  }
  p =  p + cnt;
}

ipar[ ANDCLIPPED ] = andclipped;
ipar[ ANDW ] = andw;
ipar[ ANDH ] = andh;
ipar[ ANDRGB ] = andrgb;
ipar[ ANDTEXTX ] = andtextx;
ipar[ ANDTEXTY ] = andtexty;
ipar[ ANDUNDERLINE ] = andunderline;
ipar[ ANDFONTANGLE ] = andfontangle;
ipar[ ANDPENRGB ] = andpenrgb;
ipar[ ANDBRUSHRGB ] = andbrushrgb;
ipar[ ANDTEXTRGB ] = andtextrgb;
ipar[ ANDBRUSHNULL ] = andbrushnull;
ipar[ ANDORGX ] = andorgx;
ipar[ ANDORGY ] = andorgy;
ipar[ NODOUBLEBUF ] = nodoublebuf;

return errcnt;
}

}
