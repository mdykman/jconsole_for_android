package org.dykman.jn.android.telephony.cdma;
public class CdmaCellLocation extends android.telephony.cdma.CdmaCellLocation{
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
public CdmaCellLocation(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public CdmaCellLocation(android.os.Bundle arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean equals(java.lang.Object arg1) { if (!testjnOverride( "equals" )) return super.equals( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "equals_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public int hashCode(){ if (!testjnOverride( "hashCode" )) return super.hashCode(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "hashCode_" + jlocale + "_", null ); }
@Override public int getBaseStationId(){ if (!testjnOverride( "getBaseStationId" )) return super.getBaseStationId(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBaseStationId_" + jlocale + "_", null ); }
@Override public int getBaseStationLatitude(){ if (!testjnOverride( "getBaseStationLatitude" )) return super.getBaseStationLatitude(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBaseStationLatitude_" + jlocale + "_", null ); }
@Override public int getBaseStationLongitude(){ if (!testjnOverride( "getBaseStationLongitude" )) return super.getBaseStationLongitude(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBaseStationLongitude_" + jlocale + "_", null ); }
@Override public int getSystemId(){ if (!testjnOverride( "getSystemId" )) return super.getSystemId(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getSystemId_" + jlocale + "_", null ); }
@Override public int getNetworkId(){ if (!testjnOverride( "getNetworkId" )) return super.getNetworkId(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getNetworkId_" + jlocale + "_", null ); }
@Override public void setStateInvalid(){ if (!testjnOverride( "setStateInvalid" )) { super.setStateInvalid(); return; } jInterface.Jnido( this, jchildidx + "setStateInvalid_" + jlocale + "_", null ); }
@Override public void setCellLocationData(int arg1,int arg2,int arg3) { if (!testjnOverride( "setCellLocationData" )) { super.setCellLocationData( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "setCellLocationData_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setCellLocationData(int arg1,int arg2,int arg3,int arg4,int arg5) { if (!testjnOverride( "setCellLocationData" )) { super.setCellLocationData( arg1, arg2, arg3, arg4, arg5); return; } jInterface.Jnido( this, jchildidx + "setCellLocationData_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public void fillInNotifierBundle(android.os.Bundle arg1) { if (!testjnOverride( "fillInNotifierBundle" )) { super.fillInNotifierBundle( arg1); return; } jInterface.Jnido( this, jchildidx + "fillInNotifierBundle_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
