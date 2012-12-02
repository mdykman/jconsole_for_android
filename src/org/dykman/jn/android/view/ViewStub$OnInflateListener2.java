package org.dykman.jn.android.view;
public class ViewStub$OnInflateListener2 implements android.view.ViewStub.OnInflateListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public ViewStub$OnInflateListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onInflate(android.view.ViewStub arg1,android.view.View arg2) { jInterface.Jnido( this, "onInflate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
