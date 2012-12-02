package org.dykman.jn.android.os;
public class HandlerThread extends android.os.HandlerThread{
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
public HandlerThread(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public HandlerThread(java.lang.String arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void run(){ if (!testjnOverride( "run" )) { super.run(); return; } jInterface.Jnido( this, jchildidx + "run_" + jlocale + "_", null ); }
@Override protected void onLooperPrepared(){ if (!testjnOverride( "onLooperPrepared" )) { super.onLooperPrepared(); return; } jInterface.Jnido( this, jchildidx + "onLooperPrepared_" + jlocale + "_", null ); }
@Override public android.os.Looper getLooper(){ if (!testjnOverride( "getLooper" )) return super.getLooper(); return (android.os.Looper) jInterface.Jnido( this, jchildidx + "getLooper_" + jlocale + "_", null ); }
@Override public boolean quit(){ if (!testjnOverride( "quit" )) return super.quit(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "quit_" + jlocale + "_", null ); }
@Override public int getThreadId(){ if (!testjnOverride( "getThreadId" )) return super.getThreadId(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getThreadId_" + jlocale + "_", null ); }
}
