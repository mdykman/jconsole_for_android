package org.dykman.jn.android.widget;
public class ExpandableListView$OnChildClickListener2 implements android.widget.ExpandableListView.OnChildClickListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public ExpandableListView$OnChildClickListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onChildClick(android.widget.ExpandableListView arg1,android.view.View arg2,int arg3,int arg4,long arg5) { return (java.lang.Boolean) jInterface.Jnido( this, "onChildClick_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
}
