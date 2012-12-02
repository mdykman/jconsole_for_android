package org.dykman.jn.android.app;
public class DatePickerDialog$OnDateSetListener2 implements android.app.DatePickerDialog.OnDateSetListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public DatePickerDialog$OnDateSetListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onDateSet(android.widget.DatePicker arg1,int arg2,int arg3,int arg4) { jInterface.Jnido( this, "onDateSet_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
}
