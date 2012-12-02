package org.dykman.jn.android.media;
public class MediaScannerConnection extends android.media.MediaScannerConnection{
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
public MediaScannerConnection(android.content.Context arg1,android.media.MediaScannerConnection.MediaScannerConnectionClient arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void connect(){ if (!testjnOverride( "connect" )) { super.connect(); return; } jInterface.Jnido( this, jchildidx + "connect_" + jlocale + "_", null ); }
@Override public void disconnect(){ if (!testjnOverride( "disconnect" )) { super.disconnect(); return; } jInterface.Jnido( this, jchildidx + "disconnect_" + jlocale + "_", null ); }
@Override public synchronized boolean isConnected(){ if (!testjnOverride( "isConnected" )) return super.isConnected(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isConnected_" + jlocale + "_", null ); }
@Override public void scanFile(java.lang.String arg1,java.lang.String arg2) { if (!testjnOverride( "scanFile" )) { super.scanFile( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "scanFile_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onServiceConnected(android.content.ComponentName arg1,android.os.IBinder arg2) { if (!testjnOverride( "onServiceConnected" )) { super.onServiceConnected( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onServiceConnected_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onServiceDisconnected(android.content.ComponentName arg1) { if (!testjnOverride( "onServiceDisconnected" )) { super.onServiceDisconnected( arg1); return; } jInterface.Jnido( this, jchildidx + "onServiceDisconnected_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
