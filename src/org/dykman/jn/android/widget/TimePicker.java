package org.dykman.jn.android.widget;
public class TimePicker extends android.widget.TimePicker{
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
public TimePicker(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public TimePicker(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public TimePicker(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setEnabled(boolean arg1) { if (!testjnOverride( "setEnabled" )) { super.setEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected android.os.Parcelable onSaveInstanceState(){ if (!testjnOverride( "onSaveInstanceState" )) return super.onSaveInstanceState(); return (android.os.Parcelable) jInterface.Jnido( this, jchildidx + "onSaveInstanceState_" + jlocale + "_", null ); }
@Override protected void onRestoreInstanceState(android.os.Parcelable arg1) { if (!testjnOverride( "onRestoreInstanceState" )) { super.onRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "onRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnTimeChangedListener(android.widget.TimePicker.OnTimeChangedListener arg1) { if (!testjnOverride( "setOnTimeChangedListener" )) { super.setOnTimeChangedListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnTimeChangedListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.Integer getCurrentHour(){ if (!testjnOverride( "getCurrentHour" )) return super.getCurrentHour(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCurrentHour_" + jlocale + "_", null ); }
@Override public void setCurrentHour(java.lang.Integer arg1) { if (!testjnOverride( "setCurrentHour" )) { super.setCurrentHour( arg1); return; } jInterface.Jnido( this, jchildidx + "setCurrentHour_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setIs24HourView(java.lang.Boolean arg1) { if (!testjnOverride( "setIs24HourView" )) { super.setIs24HourView( arg1); return; } jInterface.Jnido( this, jchildidx + "setIs24HourView_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean is24HourView(){ if (!testjnOverride( "is24HourView" )) return super.is24HourView(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "is24HourView_" + jlocale + "_", null ); }
@Override public java.lang.Integer getCurrentMinute(){ if (!testjnOverride( "getCurrentMinute" )) return super.getCurrentMinute(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCurrentMinute_" + jlocale + "_", null ); }
@Override public void setCurrentMinute(java.lang.Integer arg1) { if (!testjnOverride( "setCurrentMinute" )) { super.setCurrentMinute( arg1); return; } jInterface.Jnido( this, jchildidx + "setCurrentMinute_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getBaseline(){ if (!testjnOverride( "getBaseline" )) return super.getBaseline(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBaseline_" + jlocale + "_", null ); }
}
