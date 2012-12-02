package org.dykman.jn.android.gesture;
public class GestureOverlayView$OnGesturePerformedListener2 implements android.gesture.GestureOverlayView.OnGesturePerformedListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GestureOverlayView$OnGesturePerformedListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onGesturePerformed(android.gesture.GestureOverlayView arg1,android.gesture.Gesture arg2) { jInterface.Jnido( this, "onGesturePerformed_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
