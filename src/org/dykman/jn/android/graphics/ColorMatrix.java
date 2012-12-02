package org.dykman.jn.android.graphics;
public class ColorMatrix extends android.graphics.ColorMatrix{
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
public ColorMatrix(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public ColorMatrix(float[] arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ColorMatrix(android.graphics.ColorMatrix arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void set(android.graphics.ColorMatrix arg1) { if (!testjnOverride( "set" )) { super.set( arg1); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void set(float[] arg1) { if (!testjnOverride( "set" )) { super.set( arg1); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void reset(){ if (!testjnOverride( "reset" )) { super.reset(); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", null ); }
@Override public void setScale(float arg1,float arg2,float arg3,float arg4) { if (!testjnOverride( "setScale" )) { super.setScale( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "setScale_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void setRotate(int arg1,float arg2) { if (!testjnOverride( "setRotate" )) { super.setRotate( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setRotate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setConcat(android.graphics.ColorMatrix arg1,android.graphics.ColorMatrix arg2) { if (!testjnOverride( "setConcat" )) { super.setConcat( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setConcat_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void preConcat(android.graphics.ColorMatrix arg1) { if (!testjnOverride( "preConcat" )) { super.preConcat( arg1); return; } jInterface.Jnido( this, jchildidx + "preConcat_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void postConcat(android.graphics.ColorMatrix arg1) { if (!testjnOverride( "postConcat" )) { super.postConcat( arg1); return; } jInterface.Jnido( this, jchildidx + "postConcat_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setSaturation(float arg1) { if (!testjnOverride( "setSaturation" )) { super.setSaturation( arg1); return; } jInterface.Jnido( this, jchildidx + "setSaturation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setRGB2YUV(){ if (!testjnOverride( "setRGB2YUV" )) { super.setRGB2YUV(); return; } jInterface.Jnido( this, jchildidx + "setRGB2YUV_" + jlocale + "_", null ); }
@Override public void setYUV2RGB(){ if (!testjnOverride( "setYUV2RGB" )) { super.setYUV2RGB(); return; } jInterface.Jnido( this, jchildidx + "setYUV2RGB_" + jlocale + "_", null ); }
}
