package org.dykman.jn.android.view.animation;
public class Transformation extends android.view.animation.Transformation{
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
public Transformation(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public void clear(){ if (!testjnOverride( "clear" )) { super.clear(); return; } jInterface.Jnido( this, jchildidx + "clear_" + jlocale + "_", null ); }
@Override public void set(android.view.animation.Transformation arg1) { if (!testjnOverride( "set" )) { super.set( arg1); return; } jInterface.Jnido( this, jchildidx + "set_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getTransformationType(){ if (!testjnOverride( "getTransformationType" )) return super.getTransformationType(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getTransformationType_" + jlocale + "_", null ); }
@Override public void setTransformationType(int arg1) { if (!testjnOverride( "setTransformationType" )) { super.setTransformationType( arg1); return; } jInterface.Jnido( this, jchildidx + "setTransformationType_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void compose(android.view.animation.Transformation arg1) { if (!testjnOverride( "compose" )) { super.compose( arg1); return; } jInterface.Jnido( this, jchildidx + "compose_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.Matrix getMatrix(){ if (!testjnOverride( "getMatrix" )) return super.getMatrix(); return (android.graphics.Matrix) jInterface.Jnido( this, jchildidx + "getMatrix_" + jlocale + "_", null ); }
@Override public void setAlpha(float arg1) { if (!testjnOverride( "setAlpha" )) { super.setAlpha( arg1); return; } jInterface.Jnido( this, jchildidx + "setAlpha_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getAlpha(){ if (!testjnOverride( "getAlpha" )) return super.getAlpha(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getAlpha_" + jlocale + "_", null ); }
@Override public java.lang.String toShortString(){ if (!testjnOverride( "toShortString" )) return super.toShortString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toShortString_" + jlocale + "_", null ); }
}
