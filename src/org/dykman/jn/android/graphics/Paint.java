package org.dykman.jn.android.graphics;
public class Paint extends android.graphics.Paint{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected java.util.ArrayList jnOverrideList = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid, java.lang.String joverride ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; if (joverride != null && joverride.length() > 0) { java.lang.String[] ss = joverride.split(" "); for (int i = 0; i < ss.length; i++) setjnOverride(ss[i]); } }
public void clearjnOverride () { jnOverrideList.clear (); }
public void setjnOverride (java.lang.String arg1 ) { if (!testjnOverride (arg1)) jnOverrideList.add (arg1); }
public void setjnOverride (java.lang.String arg1, boolean arg2 ) { if (arg2) { if (!testjnOverride (arg1)) jnOverrideList.add (arg1); } else jnOverrideList.remove (arg1); }
public boolean testjnOverride (java.lang.String arg1 ) { return jnOverrideList.contains (arg1); }
public Paint(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public Paint(int arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Paint(android.graphics.Paint arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void finalize() throws java.lang.Throwable{ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void set(android.graphics.Paint arg1) { if (!testjnOverride( "set" )) { super.set( arg1); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void reset(){ if (!testjnOverride( "reset" )) { super.reset(); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", null ); }
@Override public int getFlags(){ if (!testjnOverride( "getFlags" )) return super.getFlags(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getFlags_" + jlocale + "_", null ); }
@Override public void setFlags(int arg1) { if (!testjnOverride( "setFlags" )) { super.setFlags( arg1); return; } jInterface.Jnido( this, jchildidx + "setFlags_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAntiAlias(boolean arg1) { if (!testjnOverride( "setAntiAlias" )) { super.setAntiAlias( arg1); return; } jInterface.Jnido( this, jchildidx + "setAntiAlias_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setDither(boolean arg1) { if (!testjnOverride( "setDither" )) { super.setDither( arg1); return; } jInterface.Jnido( this, jchildidx + "setDither_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setLinearText(boolean arg1) { if (!testjnOverride( "setLinearText" )) { super.setLinearText( arg1); return; } jInterface.Jnido( this, jchildidx + "setLinearText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setSubpixelText(boolean arg1) { if (!testjnOverride( "setSubpixelText" )) { super.setSubpixelText( arg1); return; } jInterface.Jnido( this, jchildidx + "setSubpixelText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setUnderlineText(boolean arg1) { if (!testjnOverride( "setUnderlineText" )) { super.setUnderlineText( arg1); return; } jInterface.Jnido( this, jchildidx + "setUnderlineText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setStrikeThruText(boolean arg1) { if (!testjnOverride( "setStrikeThruText" )) { super.setStrikeThruText( arg1); return; } jInterface.Jnido( this, jchildidx + "setStrikeThruText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setFakeBoldText(boolean arg1) { if (!testjnOverride( "setFakeBoldText" )) { super.setFakeBoldText( arg1); return; } jInterface.Jnido( this, jchildidx + "setFakeBoldText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setFilterBitmap(boolean arg1) { if (!testjnOverride( "setFilterBitmap" )) { super.setFilterBitmap( arg1); return; } jInterface.Jnido( this, jchildidx + "setFilterBitmap_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setStyle(android.graphics.Paint.Style arg1) { if (!testjnOverride( "setStyle" )) { super.setStyle( arg1); return; } jInterface.Jnido( this, jchildidx + "setStyle_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getColor(){ if (!testjnOverride( "getColor" )) return super.getColor(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getColor_" + jlocale + "_", null ); }
@Override public void setColor(int arg1) { if (!testjnOverride( "setColor" )) { super.setColor( arg1); return; } jInterface.Jnido( this, jchildidx + "setColor_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getAlpha(){ if (!testjnOverride( "getAlpha" )) return super.getAlpha(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getAlpha_" + jlocale + "_", null ); }
@Override public void setAlpha(int arg1) { if (!testjnOverride( "setAlpha" )) { super.setAlpha( arg1); return; } jInterface.Jnido( this, jchildidx + "setAlpha_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setARGB(int arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "setARGB" )) { super.setARGB( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "setARGB_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public float getStrokeWidth(){ if (!testjnOverride( "getStrokeWidth" )) return super.getStrokeWidth(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getStrokeWidth_" + jlocale + "_", null ); }
@Override public void setStrokeWidth(float arg1) { if (!testjnOverride( "setStrokeWidth" )) { super.setStrokeWidth( arg1); return; } jInterface.Jnido( this, jchildidx + "setStrokeWidth_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getStrokeMiter(){ if (!testjnOverride( "getStrokeMiter" )) return super.getStrokeMiter(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getStrokeMiter_" + jlocale + "_", null ); }
@Override public void setStrokeMiter(float arg1) { if (!testjnOverride( "setStrokeMiter" )) { super.setStrokeMiter( arg1); return; } jInterface.Jnido( this, jchildidx + "setStrokeMiter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setStrokeCap(android.graphics.Paint.Cap arg1) { if (!testjnOverride( "setStrokeCap" )) { super.setStrokeCap( arg1); return; } jInterface.Jnido( this, jchildidx + "setStrokeCap_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setStrokeJoin(android.graphics.Paint.Join arg1) { if (!testjnOverride( "setStrokeJoin" )) { super.setStrokeJoin( arg1); return; } jInterface.Jnido( this, jchildidx + "setStrokeJoin_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean getFillPath(android.graphics.Path arg1,android.graphics.Path arg2) { if (!testjnOverride( "getFillPath" )) return super.getFillPath( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getFillPath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.graphics.Shader getShader(){ if (!testjnOverride( "getShader" )) return super.getShader(); return (android.graphics.Shader) jInterface.Jnido( this, jchildidx + "getShader_" + jlocale + "_", null ); }
@Override public android.graphics.Shader setShader(android.graphics.Shader arg1) { if (!testjnOverride( "setShader" )) return super.setShader( arg1); return (android.graphics.Shader) jInterface.Jnido( this, jchildidx + "setShader_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.ColorFilter getColorFilter(){ if (!testjnOverride( "getColorFilter" )) return super.getColorFilter(); return (android.graphics.ColorFilter) jInterface.Jnido( this, jchildidx + "getColorFilter_" + jlocale + "_", null ); }
@Override public android.graphics.ColorFilter setColorFilter(android.graphics.ColorFilter arg1) { if (!testjnOverride( "setColorFilter" )) return super.setColorFilter( arg1); return (android.graphics.ColorFilter) jInterface.Jnido( this, jchildidx + "setColorFilter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.Xfermode getXfermode(){ if (!testjnOverride( "getXfermode" )) return super.getXfermode(); return (android.graphics.Xfermode) jInterface.Jnido( this, jchildidx + "getXfermode_" + jlocale + "_", null ); }
@Override public android.graphics.Xfermode setXfermode(android.graphics.Xfermode arg1) { if (!testjnOverride( "setXfermode" )) return super.setXfermode( arg1); return (android.graphics.Xfermode) jInterface.Jnido( this, jchildidx + "setXfermode_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.PathEffect getPathEffect(){ if (!testjnOverride( "getPathEffect" )) return super.getPathEffect(); return (android.graphics.PathEffect) jInterface.Jnido( this, jchildidx + "getPathEffect_" + jlocale + "_", null ); }
@Override public android.graphics.PathEffect setPathEffect(android.graphics.PathEffect arg1) { if (!testjnOverride( "setPathEffect" )) return super.setPathEffect( arg1); return (android.graphics.PathEffect) jInterface.Jnido( this, jchildidx + "setPathEffect_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.MaskFilter getMaskFilter(){ if (!testjnOverride( "getMaskFilter" )) return super.getMaskFilter(); return (android.graphics.MaskFilter) jInterface.Jnido( this, jchildidx + "getMaskFilter_" + jlocale + "_", null ); }
@Override public android.graphics.MaskFilter setMaskFilter(android.graphics.MaskFilter arg1) { if (!testjnOverride( "setMaskFilter" )) return super.setMaskFilter( arg1); return (android.graphics.MaskFilter) jInterface.Jnido( this, jchildidx + "setMaskFilter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.Typeface getTypeface(){ if (!testjnOverride( "getTypeface" )) return super.getTypeface(); return (android.graphics.Typeface) jInterface.Jnido( this, jchildidx + "getTypeface_" + jlocale + "_", null ); }
@Override public android.graphics.Typeface setTypeface(android.graphics.Typeface arg1) { if (!testjnOverride( "setTypeface" )) return super.setTypeface( arg1); return (android.graphics.Typeface) jInterface.Jnido( this, jchildidx + "setTypeface_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.Rasterizer getRasterizer(){ if (!testjnOverride( "getRasterizer" )) return super.getRasterizer(); return (android.graphics.Rasterizer) jInterface.Jnido( this, jchildidx + "getRasterizer_" + jlocale + "_", null ); }
@Override public android.graphics.Rasterizer setRasterizer(android.graphics.Rasterizer arg1) { if (!testjnOverride( "setRasterizer" )) return super.setRasterizer( arg1); return (android.graphics.Rasterizer) jInterface.Jnido( this, jchildidx + "setRasterizer_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setShadowLayer(float arg1,float arg2,float arg3,int arg4) { if (!testjnOverride( "setShadowLayer" )) { super.setShadowLayer( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "setShadowLayer_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void clearShadowLayer(){ if (!testjnOverride( "clearShadowLayer" )) { super.clearShadowLayer(); return; } jInterface.Jnido( this, jchildidx + "clearShadowLayer_" + jlocale + "_", null ); }
@Override public void setTextAlign(android.graphics.Paint.Align arg1) { if (!testjnOverride( "setTextAlign" )) { super.setTextAlign( arg1); return; } jInterface.Jnido( this, jchildidx + "setTextAlign_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getTextSize(){ if (!testjnOverride( "getTextSize" )) return super.getTextSize(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getTextSize_" + jlocale + "_", null ); }
@Override public void setTextSize(float arg1) { if (!testjnOverride( "setTextSize" )) { super.setTextSize( arg1); return; } jInterface.Jnido( this, jchildidx + "setTextSize_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getTextScaleX(){ if (!testjnOverride( "getTextScaleX" )) return super.getTextScaleX(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getTextScaleX_" + jlocale + "_", null ); }
@Override public void setTextScaleX(float arg1) { if (!testjnOverride( "setTextScaleX" )) { super.setTextScaleX( arg1); return; } jInterface.Jnido( this, jchildidx + "setTextScaleX_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getTextSkewX(){ if (!testjnOverride( "getTextSkewX" )) return super.getTextSkewX(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getTextSkewX_" + jlocale + "_", null ); }
@Override public void setTextSkewX(float arg1) { if (!testjnOverride( "setTextSkewX" )) { super.setTextSkewX( arg1); return; } jInterface.Jnido( this, jchildidx + "setTextSkewX_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float ascent(){ if (!testjnOverride( "ascent" )) return super.ascent(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "ascent_" + jlocale + "_", null ); }
@Override public float descent(){ if (!testjnOverride( "descent" )) return super.descent(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "descent_" + jlocale + "_", null ); }
@Override public float getFontMetrics(android.graphics.Paint.FontMetrics arg1) { if (!testjnOverride( "getFontMetrics" )) return super.getFontMetrics( arg1); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getFontMetrics_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getFontMetricsInt(android.graphics.Paint.FontMetricsInt arg1) { if (!testjnOverride( "getFontMetricsInt" )) return super.getFontMetricsInt( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getFontMetricsInt_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getFontSpacing(){ if (!testjnOverride( "getFontSpacing" )) return super.getFontSpacing(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getFontSpacing_" + jlocale + "_", null ); }
@Override public float measureText(char[] arg1,int arg2,int arg3) { if (!testjnOverride( "measureText" )) return super.measureText( arg1, arg2, arg3); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "measureText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public float measureText(java.lang.String arg1,int arg2,int arg3) { if (!testjnOverride( "measureText" )) return super.measureText( arg1, arg2, arg3); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "measureText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public float measureText(java.lang.String arg1) { if (!testjnOverride( "measureText" )) return super.measureText( arg1); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "measureText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float measureText(java.lang.CharSequence arg1,int arg2,int arg3) { if (!testjnOverride( "measureText" )) return super.measureText( arg1, arg2, arg3); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "measureText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public int breakText(char[] arg1,int arg2,int arg3,float arg4,float[] arg5) { if (!testjnOverride( "breakText" )) return super.breakText( arg1, arg2, arg3, arg4, arg5); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "breakText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public int breakText(java.lang.CharSequence arg1,int arg2,int arg3,boolean arg4,float arg5,float[] arg6) { if (!testjnOverride( "breakText" )) return super.breakText( arg1, arg2, arg3, arg4, arg5, arg6); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "breakText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public int breakText(java.lang.String arg1,boolean arg2,float arg3,float[] arg4) { if (!testjnOverride( "breakText" )) return super.breakText( arg1, arg2, arg3, arg4); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "breakText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public int getTextWidths(char[] arg1,int arg2,int arg3,float[] arg4) { if (!testjnOverride( "getTextWidths" )) return super.getTextWidths( arg1, arg2, arg3, arg4); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getTextWidths_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public int getTextWidths(java.lang.CharSequence arg1,int arg2,int arg3,float[] arg4) { if (!testjnOverride( "getTextWidths" )) return super.getTextWidths( arg1, arg2, arg3, arg4); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getTextWidths_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public int getTextWidths(java.lang.String arg1,int arg2,int arg3,float[] arg4) { if (!testjnOverride( "getTextWidths" )) return super.getTextWidths( arg1, arg2, arg3, arg4); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getTextWidths_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public int getTextWidths(java.lang.String arg1,float[] arg2) { if (!testjnOverride( "getTextWidths" )) return super.getTextWidths( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getTextWidths_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void getTextPath(char[] arg1,int arg2,int arg3,float arg4,float arg5,android.graphics.Path arg6) { if (!testjnOverride( "getTextPath" )) { super.getTextPath( arg1, arg2, arg3, arg4, arg5, arg6); return; } jInterface.Jnido( this, jchildidx + "getTextPath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public void getTextPath(java.lang.String arg1,int arg2,int arg3,float arg4,float arg5,android.graphics.Path arg6) { if (!testjnOverride( "getTextPath" )) { super.getTextPath( arg1, arg2, arg3, arg4, arg5, arg6); return; } jInterface.Jnido( this, jchildidx + "getTextPath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public void getTextBounds(java.lang.String arg1,int arg2,int arg3,android.graphics.Rect arg4) { if (!testjnOverride( "getTextBounds" )) { super.getTextBounds( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "getTextBounds_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void getTextBounds(char[] arg1,int arg2,int arg3,android.graphics.Rect arg4) { if (!testjnOverride( "getTextBounds" )) { super.getTextBounds( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "getTextBounds_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
}
