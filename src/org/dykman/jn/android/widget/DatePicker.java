package org.dykman.jn.android.widget;
public class DatePicker extends android.widget.DatePicker{
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
public DatePicker(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public DatePicker(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public DatePicker(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void init(int arg1,int arg2,int arg3,android.widget.DatePicker.OnDateChangedListener arg4) { if (!testjnOverride( "init" )) { super.init( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "init_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public int getMonth(){ if (!testjnOverride( "getMonth" )) return super.getMonth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getMonth_" + jlocale + "_", null ); }
@Override public int getYear(){ if (!testjnOverride( "getYear" )) return super.getYear(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getYear_" + jlocale + "_", null ); }
@Override public void setEnabled(boolean arg1) { if (!testjnOverride( "setEnabled" )) { super.setEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void updateDate(int arg1,int arg2,int arg3) { if (!testjnOverride( "updateDate" )) { super.updateDate( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "updateDate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override protected void dispatchRestoreInstanceState(android.util.SparseArray arg1) { if (!testjnOverride( "dispatchRestoreInstanceState" )) { super.dispatchRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected android.os.Parcelable onSaveInstanceState(){ if (!testjnOverride( "onSaveInstanceState" )) return super.onSaveInstanceState(); return (android.os.Parcelable) jInterface.Jnido( this, jchildidx + "onSaveInstanceState_" + jlocale + "_", null ); }
@Override protected void onRestoreInstanceState(android.os.Parcelable arg1) { if (!testjnOverride( "onRestoreInstanceState" )) { super.onRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "onRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDayOfMonth(){ if (!testjnOverride( "getDayOfMonth" )) return super.getDayOfMonth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDayOfMonth_" + jlocale + "_", null ); }
}
