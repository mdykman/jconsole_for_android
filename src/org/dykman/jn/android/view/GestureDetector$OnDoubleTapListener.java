package org.dykman.jn.android.view;
public class GestureDetector$OnDoubleTapListener implements android.view.GestureDetector.OnDoubleTapListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GestureDetector$OnDoubleTapListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onSingleTapConfirmed(android.view.MotionEvent arg1) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onSingleTapConfirmed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onDoubleTap(android.view.MotionEvent arg1) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onDoubleTap_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onDoubleTapEvent(android.view.MotionEvent arg1) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onDoubleTapEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
