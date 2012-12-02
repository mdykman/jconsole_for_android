package org.dykman.jn.android.widget;
public class Scroller extends android.widget.Scroller{
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
public Scroller(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Scroller(android.content.Context arg1,android.view.animation.Interpolator arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean computeScrollOffset(){ if (!testjnOverride( "computeScrollOffset" )) return super.computeScrollOffset(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "computeScrollOffset_" + jlocale + "_", null ); }
@Override public void startScroll(int arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "startScroll" )) { super.startScroll( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "startScroll_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void startScroll(int arg1,int arg2,int arg3,int arg4,int arg5) { if (!testjnOverride( "startScroll" )) { super.startScroll( arg1, arg2, arg3, arg4, arg5); return; } jInterface.Jnido( this, jchildidx + "startScroll_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public void fling(int arg1,int arg2,int arg3,int arg4,int arg5,int arg6,int arg7,int arg8) { if (!testjnOverride( "fling" )) { super.fling( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8); return; } jInterface.Jnido( this, jchildidx + "fling_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8 } ); }
@Override public void abortAnimation(){ if (!testjnOverride( "abortAnimation" )) { super.abortAnimation(); return; } jInterface.Jnido( this, jchildidx + "abortAnimation_" + jlocale + "_", null ); }
@Override public void extendDuration(int arg1) { if (!testjnOverride( "extendDuration" )) { super.extendDuration( arg1); return; } jInterface.Jnido( this, jchildidx + "extendDuration_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int timePassed(){ if (!testjnOverride( "timePassed" )) return super.timePassed(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "timePassed_" + jlocale + "_", null ); }
@Override public void setFinalX(int arg1) { if (!testjnOverride( "setFinalX" )) { super.setFinalX( arg1); return; } jInterface.Jnido( this, jchildidx + "setFinalX_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setFinalY(int arg1) { if (!testjnOverride( "setFinalY" )) { super.setFinalY( arg1); return; } jInterface.Jnido( this, jchildidx + "setFinalY_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
