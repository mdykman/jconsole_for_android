package org.dykman.jn.android.gesture;
public class GestureOverlayView$OnGesturingListener implements android.gesture.GestureOverlayView.OnGesturingListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GestureOverlayView$OnGesturingListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onGesturingStarted(android.gesture.GestureOverlayView arg1) { jInterface.Jnido( this, jchildidx + "onGesturingStarted_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onGesturingEnded(android.gesture.GestureOverlayView arg1) { jInterface.Jnido( this, jchildidx + "onGesturingEnded_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
