package org.dykman.jn.android.widget;
public class TabHost$OnTabChangeListener2 implements android.widget.TabHost.OnTabChangeListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public TabHost$OnTabChangeListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onTabChanged(java.lang.String arg1) { jInterface.Jnido( this, "onTabChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
