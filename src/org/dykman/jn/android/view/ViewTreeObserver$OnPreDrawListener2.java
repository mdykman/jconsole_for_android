package org.dykman.jn.android.view;
public class ViewTreeObserver$OnPreDrawListener2 implements android.view.ViewTreeObserver.OnPreDrawListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public ViewTreeObserver$OnPreDrawListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onPreDraw(){ return (java.lang.Boolean) jInterface.Jnido( this, "onPreDraw_" + jlocale + "_", null ); }
}
