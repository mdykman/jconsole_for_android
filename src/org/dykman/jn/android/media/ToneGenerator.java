package org.dykman.jn.android.media;
public class ToneGenerator extends android.media.ToneGenerator{
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
public ToneGenerator(int arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void finalize(){ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void release(){ if (!testjnOverride( "release" )) { super.release(); return; } jInterface.Jnido( this, jchildidx + "release_" + jlocale + "_", null ); }
@Override public boolean startTone(int arg1) { if (!testjnOverride( "startTone" )) return super.startTone( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "startTone_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean startTone(int arg1,int arg2) { if (!testjnOverride( "startTone" )) return super.startTone( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "startTone_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void stopTone(){ if (!testjnOverride( "stopTone" )) { super.stopTone(); return; } jInterface.Jnido( this, jchildidx + "stopTone_" + jlocale + "_", null ); }
}
