package org.dykman.jn.android.media;
public class JetPlayer$OnJetEventListener implements android.media.JetPlayer.OnJetEventListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public JetPlayer$OnJetEventListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onJetEvent(android.media.JetPlayer arg1,short arg2,byte arg3,byte arg4,byte arg5,byte arg6) { jInterface.Jnido( this, jchildidx + "onJetEvent_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public void onJetUserIdUpdate(android.media.JetPlayer arg1,int arg2,int arg3) { jInterface.Jnido( this, jchildidx + "onJetUserIdUpdate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void onJetNumQueuedSegmentUpdate(android.media.JetPlayer arg1,int arg2) { jInterface.Jnido( this, jchildidx + "onJetNumQueuedSegmentUpdate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onJetPauseUpdate(android.media.JetPlayer arg1,int arg2) { jInterface.Jnido( this, jchildidx + "onJetPauseUpdate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
