package org.dykman.jn.android.text.format;
public class Time extends android.text.format.Time{
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
public Time(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Time(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public Time(android.text.format.Time arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public void clear(java.lang.String arg1) { if (!testjnOverride( "clear" )) { super.clear( arg1); return; } jInterface.Jnido( this, jchildidx + "clear_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String format(java.lang.String arg1) { if (!testjnOverride( "format" )) return super.format( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "format_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void set(long arg1) { if (!testjnOverride( "set" )) { super.set( arg1); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void set(android.text.format.Time arg1) { if (!testjnOverride( "set" )) { super.set( arg1); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void set(int arg1,int arg2,int arg3,int arg4,int arg5,int arg6) { if (!testjnOverride( "set" )) { super.set( arg1, arg2, arg3, arg4, arg5, arg6); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public void set(int arg1,int arg2,int arg3) { if (!testjnOverride( "set" )) { super.set( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public long normalize(boolean arg1) { if (!testjnOverride( "normalize" )) return super.normalize( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "normalize_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean after(android.text.format.Time arg1) { if (!testjnOverride( "after" )) return super.after( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "after_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean before(android.text.format.Time arg1) { if (!testjnOverride( "before" )) return super.before( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "before_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean parse(java.lang.String arg1) { if (!testjnOverride( "parse" )) return super.parse( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "parse_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void switchTimezone(java.lang.String arg1) { if (!testjnOverride( "switchTimezone" )) { super.switchTimezone( arg1); return; } jInterface.Jnido( this, jchildidx + "switchTimezone_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getActualMaximum(int arg1) { if (!testjnOverride( "getActualMaximum" )) return super.getActualMaximum( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getActualMaximum_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean parse3339(java.lang.String arg1) { if (!testjnOverride( "parse3339" )) return super.parse3339( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "parse3339_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setToNow(){ if (!testjnOverride( "setToNow" )) { super.setToNow(); return; } jInterface.Jnido( this, jchildidx + "setToNow_" + jlocale + "_", null ); }
@Override public long toMillis(boolean arg1) { if (!testjnOverride( "toMillis" )) return super.toMillis( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "toMillis_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String format2445(){ if (!testjnOverride( "format2445" )) return super.format2445(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "format2445_" + jlocale + "_", null ); }
@Override public int getWeekNumber(){ if (!testjnOverride( "getWeekNumber" )) return super.getWeekNumber(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getWeekNumber_" + jlocale + "_", null ); }
@Override public java.lang.String format3339(boolean arg1) { if (!testjnOverride( "format3339" )) return super.format3339( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "format3339_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long setJulianDay(int arg1) { if (!testjnOverride( "setJulianDay" )) return super.setJulianDay( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "setJulianDay_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
