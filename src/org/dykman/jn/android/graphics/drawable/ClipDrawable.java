package org.dykman.jn.android.graphics.drawable;
public class ClipDrawable extends android.graphics.drawable.ClipDrawable{
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
public ClipDrawable(android.graphics.drawable.Drawable arg1,int arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void inflate(android.content.res.Resources arg1,org.xmlpull.v1.XmlPullParser arg2,android.util.AttributeSet arg3) throws org.xmlpull.v1.XmlPullParserException,java.io.IOException { if (!testjnOverride( "inflate" )) { super.inflate( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "inflate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void invalidateDrawable(android.graphics.drawable.Drawable arg1) { if (!testjnOverride( "invalidateDrawable" )) { super.invalidateDrawable( arg1); return; } jInterface.Jnido( this, jchildidx + "invalidateDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void scheduleDrawable(android.graphics.drawable.Drawable arg1,java.lang.Runnable arg2,long arg3) { if (!testjnOverride( "scheduleDrawable" )) { super.scheduleDrawable( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "scheduleDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void unscheduleDrawable(android.graphics.drawable.Drawable arg1,java.lang.Runnable arg2) { if (!testjnOverride( "unscheduleDrawable" )) { super.unscheduleDrawable( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "unscheduleDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getChangingConfigurations(){ if (!testjnOverride( "getChangingConfigurations" )) return super.getChangingConfigurations(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getChangingConfigurations_" + jlocale + "_", null ); }
@Override public boolean getPadding(android.graphics.Rect arg1) { if (!testjnOverride( "getPadding" )) return super.getPadding( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getPadding_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean setVisible(boolean arg1,boolean arg2) { if (!testjnOverride( "setVisible" )) return super.setVisible( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "setVisible_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setAlpha(int arg1) { if (!testjnOverride( "setAlpha" )) { super.setAlpha( arg1); return; } jInterface.Jnido( this, jchildidx + "setAlpha_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setColorFilter(android.graphics.ColorFilter arg1) { if (!testjnOverride( "setColorFilter" )) { super.setColorFilter( arg1); return; } jInterface.Jnido( this, jchildidx + "setColorFilter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getOpacity(){ if (!testjnOverride( "getOpacity" )) return super.getOpacity(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getOpacity_" + jlocale + "_", null ); }
@Override public boolean isStateful(){ if (!testjnOverride( "isStateful" )) return super.isStateful(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isStateful_" + jlocale + "_", null ); }
@Override protected boolean onStateChange(int[] arg1) { if (!testjnOverride( "onStateChange" )) return super.onStateChange( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onStateChange_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected boolean onLevelChange(int arg1) { if (!testjnOverride( "onLevelChange" )) return super.onLevelChange( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onLevelChange_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onBoundsChange(android.graphics.Rect arg1) { if (!testjnOverride( "onBoundsChange" )) { super.onBoundsChange( arg1); return; } jInterface.Jnido( this, jchildidx + "onBoundsChange_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void draw(android.graphics.Canvas arg1) { if (!testjnOverride( "draw" )) { super.draw( arg1); return; } jInterface.Jnido( this, jchildidx + "draw_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getIntrinsicWidth(){ if (!testjnOverride( "getIntrinsicWidth" )) return super.getIntrinsicWidth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getIntrinsicWidth_" + jlocale + "_", null ); }
@Override public int getIntrinsicHeight(){ if (!testjnOverride( "getIntrinsicHeight" )) return super.getIntrinsicHeight(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getIntrinsicHeight_" + jlocale + "_", null ); }
}
