package org.dykman.jn.android.view;
public class GestureDetector$OnGestureListener implements android.view.GestureDetector.OnGestureListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GestureDetector$OnGestureListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onDown(android.view.MotionEvent arg1) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onDown_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onShowPress(android.view.MotionEvent arg1) { jInterface.Jnido( this, jchildidx + "onShowPress_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onSingleTapUp(android.view.MotionEvent arg1) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onSingleTapUp_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onScroll(android.view.MotionEvent arg1,android.view.MotionEvent arg2,float arg3,float arg4) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onScroll_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void onLongPress(android.view.MotionEvent arg1) { jInterface.Jnido( this, jchildidx + "onLongPress_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onFling(android.view.MotionEvent arg1,android.view.MotionEvent arg2,float arg3,float arg4) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onFling_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
}
