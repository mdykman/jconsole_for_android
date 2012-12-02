package org.dykman.jn.android.os;
public class Binder extends android.os.Binder{
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
public Binder(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override protected void finalize() throws java.lang.Throwable{ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void attachInterface(android.os.IInterface arg1,java.lang.String arg2) { if (!testjnOverride( "attachInterface" )) { super.attachInterface( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "attachInterface_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.lang.String getInterfaceDescriptor(){ if (!testjnOverride( "getInterfaceDescriptor" )) return super.getInterfaceDescriptor(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getInterfaceDescriptor_" + jlocale + "_", null ); }
@Override public boolean pingBinder(){ if (!testjnOverride( "pingBinder" )) return super.pingBinder(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "pingBinder_" + jlocale + "_", null ); }
@Override public boolean isBinderAlive(){ if (!testjnOverride( "isBinderAlive" )) return super.isBinderAlive(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isBinderAlive_" + jlocale + "_", null ); }
@Override public android.os.IInterface queryLocalInterface(java.lang.String arg1) { if (!testjnOverride( "queryLocalInterface" )) return super.queryLocalInterface( arg1); return (android.os.IInterface) jInterface.Jnido( this, jchildidx + "queryLocalInterface_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected boolean onTransact(int arg1,android.os.Parcel arg2,android.os.Parcel arg3,int arg4) throws android.os.RemoteException { if (!testjnOverride( "onTransact" )) return super.onTransact( arg1, arg2, arg3, arg4); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTransact_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void dump(java.io.FileDescriptor arg1,java.lang.String[] arg2) { if (!testjnOverride( "dump" )) { super.dump( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "dump_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void dump(java.io.FileDescriptor arg1,java.io.PrintWriter arg2,java.lang.String[] arg3) { if (!testjnOverride( "dump" )) { super.dump( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "dump_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void linkToDeath(android.os.IBinder.DeathRecipient arg1,int arg2) { if (!testjnOverride( "linkToDeath" )) { super.linkToDeath( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "linkToDeath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean unlinkToDeath(android.os.IBinder.DeathRecipient arg1,int arg2) { if (!testjnOverride( "unlinkToDeath" )) return super.unlinkToDeath( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "unlinkToDeath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
