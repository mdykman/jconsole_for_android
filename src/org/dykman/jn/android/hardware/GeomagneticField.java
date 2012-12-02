package org.dykman.jn.android.hardware;
public class GeomagneticField extends android.hardware.GeomagneticField{
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
public GeomagneticField(float arg1,float arg2,float arg3,long arg4, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public float getX(){ if (!testjnOverride( "getX" )) return super.getX(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getX_" + jlocale + "_", null ); }
@Override public float getY(){ if (!testjnOverride( "getY" )) return super.getY(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getY_" + jlocale + "_", null ); }
@Override public float getZ(){ if (!testjnOverride( "getZ" )) return super.getZ(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getZ_" + jlocale + "_", null ); }
@Override public float getDeclination(){ if (!testjnOverride( "getDeclination" )) return super.getDeclination(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getDeclination_" + jlocale + "_", null ); }
@Override public float getInclination(){ if (!testjnOverride( "getInclination" )) return super.getInclination(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getInclination_" + jlocale + "_", null ); }
@Override public float getHorizontalStrength(){ if (!testjnOverride( "getHorizontalStrength" )) return super.getHorizontalStrength(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getHorizontalStrength_" + jlocale + "_", null ); }
@Override public float getFieldStrength(){ if (!testjnOverride( "getFieldStrength" )) return super.getFieldStrength(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getFieldStrength_" + jlocale + "_", null ); }
}
