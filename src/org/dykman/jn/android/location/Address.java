package org.dykman.jn.android.location;
public class Address extends android.location.Address{
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
public Address(java.util.Locale arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public java.util.Locale getLocale(){ if (!testjnOverride( "getLocale" )) return super.getLocale(); return (java.util.Locale) jInterface.Jnido( this, jchildidx + "getLocale_" + jlocale + "_", null ); }
@Override public int getMaxAddressLineIndex(){ if (!testjnOverride( "getMaxAddressLineIndex" )) return super.getMaxAddressLineIndex(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getMaxAddressLineIndex_" + jlocale + "_", null ); }
@Override public java.lang.String getAddressLine(int arg1) { if (!testjnOverride( "getAddressLine" )) return super.getAddressLine( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getAddressLine_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAddressLine(int arg1,java.lang.String arg2) { if (!testjnOverride( "setAddressLine" )) { super.setAddressLine( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setAddressLine_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.lang.String getFeatureName(){ if (!testjnOverride( "getFeatureName" )) return super.getFeatureName(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getFeatureName_" + jlocale + "_", null ); }
@Override public void setFeatureName(java.lang.String arg1) { if (!testjnOverride( "setFeatureName" )) { super.setFeatureName( arg1); return; } jInterface.Jnido( this, jchildidx + "setFeatureName_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getAdminArea(){ if (!testjnOverride( "getAdminArea" )) return super.getAdminArea(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getAdminArea_" + jlocale + "_", null ); }
@Override public void setAdminArea(java.lang.String arg1) { if (!testjnOverride( "setAdminArea" )) { super.setAdminArea( arg1); return; } jInterface.Jnido( this, jchildidx + "setAdminArea_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getSubAdminArea(){ if (!testjnOverride( "getSubAdminArea" )) return super.getSubAdminArea(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getSubAdminArea_" + jlocale + "_", null ); }
@Override public void setSubAdminArea(java.lang.String arg1) { if (!testjnOverride( "setSubAdminArea" )) { super.setSubAdminArea( arg1); return; } jInterface.Jnido( this, jchildidx + "setSubAdminArea_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getLocality(){ if (!testjnOverride( "getLocality" )) return super.getLocality(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getLocality_" + jlocale + "_", null ); }
@Override public void setLocality(java.lang.String arg1) { if (!testjnOverride( "setLocality" )) { super.setLocality( arg1); return; } jInterface.Jnido( this, jchildidx + "setLocality_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getSubLocality(){ if (!testjnOverride( "getSubLocality" )) return super.getSubLocality(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getSubLocality_" + jlocale + "_", null ); }
@Override public void setSubLocality(java.lang.String arg1) { if (!testjnOverride( "setSubLocality" )) { super.setSubLocality( arg1); return; } jInterface.Jnido( this, jchildidx + "setSubLocality_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getThoroughfare(){ if (!testjnOverride( "getThoroughfare" )) return super.getThoroughfare(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getThoroughfare_" + jlocale + "_", null ); }
@Override public void setThoroughfare(java.lang.String arg1) { if (!testjnOverride( "setThoroughfare" )) { super.setThoroughfare( arg1); return; } jInterface.Jnido( this, jchildidx + "setThoroughfare_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getSubThoroughfare(){ if (!testjnOverride( "getSubThoroughfare" )) return super.getSubThoroughfare(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getSubThoroughfare_" + jlocale + "_", null ); }
@Override public void setSubThoroughfare(java.lang.String arg1) { if (!testjnOverride( "setSubThoroughfare" )) { super.setSubThoroughfare( arg1); return; } jInterface.Jnido( this, jchildidx + "setSubThoroughfare_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getPremises(){ if (!testjnOverride( "getPremises" )) return super.getPremises(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getPremises_" + jlocale + "_", null ); }
@Override public void setPremises(java.lang.String arg1) { if (!testjnOverride( "setPremises" )) { super.setPremises( arg1); return; } jInterface.Jnido( this, jchildidx + "setPremises_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getPostalCode(){ if (!testjnOverride( "getPostalCode" )) return super.getPostalCode(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getPostalCode_" + jlocale + "_", null ); }
@Override public void setPostalCode(java.lang.String arg1) { if (!testjnOverride( "setPostalCode" )) { super.setPostalCode( arg1); return; } jInterface.Jnido( this, jchildidx + "setPostalCode_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getCountryCode(){ if (!testjnOverride( "getCountryCode" )) return super.getCountryCode(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getCountryCode_" + jlocale + "_", null ); }
@Override public void setCountryCode(java.lang.String arg1) { if (!testjnOverride( "setCountryCode" )) { super.setCountryCode( arg1); return; } jInterface.Jnido( this, jchildidx + "setCountryCode_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getCountryName(){ if (!testjnOverride( "getCountryName" )) return super.getCountryName(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getCountryName_" + jlocale + "_", null ); }
@Override public void setCountryName(java.lang.String arg1) { if (!testjnOverride( "setCountryName" )) { super.setCountryName( arg1); return; } jInterface.Jnido( this, jchildidx + "setCountryName_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean hasLatitude(){ if (!testjnOverride( "hasLatitude" )) return super.hasLatitude(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasLatitude_" + jlocale + "_", null ); }
@Override public double getLatitude(){ if (!testjnOverride( "getLatitude" )) return super.getLatitude(); return (java.lang.Double) jInterface.Jnido( this, jchildidx + "getLatitude_" + jlocale + "_", null ); }
@Override public void setLatitude(double arg1) { if (!testjnOverride( "setLatitude" )) { super.setLatitude( arg1); return; } jInterface.Jnido( this, jchildidx + "setLatitude_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void clearLatitude(){ if (!testjnOverride( "clearLatitude" )) { super.clearLatitude(); return; } jInterface.Jnido( this, jchildidx + "clearLatitude_" + jlocale + "_", null ); }
@Override public boolean hasLongitude(){ if (!testjnOverride( "hasLongitude" )) return super.hasLongitude(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasLongitude_" + jlocale + "_", null ); }
@Override public double getLongitude(){ if (!testjnOverride( "getLongitude" )) return super.getLongitude(); return (java.lang.Double) jInterface.Jnido( this, jchildidx + "getLongitude_" + jlocale + "_", null ); }
@Override public void setLongitude(double arg1) { if (!testjnOverride( "setLongitude" )) { super.setLongitude( arg1); return; } jInterface.Jnido( this, jchildidx + "setLongitude_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void clearLongitude(){ if (!testjnOverride( "clearLongitude" )) { super.clearLongitude(); return; } jInterface.Jnido( this, jchildidx + "clearLongitude_" + jlocale + "_", null ); }
@Override public java.lang.String getPhone(){ if (!testjnOverride( "getPhone" )) return super.getPhone(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getPhone_" + jlocale + "_", null ); }
@Override public void setPhone(java.lang.String arg1) { if (!testjnOverride( "setPhone" )) { super.setPhone( arg1); return; } jInterface.Jnido( this, jchildidx + "setPhone_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getUrl(){ if (!testjnOverride( "getUrl" )) return super.getUrl(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getUrl_" + jlocale + "_", null ); }
@Override public void setUrl(java.lang.String arg1) { if (!testjnOverride( "setUrl" )) { super.setUrl( arg1); return; } jInterface.Jnido( this, jchildidx + "setUrl_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.os.Bundle getExtras(){ if (!testjnOverride( "getExtras" )) return super.getExtras(); return (android.os.Bundle) jInterface.Jnido( this, jchildidx + "getExtras_" + jlocale + "_", null ); }
@Override public void setExtras(android.os.Bundle arg1) { if (!testjnOverride( "setExtras" )) { super.setExtras( arg1); return; } jInterface.Jnido( this, jchildidx + "setExtras_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
