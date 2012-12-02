package org.dykman.jn.android.app;
public class TimePickerDialog$OnTimeSetListener2 implements android.app.TimePickerDialog.OnTimeSetListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public TimePickerDialog$OnTimeSetListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onTimeSet(android.widget.TimePicker arg1,int arg2,int arg3) { jInterface.Jnido( this, "onTimeSet_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
