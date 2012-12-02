package org.dykman.jn.android.widget;
public class AbsListView$OnScrollListener implements android.widget.AbsListView.OnScrollListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public AbsListView$OnScrollListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onScrollStateChanged(android.widget.AbsListView arg1,int arg2) { jInterface.Jnido( this, jchildidx + "onScrollStateChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onScroll(android.widget.AbsListView arg1,int arg2,int arg3,int arg4) { jInterface.Jnido( this, jchildidx + "onScroll_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
}
