package org.dykman.jn.android.widget;
public class SlidingDrawer$OnDrawerScrollListener implements android.widget.SlidingDrawer.OnDrawerScrollListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public SlidingDrawer$OnDrawerScrollListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onScrollStarted(){ jInterface.Jnido( this, jchildidx + "onScrollStarted_" + jlocale + "_", null ); }
@Override public void onScrollEnded(){ jInterface.Jnido( this, jchildidx + "onScrollEnded_" + jlocale + "_", null ); }
}
