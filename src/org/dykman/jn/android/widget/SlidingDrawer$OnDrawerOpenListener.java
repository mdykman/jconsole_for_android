package org.dykman.jn.android.widget;
public class SlidingDrawer$OnDrawerOpenListener implements android.widget.SlidingDrawer.OnDrawerOpenListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public SlidingDrawer$OnDrawerOpenListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onDrawerOpened(){ jInterface.Jnido( this, jchildidx + "onDrawerOpened_" + jlocale + "_", null ); }
}
