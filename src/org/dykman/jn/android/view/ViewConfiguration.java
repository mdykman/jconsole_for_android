package org.dykman.jn.android.view;
public class ViewConfiguration extends android.view.ViewConfiguration{
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
public ViewConfiguration(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public int getScaledScrollBarSize(){ if (!testjnOverride( "getScaledScrollBarSize" )) return super.getScaledScrollBarSize(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledScrollBarSize_" + jlocale + "_", null ); }
@Override public int getScaledFadingEdgeLength(){ if (!testjnOverride( "getScaledFadingEdgeLength" )) return super.getScaledFadingEdgeLength(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledFadingEdgeLength_" + jlocale + "_", null ); }
@Override public int getScaledEdgeSlop(){ if (!testjnOverride( "getScaledEdgeSlop" )) return super.getScaledEdgeSlop(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledEdgeSlop_" + jlocale + "_", null ); }
@Override public int getScaledTouchSlop(){ if (!testjnOverride( "getScaledTouchSlop" )) return super.getScaledTouchSlop(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledTouchSlop_" + jlocale + "_", null ); }
@Override public int getScaledDoubleTapSlop(){ if (!testjnOverride( "getScaledDoubleTapSlop" )) return super.getScaledDoubleTapSlop(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledDoubleTapSlop_" + jlocale + "_", null ); }
@Override public int getScaledWindowTouchSlop(){ if (!testjnOverride( "getScaledWindowTouchSlop" )) return super.getScaledWindowTouchSlop(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledWindowTouchSlop_" + jlocale + "_", null ); }
@Override public int getScaledMinimumFlingVelocity(){ if (!testjnOverride( "getScaledMinimumFlingVelocity" )) return super.getScaledMinimumFlingVelocity(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledMinimumFlingVelocity_" + jlocale + "_", null ); }
@Override public int getScaledMaximumFlingVelocity(){ if (!testjnOverride( "getScaledMaximumFlingVelocity" )) return super.getScaledMaximumFlingVelocity(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledMaximumFlingVelocity_" + jlocale + "_", null ); }
@Override public int getScaledMaximumDrawingCacheSize(){ if (!testjnOverride( "getScaledMaximumDrawingCacheSize" )) return super.getScaledMaximumDrawingCacheSize(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getScaledMaximumDrawingCacheSize_" + jlocale + "_", null ); }
}
