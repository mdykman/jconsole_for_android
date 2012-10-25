package org.dykman.jn.android.view;
public class View$OnFocusChangeListener implements android.view.View.OnFocusChangeListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public View$OnFocusChangeListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onFocusChange(android.view.View arg1,boolean arg2) { jInterface.Jnido( this, jchildidx + "onFocusChange_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
