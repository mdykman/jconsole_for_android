package org.dykman.jn.android.widget;
public class LinearLayout extends android.widget.LinearLayout{
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
public LinearLayout(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public LinearLayout(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean isBaselineAligned(){ if (!testjnOverride( "isBaselineAligned" )) return super.isBaselineAligned(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isBaselineAligned_" + jlocale + "_", null ); }
@Override public void setBaselineAligned(boolean arg1) { if (!testjnOverride( "setBaselineAligned" )) { super.setBaselineAligned( arg1); return; } jInterface.Jnido( this, jchildidx + "setBaselineAligned_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getBaseline(){ if (!testjnOverride( "getBaseline" )) return super.getBaseline(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBaseline_" + jlocale + "_", null ); }
@Override public int getBaselineAlignedChildIndex(){ if (!testjnOverride( "getBaselineAlignedChildIndex" )) return super.getBaselineAlignedChildIndex(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBaselineAlignedChildIndex_" + jlocale + "_", null ); }
@Override public void setBaselineAlignedChildIndex(int arg1) { if (!testjnOverride( "setBaselineAlignedChildIndex" )) { super.setBaselineAlignedChildIndex( arg1); return; } jInterface.Jnido( this, jchildidx + "setBaselineAlignedChildIndex_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getWeightSum(){ if (!testjnOverride( "getWeightSum" )) return super.getWeightSum(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getWeightSum_" + jlocale + "_", null ); }
@Override public void setWeightSum(float arg1) { if (!testjnOverride( "setWeightSum" )) { super.setWeightSum( arg1); return; } jInterface.Jnido( this, jchildidx + "setWeightSum_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onMeasure(int arg1,int arg2) { if (!testjnOverride( "onMeasure" )) { super.onMeasure( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onMeasure_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void onLayout(boolean arg1,int arg2,int arg3,int arg4,int arg5) { if (!testjnOverride( "onLayout" )) { super.onLayout( arg1, arg2, arg3, arg4, arg5); return; } else super.onLayout( arg1, arg2, arg3, arg4, arg5); jInterface.Jnido( this, jchildidx + "onLayout_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public void setOrientation(int arg1) { if (!testjnOverride( "setOrientation" )) { super.setOrientation( arg1); return; } jInterface.Jnido( this, jchildidx + "setOrientation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getOrientation(){ if (!testjnOverride( "getOrientation" )) return super.getOrientation(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getOrientation_" + jlocale + "_", null ); }
@Override public void setGravity(int arg1) { if (!testjnOverride( "setGravity" )) { super.setGravity( arg1); return; } jInterface.Jnido( this, jchildidx + "setGravity_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setHorizontalGravity(int arg1) { if (!testjnOverride( "setHorizontalGravity" )) { super.setHorizontalGravity( arg1); return; } jInterface.Jnido( this, jchildidx + "setHorizontalGravity_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setVerticalGravity(int arg1) { if (!testjnOverride( "setVerticalGravity" )) { super.setVerticalGravity( arg1); return; } jInterface.Jnido( this, jchildidx + "setVerticalGravity_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected boolean checkLayoutParams(android.view.ViewGroup.LayoutParams arg1) { if (!testjnOverride( "checkLayoutParams" )) return super.checkLayoutParams( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "checkLayoutParams_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
