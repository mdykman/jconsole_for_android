package org.dykman.jn.android.view.animation;
public class AnimationSet extends android.view.animation.AnimationSet{
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
public AnimationSet(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public AnimationSet(boolean arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected android.view.animation.AnimationSet clone() throws java.lang.CloneNotSupportedException{ if (!testjnOverride( "clone" )) return super.clone(); return (android.view.animation.AnimationSet) jInterface.Jnido( this, jchildidx + "clone_" + jlocale + "_", null ); }
@Override public void reset(){ if (!testjnOverride( "reset" )) { super.reset(); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", null ); }
@Override public void initialize(int arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "initialize" )) { super.initialize( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "initialize_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void setFillAfter(boolean arg1) { if (!testjnOverride( "setFillAfter" )) { super.setFillAfter( arg1); return; } jInterface.Jnido( this, jchildidx + "setFillAfter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setFillBefore(boolean arg1) { if (!testjnOverride( "setFillBefore" )) { super.setFillBefore( arg1); return; } jInterface.Jnido( this, jchildidx + "setFillBefore_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setRepeatMode(int arg1) { if (!testjnOverride( "setRepeatMode" )) { super.setRepeatMode( arg1); return; } jInterface.Jnido( this, jchildidx + "setRepeatMode_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setStartOffset(long arg1) { if (!testjnOverride( "setStartOffset" )) { super.setStartOffset( arg1); return; } jInterface.Jnido( this, jchildidx + "setStartOffset_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setDuration(long arg1) { if (!testjnOverride( "setDuration" )) { super.setDuration( arg1); return; } jInterface.Jnido( this, jchildidx + "setDuration_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void addAnimation(android.view.animation.Animation arg1) { if (!testjnOverride( "addAnimation" )) { super.addAnimation( arg1); return; } jInterface.Jnido( this, jchildidx + "addAnimation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setStartTime(long arg1) { if (!testjnOverride( "setStartTime" )) { super.setStartTime( arg1); return; } jInterface.Jnido( this, jchildidx + "setStartTime_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getStartTime(){ if (!testjnOverride( "getStartTime" )) return super.getStartTime(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getStartTime_" + jlocale + "_", null ); }
@Override public void restrictDuration(long arg1) { if (!testjnOverride( "restrictDuration" )) { super.restrictDuration( arg1); return; } jInterface.Jnido( this, jchildidx + "restrictDuration_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getDuration(){ if (!testjnOverride( "getDuration" )) return super.getDuration(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getDuration_" + jlocale + "_", null ); }
@Override public long computeDurationHint(){ if (!testjnOverride( "computeDurationHint" )) return super.computeDurationHint(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "computeDurationHint_" + jlocale + "_", null ); }
@Override public boolean getTransformation(long arg1,android.view.animation.Transformation arg2) { if (!testjnOverride( "getTransformation" )) return super.getTransformation( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getTransformation_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void scaleCurrentDuration(float arg1) { if (!testjnOverride( "scaleCurrentDuration" )) { super.scaleCurrentDuration( arg1); return; } jInterface.Jnido( this, jchildidx + "scaleCurrentDuration_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.util.List getAnimations(){ if (!testjnOverride( "getAnimations" )) return super.getAnimations(); return (java.util.List) jInterface.Jnido( this, jchildidx + "getAnimations_" + jlocale + "_", null ); }
@Override public boolean willChangeTransformationMatrix(){ if (!testjnOverride( "willChangeTransformationMatrix" )) return super.willChangeTransformationMatrix(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "willChangeTransformationMatrix_" + jlocale + "_", null ); }
@Override public boolean willChangeBounds(){ if (!testjnOverride( "willChangeBounds" )) return super.willChangeBounds(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "willChangeBounds_" + jlocale + "_", null ); }
}
