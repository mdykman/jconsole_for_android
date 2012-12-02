package org.dykman.jn.android.net;
public class LocalServerSocket extends android.net.LocalServerSocket{
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
public LocalServerSocket(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) throws java.io.IOException{ super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public LocalServerSocket(java.io.FileDescriptor arg1, java.lang.String jlocale,String jchildid,String joverride ) throws java.io.IOException{ super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void close() throws java.io.IOException{ if (!testjnOverride( "close" )) { super.close(); return; } jInterface.Jnido( this, jchildidx + "close_" + jlocale + "_", null ); }
@Override public android.net.LocalSocket accept() throws java.io.IOException{ if (!testjnOverride( "accept" )) return super.accept(); return (android.net.LocalSocket) jInterface.Jnido( this, jchildidx + "accept_" + jlocale + "_", null ); }
@Override public android.net.LocalSocketAddress getLocalSocketAddress(){ if (!testjnOverride( "getLocalSocketAddress" )) return super.getLocalSocketAddress(); return (android.net.LocalSocketAddress) jInterface.Jnido( this, jchildidx + "getLocalSocketAddress_" + jlocale + "_", null ); }
@Override public java.io.FileDescriptor getFileDescriptor(){ if (!testjnOverride( "getFileDescriptor" )) return super.getFileDescriptor(); return (java.io.FileDescriptor) jInterface.Jnido( this, jchildidx + "getFileDescriptor_" + jlocale + "_", null ); }
}
