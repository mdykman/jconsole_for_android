package org.dykman.jn.android.app;
public class TimePickerDialog extends android.app.TimePickerDialog{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected java.util.ArrayList jnOverrideList = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid, java.lang.String joverride ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; if (joverride != null && joverride.length() > 0) { java.lang.String[] ss = joverride.split(" "); for (int i = 0; i < ss.length; i++) setjnOverride(ss[i]); } }
public void clearjnOverride () { jnOverrideList.clear (); }
public void setjnOverride (java.lang.String arg1 ) { if (!testjnOverride (arg1)) jnOverrideList.add (arg1); }
public void setjnOverride (java.lang.String arg1, boolean arg2 ) { if (arg2) { if (!testjnOverride (arg1)) jnOverrideList.add (arg1); } else jnOverrideList.remove (arg1); }
public boolean testjnOverride (java.lang.String arg1 ) { return jnOverrideList.contains (arg1); }
public TimePickerDialog(android.content.Context arg1,android.app.TimePickerDialog.OnTimeSetListener arg2,int arg3,int arg4,boolean arg5, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4, arg5); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
public TimePickerDialog(android.content.Context arg1,int arg2,android.app.TimePickerDialog.OnTimeSetListener arg3,int arg4,int arg5,boolean arg6, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4, arg5, arg6); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public void onClick(android.content.DialogInterface arg1,int arg2) { if (!testjnOverride( "onClick" )) { super.onClick( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onClick_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onTimeChanged(android.widget.TimePicker arg1,int arg2,int arg3) { if (!testjnOverride( "onTimeChanged" )) { super.onTimeChanged( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "onTimeChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void updateTime(int arg1,int arg2) { if (!testjnOverride( "updateTime" )) { super.updateTime( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "updateTime_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.os.Bundle onSaveInstanceState(){ if (!testjnOverride( "onSaveInstanceState" )) return super.onSaveInstanceState(); return (android.os.Bundle) jInterface.Jnido( this, jchildidx + "onSaveInstanceState_" + jlocale + "_", null ); }
@Override public void onRestoreInstanceState(android.os.Bundle arg1) { if (!testjnOverride( "onRestoreInstanceState" )) { super.onRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "onRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
