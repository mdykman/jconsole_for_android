package org.dykman.jn.android.widget;
public class TextView$OnEditorActionListener2 implements android.widget.TextView.OnEditorActionListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public TextView$OnEditorActionListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onEditorAction(android.widget.TextView arg1,int arg2,android.view.KeyEvent arg3) { return (java.lang.Boolean) jInterface.Jnido( this, "onEditorAction_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
