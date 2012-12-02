package org.dykman.jn.android.media;
public class MediaPlayer$OnCompletionListener implements android.media.MediaPlayer.OnCompletionListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public MediaPlayer$OnCompletionListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onCompletion(android.media.MediaPlayer arg1) { jInterface.Jnido( this, jchildidx + "onCompletion_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
