package org.dykman.jn.android.view;
public class View$OnTouchListener2 implements android.view.View.OnTouchListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public View$OnTouchListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onTouch(android.view.View arg1,android.view.MotionEvent arg2) { return (java.lang.Boolean) jInterface.Jnido( this, "onTouch_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
