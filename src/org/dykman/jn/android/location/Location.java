package org.dykman.jn.android.location;
public class Location extends android.location.Location{
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
public Location(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Location(android.location.Location arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public void set(android.location.Location arg1) { if (!testjnOverride( "set" )) { super.set( arg1); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void reset(){ if (!testjnOverride( "reset" )) { super.reset(); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", null ); }
@Override public java.lang.String getProvider(){ if (!testjnOverride( "getProvider" )) return super.getProvider(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getProvider_" + jlocale + "_", null ); }
@Override public long getTime(){ if (!testjnOverride( "getTime" )) return super.getTime(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getTime_" + jlocale + "_", null ); }
@Override public void setTime(long arg1) { if (!testjnOverride( "setTime" )) { super.setTime( arg1); return; } jInterface.Jnido( this, jchildidx + "setTime_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void dump(android.util.Printer arg1,java.lang.String arg2) { if (!testjnOverride( "dump" )) { super.dump( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "dump_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public float distanceTo(android.location.Location arg1) { if (!testjnOverride( "distanceTo" )) return super.distanceTo( arg1); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "distanceTo_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float bearingTo(android.location.Location arg1) { if (!testjnOverride( "bearingTo" )) return super.bearingTo( arg1); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "bearingTo_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setProvider(java.lang.String arg1) { if (!testjnOverride( "setProvider" )) { super.setProvider( arg1); return; } jInterface.Jnido( this, jchildidx + "setProvider_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public double getLatitude(){ if (!testjnOverride( "getLatitude" )) return super.getLatitude(); return (java.lang.Double) jInterface.Jnido( this, jchildidx + "getLatitude_" + jlocale + "_", null ); }
@Override public void setLatitude(double arg1) { if (!testjnOverride( "setLatitude" )) { super.setLatitude( arg1); return; } jInterface.Jnido( this, jchildidx + "setLatitude_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public double getLongitude(){ if (!testjnOverride( "getLongitude" )) return super.getLongitude(); return (java.lang.Double) jInterface.Jnido( this, jchildidx + "getLongitude_" + jlocale + "_", null ); }
@Override public void setLongitude(double arg1) { if (!testjnOverride( "setLongitude" )) { super.setLongitude( arg1); return; } jInterface.Jnido( this, jchildidx + "setLongitude_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean hasAltitude(){ if (!testjnOverride( "hasAltitude" )) return super.hasAltitude(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasAltitude_" + jlocale + "_", null ); }
@Override public double getAltitude(){ if (!testjnOverride( "getAltitude" )) return super.getAltitude(); return (java.lang.Double) jInterface.Jnido( this, jchildidx + "getAltitude_" + jlocale + "_", null ); }
@Override public void setAltitude(double arg1) { if (!testjnOverride( "setAltitude" )) { super.setAltitude( arg1); return; } jInterface.Jnido( this, jchildidx + "setAltitude_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeAltitude(){ if (!testjnOverride( "removeAltitude" )) { super.removeAltitude(); return; } jInterface.Jnido( this, jchildidx + "removeAltitude_" + jlocale + "_", null ); }
@Override public boolean hasSpeed(){ if (!testjnOverride( "hasSpeed" )) return super.hasSpeed(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasSpeed_" + jlocale + "_", null ); }
@Override public float getSpeed(){ if (!testjnOverride( "getSpeed" )) return super.getSpeed(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getSpeed_" + jlocale + "_", null ); }
@Override public void setSpeed(float arg1) { if (!testjnOverride( "setSpeed" )) { super.setSpeed( arg1); return; } jInterface.Jnido( this, jchildidx + "setSpeed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeSpeed(){ if (!testjnOverride( "removeSpeed" )) { super.removeSpeed(); return; } jInterface.Jnido( this, jchildidx + "removeSpeed_" + jlocale + "_", null ); }
@Override public boolean hasBearing(){ if (!testjnOverride( "hasBearing" )) return super.hasBearing(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasBearing_" + jlocale + "_", null ); }
@Override public float getBearing(){ if (!testjnOverride( "getBearing" )) return super.getBearing(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getBearing_" + jlocale + "_", null ); }
@Override public void setBearing(float arg1) { if (!testjnOverride( "setBearing" )) { super.setBearing( arg1); return; } jInterface.Jnido( this, jchildidx + "setBearing_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeBearing(){ if (!testjnOverride( "removeBearing" )) { super.removeBearing(); return; } jInterface.Jnido( this, jchildidx + "removeBearing_" + jlocale + "_", null ); }
@Override public boolean hasAccuracy(){ if (!testjnOverride( "hasAccuracy" )) return super.hasAccuracy(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasAccuracy_" + jlocale + "_", null ); }
@Override public float getAccuracy(){ if (!testjnOverride( "getAccuracy" )) return super.getAccuracy(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getAccuracy_" + jlocale + "_", null ); }
@Override public void setAccuracy(float arg1) { if (!testjnOverride( "setAccuracy" )) { super.setAccuracy( arg1); return; } jInterface.Jnido( this, jchildidx + "setAccuracy_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeAccuracy(){ if (!testjnOverride( "removeAccuracy" )) { super.removeAccuracy(); return; } jInterface.Jnido( this, jchildidx + "removeAccuracy_" + jlocale + "_", null ); }
@Override public android.os.Bundle getExtras(){ if (!testjnOverride( "getExtras" )) return super.getExtras(); return (android.os.Bundle) jInterface.Jnido( this, jchildidx + "getExtras_" + jlocale + "_", null ); }
@Override public void setExtras(android.os.Bundle arg1) { if (!testjnOverride( "setExtras" )) { super.setExtras( arg1); return; } jInterface.Jnido( this, jchildidx + "setExtras_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
