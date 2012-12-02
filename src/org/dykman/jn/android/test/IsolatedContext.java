package org.dykman.jn.android.test;
public class IsolatedContext extends android.test.IsolatedContext{
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
public IsolatedContext(android.content.ContentResolver arg1,android.content.Context arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.util.List getAndClearBroadcastIntents(){ if (!testjnOverride( "getAndClearBroadcastIntents" )) return super.getAndClearBroadcastIntents(); return (java.util.List) jInterface.Jnido( this, jchildidx + "getAndClearBroadcastIntents_" + jlocale + "_", null ); }
@Override public android.content.ContentResolver getContentResolver(){ if (!testjnOverride( "getContentResolver" )) return super.getContentResolver(); return (android.content.ContentResolver) jInterface.Jnido( this, jchildidx + "getContentResolver_" + jlocale + "_", null ); }
@Override public boolean bindService(android.content.Intent arg1,android.content.ServiceConnection arg2,int arg3) { if (!testjnOverride( "bindService" )) return super.bindService( arg1, arg2, arg3); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "bindService_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public android.content.Intent registerReceiver(android.content.BroadcastReceiver arg1,android.content.IntentFilter arg2) { if (!testjnOverride( "registerReceiver" )) return super.registerReceiver( arg1, arg2); return (android.content.Intent) jInterface.Jnido( this, jchildidx + "registerReceiver_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void sendBroadcast(android.content.Intent arg1) { if (!testjnOverride( "sendBroadcast" )) { super.sendBroadcast( arg1); return; } jInterface.Jnido( this, jchildidx + "sendBroadcast_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void sendOrderedBroadcast(android.content.Intent arg1,java.lang.String arg2) { if (!testjnOverride( "sendOrderedBroadcast" )) { super.sendOrderedBroadcast( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "sendOrderedBroadcast_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int checkUriPermission(android.net.Uri arg1,java.lang.String arg2,java.lang.String arg3,int arg4,int arg5,int arg6) { if (!testjnOverride( "checkUriPermission" )) return super.checkUriPermission( arg1, arg2, arg3, arg4, arg5, arg6); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "checkUriPermission_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public int checkUriPermission(android.net.Uri arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "checkUriPermission" )) return super.checkUriPermission( arg1, arg2, arg3, arg4); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "checkUriPermission_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public java.lang.Object getSystemService(java.lang.String arg1) { if (!testjnOverride( "getSystemService" )) return super.getSystemService( arg1); return (java.lang.Object) jInterface.Jnido( this, jchildidx + "getSystemService_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.io.File getFilesDir(){ if (!testjnOverride( "getFilesDir" )) return super.getFilesDir(); return (java.io.File) jInterface.Jnido( this, jchildidx + "getFilesDir_" + jlocale + "_", null ); }
}
