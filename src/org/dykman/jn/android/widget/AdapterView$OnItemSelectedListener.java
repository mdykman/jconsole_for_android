package org.dykman.jn.android.widget;
public class AdapterView$OnItemSelectedListener implements android.widget.AdapterView.OnItemSelectedListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public AdapterView$OnItemSelectedListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onItemSelected(android.widget.AdapterView arg1,android.view.View arg2,int arg3,long arg4) { jInterface.Jnido( this, jchildidx + "onItemSelected_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void onNothingSelected(android.widget.AdapterView arg1) { jInterface.Jnido( this, jchildidx + "onNothingSelected_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
