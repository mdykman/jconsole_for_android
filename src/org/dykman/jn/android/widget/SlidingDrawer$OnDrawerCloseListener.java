package org.dykman.jn.android.widget;
public class SlidingDrawer$OnDrawerCloseListener implements android.widget.SlidingDrawer.OnDrawerCloseListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public SlidingDrawer$OnDrawerCloseListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onDrawerClosed(){ jInterface.Jnido( this, jchildidx + "onDrawerClosed_" + jlocale + "_", null ); }
}
