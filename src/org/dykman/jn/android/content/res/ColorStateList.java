package org.dykman.jn.android.content.res;
public class ColorStateList extends android.content.res.ColorStateList{
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
public ColorStateList(int[][] arg1,int[] arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public android.content.res.ColorStateList withAlpha(int arg1) { if (!testjnOverride( "withAlpha" )) return super.withAlpha( arg1); return (android.content.res.ColorStateList) jInterface.Jnido( this, jchildidx + "withAlpha_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isStateful(){ if (!testjnOverride( "isStateful" )) return super.isStateful(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isStateful_" + jlocale + "_", null ); }
@Override public int getColorForState(int[] arg1,int arg2) { if (!testjnOverride( "getColorForState" )) return super.getColorForState( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getColorForState_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getDefaultColor(){ if (!testjnOverride( "getDefaultColor" )) return super.getDefaultColor(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDefaultColor_" + jlocale + "_", null ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
