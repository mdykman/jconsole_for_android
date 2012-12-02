package org.dykman.jn.android.widget;
public class RadioGroup$OnCheckedChangeListener implements android.widget.RadioGroup.OnCheckedChangeListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public RadioGroup$OnCheckedChangeListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onCheckedChanged(android.widget.RadioGroup arg1,int arg2) { jInterface.Jnido( this, jchildidx + "onCheckedChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
