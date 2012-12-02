package org.dykman.jn.android.widget;
public class Chronometer extends android.widget.Chronometer{
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
public Chronometer(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Chronometer(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public Chronometer(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void start(){ if (!testjnOverride( "start" )) { super.start(); return; } jInterface.Jnido( this, jchildidx + "start_" + jlocale + "_", null ); }
@Override public void stop(){ if (!testjnOverride( "stop" )) { super.stop(); return; } jInterface.Jnido( this, jchildidx + "stop_" + jlocale + "_", null ); }
@Override public void setBase(long arg1) { if (!testjnOverride( "setBase" )) { super.setBase( arg1); return; } jInterface.Jnido( this, jchildidx + "setBase_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getBase(){ if (!testjnOverride( "getBase" )) return super.getBase(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getBase_" + jlocale + "_", null ); }
@Override public void setFormat(java.lang.String arg1) { if (!testjnOverride( "setFormat" )) { super.setFormat( arg1); return; } jInterface.Jnido( this, jchildidx + "setFormat_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getFormat(){ if (!testjnOverride( "getFormat" )) return super.getFormat(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getFormat_" + jlocale + "_", null ); }
@Override public void setOnChronometerTickListener(android.widget.Chronometer.OnChronometerTickListener arg1) { if (!testjnOverride( "setOnChronometerTickListener" )) { super.setOnChronometerTickListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnChronometerTickListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onDetachedFromWindow(){ if (!testjnOverride( "onDetachedFromWindow" )) { super.onDetachedFromWindow(); return; } jInterface.Jnido( this, jchildidx + "onDetachedFromWindow_" + jlocale + "_", null ); }
@Override protected void onWindowVisibilityChanged(int arg1) { if (!testjnOverride( "onWindowVisibilityChanged" )) { super.onWindowVisibilityChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onWindowVisibilityChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
