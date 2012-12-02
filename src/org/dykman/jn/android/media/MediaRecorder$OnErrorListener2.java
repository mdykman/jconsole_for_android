package org.dykman.jn.android.media;
public class MediaRecorder$OnErrorListener2 implements android.media.MediaRecorder.OnErrorListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public MediaRecorder$OnErrorListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onError(android.media.MediaRecorder arg1,int arg2,int arg3) { jInterface.Jnido( this, "onError_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
