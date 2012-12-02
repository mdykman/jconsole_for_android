package org.dykman.jn.android.widget;
public class ExpandableListView$OnGroupClickListener2 implements android.widget.ExpandableListView.OnGroupClickListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public ExpandableListView$OnGroupClickListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onGroupClick(android.widget.ExpandableListView arg1,android.view.View arg2,int arg3,long arg4) { return (java.lang.Boolean) jInterface.Jnido( this, "onGroupClick_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
}
