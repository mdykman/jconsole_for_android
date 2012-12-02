package org.dykman.jn.android.graphics;
public class Camera extends android.graphics.Camera{
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
public Camera(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override protected void finalize() throws java.lang.Throwable{ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void save(){ if (!testjnOverride( "save" )) { super.save(); return; } jInterface.Jnido( this, jchildidx + "save_" + jlocale + "_", null ); }
@Override public void restore(){ if (!testjnOverride( "restore" )) { super.restore(); return; } jInterface.Jnido( this, jchildidx + "restore_" + jlocale + "_", null ); }
@Override public void translate(float arg1,float arg2,float arg3) { if (!testjnOverride( "translate" )) { super.translate( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "translate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void rotateX(float arg1) { if (!testjnOverride( "rotateX" )) { super.rotateX( arg1); return; } jInterface.Jnido( this, jchildidx + "rotateX_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void rotateY(float arg1) { if (!testjnOverride( "rotateY" )) { super.rotateY( arg1); return; } jInterface.Jnido( this, jchildidx + "rotateY_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void rotateZ(float arg1) { if (!testjnOverride( "rotateZ" )) { super.rotateZ( arg1); return; } jInterface.Jnido( this, jchildidx + "rotateZ_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void getMatrix(android.graphics.Matrix arg1) { if (!testjnOverride( "getMatrix" )) { super.getMatrix( arg1); return; } jInterface.Jnido( this, jchildidx + "getMatrix_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void applyToCanvas(android.graphics.Canvas arg1) { if (!testjnOverride( "applyToCanvas" )) { super.applyToCanvas( arg1); return; } jInterface.Jnido( this, jchildidx + "applyToCanvas_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float dotWithNormal(float arg1,float arg2,float arg3) { if (!testjnOverride( "dotWithNormal" )) return super.dotWithNormal( arg1, arg2, arg3); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "dotWithNormal_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
