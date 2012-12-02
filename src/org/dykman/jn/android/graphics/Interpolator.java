package org.dykman.jn.android.graphics;
public class Interpolator extends android.graphics.Interpolator{
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
public Interpolator(int arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Interpolator(int arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void finalize() throws java.lang.Throwable{ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void reset(int arg1) { if (!testjnOverride( "reset" )) { super.reset( arg1); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void reset(int arg1,int arg2) { if (!testjnOverride( "reset" )) { super.reset( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setKeyFrame(int arg1,int arg2,float[] arg3) { if (!testjnOverride( "setKeyFrame" )) { super.setKeyFrame( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "setKeyFrame_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setKeyFrame(int arg1,int arg2,float[] arg3,float[] arg4) { if (!testjnOverride( "setKeyFrame" )) { super.setKeyFrame( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "setKeyFrame_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void setRepeatMirror(float arg1,boolean arg2) { if (!testjnOverride( "setRepeatMirror" )) { super.setRepeatMirror( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setRepeatMirror_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
