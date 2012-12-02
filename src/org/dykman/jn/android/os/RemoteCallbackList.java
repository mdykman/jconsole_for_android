package org.dykman.jn.android.os;
public class RemoteCallbackList extends android.os.RemoteCallbackList{
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
public RemoteCallbackList(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public boolean register(android.os.IInterface arg1) { if (!testjnOverride( "register" )) return super.register( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "register_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean register(android.os.IInterface arg1,java.lang.Object arg2) { if (!testjnOverride( "register" )) return super.register( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "register_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean unregister(android.os.IInterface arg1) { if (!testjnOverride( "unregister" )) return super.unregister( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "unregister_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void kill(){ if (!testjnOverride( "kill" )) { super.kill(); return; } jInterface.Jnido( this, jchildidx + "kill_" + jlocale + "_", null ); }
@Override public void onCallbackDied(android.os.IInterface arg1) { if (!testjnOverride( "onCallbackDied" )) { super.onCallbackDied( arg1); return; } jInterface.Jnido( this, jchildidx + "onCallbackDied_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onCallbackDied(android.os.IInterface arg1,java.lang.Object arg2) { if (!testjnOverride( "onCallbackDied" )) { super.onCallbackDied( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onCallbackDied_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int beginBroadcast(){ if (!testjnOverride( "beginBroadcast" )) return super.beginBroadcast(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "beginBroadcast_" + jlocale + "_", null ); }
@Override public android.os.IInterface getBroadcastItem(int arg1) { if (!testjnOverride( "getBroadcastItem" )) return super.getBroadcastItem( arg1); return (android.os.IInterface) jInterface.Jnido( this, jchildidx + "getBroadcastItem_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.Object getBroadcastCookie(int arg1) { if (!testjnOverride( "getBroadcastCookie" )) return super.getBroadcastCookie( arg1); return (java.lang.Object) jInterface.Jnido( this, jchildidx + "getBroadcastCookie_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void finishBroadcast(){ if (!testjnOverride( "finishBroadcast" )) { super.finishBroadcast(); return; } jInterface.Jnido( this, jchildidx + "finishBroadcast_" + jlocale + "_", null ); }
}
