package org.dykman.jn.android.location;
public class Criteria extends android.location.Criteria{
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
public Criteria(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public Criteria(android.location.Criteria arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAccuracy(int arg1) { if (!testjnOverride( "setAccuracy" )) { super.setAccuracy( arg1); return; } jInterface.Jnido( this, jchildidx + "setAccuracy_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getAccuracy(){ if (!testjnOverride( "getAccuracy" )) return super.getAccuracy(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getAccuracy_" + jlocale + "_", null ); }
@Override public void setPowerRequirement(int arg1) { if (!testjnOverride( "setPowerRequirement" )) { super.setPowerRequirement( arg1); return; } jInterface.Jnido( this, jchildidx + "setPowerRequirement_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getPowerRequirement(){ if (!testjnOverride( "getPowerRequirement" )) return super.getPowerRequirement(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getPowerRequirement_" + jlocale + "_", null ); }
@Override public void setCostAllowed(boolean arg1) { if (!testjnOverride( "setCostAllowed" )) { super.setCostAllowed( arg1); return; } jInterface.Jnido( this, jchildidx + "setCostAllowed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isCostAllowed(){ if (!testjnOverride( "isCostAllowed" )) return super.isCostAllowed(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isCostAllowed_" + jlocale + "_", null ); }
@Override public void setAltitudeRequired(boolean arg1) { if (!testjnOverride( "setAltitudeRequired" )) { super.setAltitudeRequired( arg1); return; } jInterface.Jnido( this, jchildidx + "setAltitudeRequired_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isAltitudeRequired(){ if (!testjnOverride( "isAltitudeRequired" )) return super.isAltitudeRequired(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isAltitudeRequired_" + jlocale + "_", null ); }
@Override public void setSpeedRequired(boolean arg1) { if (!testjnOverride( "setSpeedRequired" )) { super.setSpeedRequired( arg1); return; } jInterface.Jnido( this, jchildidx + "setSpeedRequired_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isSpeedRequired(){ if (!testjnOverride( "isSpeedRequired" )) return super.isSpeedRequired(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isSpeedRequired_" + jlocale + "_", null ); }
@Override public void setBearingRequired(boolean arg1) { if (!testjnOverride( "setBearingRequired" )) { super.setBearingRequired( arg1); return; } jInterface.Jnido( this, jchildidx + "setBearingRequired_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isBearingRequired(){ if (!testjnOverride( "isBearingRequired" )) return super.isBearingRequired(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isBearingRequired_" + jlocale + "_", null ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
