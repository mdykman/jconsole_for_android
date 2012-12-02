package org.dykman.jn.android.telephony;
public class NeighboringCellInfo extends android.telephony.NeighboringCellInfo{
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
public NeighboringCellInfo(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public NeighboringCellInfo(int arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public NeighboringCellInfo(int arg1,java.lang.String arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public NeighboringCellInfo(android.os.Parcel arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public int getRssi(){ if (!testjnOverride( "getRssi" )) return super.getRssi(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getRssi_" + jlocale + "_", null ); }
@Override public int getLac(){ if (!testjnOverride( "getLac" )) return super.getLac(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getLac_" + jlocale + "_", null ); }
@Override public int getCid(){ if (!testjnOverride( "getCid" )) return super.getCid(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCid_" + jlocale + "_", null ); }
@Override public int getPsc(){ if (!testjnOverride( "getPsc" )) return super.getPsc(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getPsc_" + jlocale + "_", null ); }
@Override public int getNetworkType(){ if (!testjnOverride( "getNetworkType" )) return super.getNetworkType(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getNetworkType_" + jlocale + "_", null ); }
@Override public void setCid(int arg1) { if (!testjnOverride( "setCid" )) { super.setCid( arg1); return; } jInterface.Jnido( this, jchildidx + "setCid_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setRssi(int arg1) { if (!testjnOverride( "setRssi" )) { super.setRssi( arg1); return; } jInterface.Jnido( this, jchildidx + "setRssi_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
