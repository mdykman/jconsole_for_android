package org.dykman.jn.android.view;
public class ViewGroup$OnHierarchyChangeListener implements android.view.ViewGroup.OnHierarchyChangeListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public ViewGroup$OnHierarchyChangeListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onChildViewAdded(android.view.View arg1,android.view.View arg2) { jInterface.Jnido( this, jchildidx + "onChildViewAdded_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onChildViewRemoved(android.view.View arg1,android.view.View arg2) { jInterface.Jnido( this, jchildidx + "onChildViewRemoved_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
