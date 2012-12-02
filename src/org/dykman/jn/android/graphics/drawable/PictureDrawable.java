package org.dykman.jn.android.graphics.drawable;
public class PictureDrawable extends android.graphics.drawable.PictureDrawable{
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
public PictureDrawable(android.graphics.Picture arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.Picture getPicture(){ if (!testjnOverride( "getPicture" )) return super.getPicture(); return (android.graphics.Picture) jInterface.Jnido( this, jchildidx + "getPicture_" + jlocale + "_", null ); }
@Override public void setPicture(android.graphics.Picture arg1) { if (!testjnOverride( "setPicture" )) { super.setPicture( arg1); return; } jInterface.Jnido( this, jchildidx + "setPicture_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void draw(android.graphics.Canvas arg1) { if (!testjnOverride( "draw" )) { super.draw( arg1); return; } jInterface.Jnido( this, jchildidx + "draw_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getIntrinsicWidth(){ if (!testjnOverride( "getIntrinsicWidth" )) return super.getIntrinsicWidth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getIntrinsicWidth_" + jlocale + "_", null ); }
@Override public int getIntrinsicHeight(){ if (!testjnOverride( "getIntrinsicHeight" )) return super.getIntrinsicHeight(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getIntrinsicHeight_" + jlocale + "_", null ); }
@Override public int getOpacity(){ if (!testjnOverride( "getOpacity" )) return super.getOpacity(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getOpacity_" + jlocale + "_", null ); }
@Override public void setFilterBitmap(boolean arg1) { if (!testjnOverride( "setFilterBitmap" )) { super.setFilterBitmap( arg1); return; } jInterface.Jnido( this, jchildidx + "setFilterBitmap_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setDither(boolean arg1) { if (!testjnOverride( "setDither" )) { super.setDither( arg1); return; } jInterface.Jnido( this, jchildidx + "setDither_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setColorFilter(android.graphics.ColorFilter arg1) { if (!testjnOverride( "setColorFilter" )) { super.setColorFilter( arg1); return; } jInterface.Jnido( this, jchildidx + "setColorFilter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAlpha(int arg1) { if (!testjnOverride( "setAlpha" )) { super.setAlpha( arg1); return; } jInterface.Jnido( this, jchildidx + "setAlpha_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
