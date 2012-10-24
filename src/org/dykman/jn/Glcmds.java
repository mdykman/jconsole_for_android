package org.dykman.jn;

import java.io.UnsupportedEncodingException;

import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RectF;
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

public int glcmds ( Canvas canvas, Paint paint, int[] ipar, String font, int[] buf,int ncnt, int RGBSEQ ) {

final int ANDCLIPPED=0,ANDW=1,ANDH=2,ANDRGB=3,ANDTEXTX=4,ANDTEXTY=5,ANDUNDERLINE=6,ANDFONTANGLE=7,ANDPENRGB=8,ANDBRUSHRGB=9,ANDTEXTRGB=10,ANDBRUSHNULL=11,ANDORGX=12,ANDORGY=13;

int andclipped,andw,andh,andrgb,andtextx,andtexty,andunderline,andfontangle,andpenrgb,andbrushrgb,andtextrgb,andbrushnull,andorgx,andorgy;

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

float[] tarc = new float [8];
Path path = new Path();

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
    paint.setStrokeWidth(1);
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

  case 2015 :    // gllines
    paint.setColor(andpenrgb);
    paint.setStyle(Paint.Style.STROKE);
     c = (cnt - 2) / 2;
     if (0 == c) break;
/*
    {
     for (i = 0; i < c-1; i++) canvas.drawLine(buf[ p + 2 + 2 * i], buf[ p + 3 + 2 * i], buf[ p + 4 + 2 * i], buf[ p + 5 + 2 * i],paint);
     }
*/
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
    paint.setStrokeWidth(buf[p+2]);
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

return errcnt;
}

}
