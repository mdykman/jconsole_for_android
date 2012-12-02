package org.dykman.jn.android.gesture;
public class GestureStroke extends android.gesture.GestureStroke{
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
public GestureStroke(java.util.ArrayList arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.Path getPath(){ if (!testjnOverride( "getPath" )) return super.getPath(); return (android.graphics.Path) jInterface.Jnido( this, jchildidx + "getPath_" + jlocale + "_", null ); }
@Override public android.graphics.Path toPath(float arg1,float arg2,int arg3) { if (!testjnOverride( "toPath" )) return super.toPath( arg1, arg2, arg3); return (android.graphics.Path) jInterface.Jnido( this, jchildidx + "toPath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void clearPath(){ if (!testjnOverride( "clearPath" )) { super.clearPath(); return; } jInterface.Jnido( this, jchildidx + "clearPath_" + jlocale + "_", null ); }
@Override public android.gesture.OrientedBoundingBox computeOrientedBoundingBox(){ if (!testjnOverride( "computeOrientedBoundingBox" )) return super.computeOrientedBoundingBox(); return (android.gesture.OrientedBoundingBox) jInterface.Jnido( this, jchildidx + "computeOrientedBoundingBox_" + jlocale + "_", null ); }
}
