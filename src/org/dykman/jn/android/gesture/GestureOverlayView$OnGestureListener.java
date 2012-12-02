package org.dykman.jn.android.gesture;
public class GestureOverlayView$OnGestureListener implements android.gesture.GestureOverlayView.OnGestureListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GestureOverlayView$OnGestureListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onGestureStarted(android.gesture.GestureOverlayView arg1,android.view.MotionEvent arg2) { jInterface.Jnido( this, jchildidx + "onGestureStarted_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onGesture(android.gesture.GestureOverlayView arg1,android.view.MotionEvent arg2) { jInterface.Jnido( this, jchildidx + "onGesture_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onGestureEnded(android.gesture.GestureOverlayView arg1,android.view.MotionEvent arg2) { jInterface.Jnido( this, jchildidx + "onGestureEnded_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onGestureCancelled(android.gesture.GestureOverlayView arg1,android.view.MotionEvent arg2) { jInterface.Jnido( this, jchildidx + "onGestureCancelled_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
