package org.dykman.jn.android.os;
public class StatFs extends android.os.StatFs{
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
public StatFs(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void finalize(){ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void restat(java.lang.String arg1) { if (!testjnOverride( "restat" )) { super.restat( arg1); return; } jInterface.Jnido( this, jchildidx + "restat_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getBlockSize(){ if (!testjnOverride( "getBlockSize" )) return super.getBlockSize(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBlockSize_" + jlocale + "_", null ); }
@Override public int getBlockCount(){ if (!testjnOverride( "getBlockCount" )) return super.getBlockCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBlockCount_" + jlocale + "_", null ); }
@Override public int getFreeBlocks(){ if (!testjnOverride( "getFreeBlocks" )) return super.getFreeBlocks(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getFreeBlocks_" + jlocale + "_", null ); }
@Override public int getAvailableBlocks(){ if (!testjnOverride( "getAvailableBlocks" )) return super.getAvailableBlocks(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getAvailableBlocks_" + jlocale + "_", null ); }
}
