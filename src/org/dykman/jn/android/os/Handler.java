package org.dykman.jn.android.os;
public class Handler extends android.os.Handler{
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
public Handler(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public Handler(android.os.Handler.Callback arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Handler(android.os.Looper arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Handler(android.os.Looper arg1,android.os.Handler.Callback arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public void handleMessage(android.os.Message arg1) { if (!testjnOverride( "handleMessage" )) { super.handleMessage( arg1); return; } jInterface.Jnido( this, jchildidx + "handleMessage_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void dispatchMessage(android.os.Message arg1) { if (!testjnOverride( "dispatchMessage" )) { super.dispatchMessage( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchMessage_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean sendMessageAtTime(android.os.Message arg1,long arg2) { if (!testjnOverride( "sendMessageAtTime" )) return super.sendMessageAtTime( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "sendMessageAtTime_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
