package org.dykman.jn.android.widget;
public class AdapterView$OnItemClickListener2 implements android.widget.AdapterView.OnItemClickListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public AdapterView$OnItemClickListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onItemClick(android.widget.AdapterView arg1,android.view.View arg2,int arg3,long arg4) { jInterface.Jnido( this, "onItemClick_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
}
