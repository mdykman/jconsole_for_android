package org.dykman.jn.android.graphics;
public class PathMeasure extends android.graphics.PathMeasure{
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
public PathMeasure(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public PathMeasure(android.graphics.Path arg1,boolean arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void finalize() throws java.lang.Throwable{ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public float getLength(){ if (!testjnOverride( "getLength" )) return super.getLength(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getLength_" + jlocale + "_", null ); }
@Override public boolean isClosed(){ if (!testjnOverride( "isClosed" )) return super.isClosed(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isClosed_" + jlocale + "_", null ); }
@Override public void setPath(android.graphics.Path arg1,boolean arg2) { if (!testjnOverride( "setPath" )) { super.setPath( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setPath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean getPosTan(float arg1,float[] arg2,float[] arg3) { if (!testjnOverride( "getPosTan" )) return super.getPosTan( arg1, arg2, arg3); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getPosTan_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean getMatrix(float arg1,android.graphics.Matrix arg2,int arg3) { if (!testjnOverride( "getMatrix" )) return super.getMatrix( arg1, arg2, arg3); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getMatrix_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean getSegment(float arg1,float arg2,android.graphics.Path arg3,boolean arg4) { if (!testjnOverride( "getSegment" )) return super.getSegment( arg1, arg2, arg3, arg4); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getSegment_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public boolean nextContour(){ if (!testjnOverride( "nextContour" )) return super.nextContour(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "nextContour_" + jlocale + "_", null ); }
}
