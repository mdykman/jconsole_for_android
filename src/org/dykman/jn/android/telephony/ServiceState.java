package org.dykman.jn.android.telephony;
public class ServiceState extends android.telephony.ServiceState{
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
public ServiceState(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public ServiceState(android.telephony.ServiceState arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ServiceState(android.os.Parcel arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean equals(java.lang.Object arg1) { if (!testjnOverride( "equals" )) return super.equals( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "equals_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public int hashCode(){ if (!testjnOverride( "hashCode" )) return super.hashCode(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "hashCode_" + jlocale + "_", null ); }
@Override public int getState(){ if (!testjnOverride( "getState" )) return super.getState(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getState_" + jlocale + "_", null ); }
@Override public void setState(int arg1) { if (!testjnOverride( "setState" )) { super.setState( arg1); return; } jInterface.Jnido( this, jchildidx + "setState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void copyFrom(android.telephony.ServiceState arg1) { if (!testjnOverride( "copyFrom" )) { super.copyFrom( arg1); return; } jInterface.Jnido( this, jchildidx + "copyFrom_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
@Override public boolean getRoaming(){ if (!testjnOverride( "getRoaming" )) return super.getRoaming(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getRoaming_" + jlocale + "_", null ); }
@Override public java.lang.String getOperatorAlphaLong(){ if (!testjnOverride( "getOperatorAlphaLong" )) return super.getOperatorAlphaLong(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getOperatorAlphaLong_" + jlocale + "_", null ); }
@Override public java.lang.String getOperatorAlphaShort(){ if (!testjnOverride( "getOperatorAlphaShort" )) return super.getOperatorAlphaShort(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getOperatorAlphaShort_" + jlocale + "_", null ); }
@Override public java.lang.String getOperatorNumeric(){ if (!testjnOverride( "getOperatorNumeric" )) return super.getOperatorNumeric(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getOperatorNumeric_" + jlocale + "_", null ); }
@Override public boolean getIsManualSelection(){ if (!testjnOverride( "getIsManualSelection" )) return super.getIsManualSelection(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getIsManualSelection_" + jlocale + "_", null ); }
@Override public void setStateOutOfService(){ if (!testjnOverride( "setStateOutOfService" )) { super.setStateOutOfService(); return; } jInterface.Jnido( this, jchildidx + "setStateOutOfService_" + jlocale + "_", null ); }
@Override public void setStateOff(){ if (!testjnOverride( "setStateOff" )) { super.setStateOff(); return; } jInterface.Jnido( this, jchildidx + "setStateOff_" + jlocale + "_", null ); }
@Override public void setRoaming(boolean arg1) { if (!testjnOverride( "setRoaming" )) { super.setRoaming( arg1); return; } jInterface.Jnido( this, jchildidx + "setRoaming_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOperatorName(java.lang.String arg1,java.lang.String arg2,java.lang.String arg3) { if (!testjnOverride( "setOperatorName" )) { super.setOperatorName( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "setOperatorName_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setIsManualSelection(boolean arg1) { if (!testjnOverride( "setIsManualSelection" )) { super.setIsManualSelection( arg1); return; } jInterface.Jnido( this, jchildidx + "setIsManualSelection_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
