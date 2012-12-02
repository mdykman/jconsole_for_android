package org.dykman.jn.android.view.animation;
public class GridLayoutAnimationController extends android.view.animation.GridLayoutAnimationController{
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
public GridLayoutAnimationController(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public GridLayoutAnimationController(android.view.animation.Animation arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public GridLayoutAnimationController(android.view.animation.Animation arg1,float arg2,float arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public float getColumnDelay(){ if (!testjnOverride( "getColumnDelay" )) return super.getColumnDelay(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getColumnDelay_" + jlocale + "_", null ); }
@Override public void setColumnDelay(float arg1) { if (!testjnOverride( "setColumnDelay" )) { super.setColumnDelay( arg1); return; } jInterface.Jnido( this, jchildidx + "setColumnDelay_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getRowDelay(){ if (!testjnOverride( "getRowDelay" )) return super.getRowDelay(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getRowDelay_" + jlocale + "_", null ); }
@Override public void setRowDelay(float arg1) { if (!testjnOverride( "setRowDelay" )) { super.setRowDelay( arg1); return; } jInterface.Jnido( this, jchildidx + "setRowDelay_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDirection(){ if (!testjnOverride( "getDirection" )) return super.getDirection(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDirection_" + jlocale + "_", null ); }
@Override public void setDirection(int arg1) { if (!testjnOverride( "setDirection" )) { super.setDirection( arg1); return; } jInterface.Jnido( this, jchildidx + "setDirection_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDirectionPriority(){ if (!testjnOverride( "getDirectionPriority" )) return super.getDirectionPriority(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDirectionPriority_" + jlocale + "_", null ); }
@Override public void setDirectionPriority(int arg1) { if (!testjnOverride( "setDirectionPriority" )) { super.setDirectionPriority( arg1); return; } jInterface.Jnido( this, jchildidx + "setDirectionPriority_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean willOverlap(){ if (!testjnOverride( "willOverlap" )) return super.willOverlap(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "willOverlap_" + jlocale + "_", null ); }
@Override protected long getDelayForView(android.view.View arg1) { if (!testjnOverride( "getDelayForView" )) return super.getDelayForView( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getDelayForView_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
