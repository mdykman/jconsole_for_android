package org.dykman.jn.android.graphics;
public class Picture extends android.graphics.Picture{
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
public Picture(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public Picture(android.graphics.Picture arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void finalize() throws java.lang.Throwable{ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public android.graphics.Canvas beginRecording(int arg1,int arg2) { if (!testjnOverride( "beginRecording" )) return super.beginRecording( arg1, arg2); return (android.graphics.Canvas) jInterface.Jnido( this, jchildidx + "beginRecording_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void endRecording(){ if (!testjnOverride( "endRecording" )) { super.endRecording(); return; } jInterface.Jnido( this, jchildidx + "endRecording_" + jlocale + "_", null ); }
@Override public int getWidth(){ if (!testjnOverride( "getWidth" )) return super.getWidth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getWidth_" + jlocale + "_", null ); }
@Override public int getHeight(){ if (!testjnOverride( "getHeight" )) return super.getHeight(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getHeight_" + jlocale + "_", null ); }
@Override public void draw(android.graphics.Canvas arg1) { if (!testjnOverride( "draw" )) { super.draw( arg1); return; } jInterface.Jnido( this, jchildidx + "draw_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void writeToStream(java.io.OutputStream arg1) { if (!testjnOverride( "writeToStream" )) { super.writeToStream( arg1); return; } jInterface.Jnido( this, jchildidx + "writeToStream_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
