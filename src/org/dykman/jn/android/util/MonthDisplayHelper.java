package org.dykman.jn.android.util;
public class MonthDisplayHelper extends android.util.MonthDisplayHelper{
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
public MonthDisplayHelper(int arg1,int arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public MonthDisplayHelper(int arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getOffset(){ if (!testjnOverride( "getOffset" )) return super.getOffset(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getOffset_" + jlocale + "_", null ); }
@Override public int getMonth(){ if (!testjnOverride( "getMonth" )) return super.getMonth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getMonth_" + jlocale + "_", null ); }
@Override public int getYear(){ if (!testjnOverride( "getYear" )) return super.getYear(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getYear_" + jlocale + "_", null ); }
@Override public int getWeekStartDay(){ if (!testjnOverride( "getWeekStartDay" )) return super.getWeekStartDay(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getWeekStartDay_" + jlocale + "_", null ); }
@Override public int getFirstDayOfMonth(){ if (!testjnOverride( "getFirstDayOfMonth" )) return super.getFirstDayOfMonth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getFirstDayOfMonth_" + jlocale + "_", null ); }
@Override public int getNumberOfDaysInMonth(){ if (!testjnOverride( "getNumberOfDaysInMonth" )) return super.getNumberOfDaysInMonth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getNumberOfDaysInMonth_" + jlocale + "_", null ); }
@Override public int[] getDigitsForRow(int arg1) { if (!testjnOverride( "getDigitsForRow" )) return super.getDigitsForRow( arg1); return (int[]) jInterface.Jnidoi( this, jchildidx + "getDigitsForRow_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDayAt(int arg1,int arg2) { if (!testjnOverride( "getDayAt" )) return super.getDayAt( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDayAt_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getRowOf(int arg1) { if (!testjnOverride( "getRowOf" )) return super.getRowOf( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getRowOf_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getColumnOf(int arg1) { if (!testjnOverride( "getColumnOf" )) return super.getColumnOf( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getColumnOf_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void previousMonth(){ if (!testjnOverride( "previousMonth" )) { super.previousMonth(); return; } jInterface.Jnido( this, jchildidx + "previousMonth_" + jlocale + "_", null ); }
@Override public void nextMonth(){ if (!testjnOverride( "nextMonth" )) { super.nextMonth(); return; } jInterface.Jnido( this, jchildidx + "nextMonth_" + jlocale + "_", null ); }
@Override public boolean isWithinCurrentMonth(int arg1,int arg2) { if (!testjnOverride( "isWithinCurrentMonth" )) return super.isWithinCurrentMonth( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isWithinCurrentMonth_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
