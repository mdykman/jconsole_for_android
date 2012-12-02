package org.dykman.jn.android.widget;
public class RatingBar extends android.widget.RatingBar{
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
public RatingBar(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public RatingBar(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public RatingBar(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnRatingBarChangeListener(android.widget.RatingBar.OnRatingBarChangeListener arg1) { if (!testjnOverride( "setOnRatingBarChangeListener" )) { super.setOnRatingBarChangeListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnRatingBarChangeListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setIsIndicator(boolean arg1) { if (!testjnOverride( "setIsIndicator" )) { super.setIsIndicator( arg1); return; } jInterface.Jnido( this, jchildidx + "setIsIndicator_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isIndicator(){ if (!testjnOverride( "isIndicator" )) return super.isIndicator(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isIndicator_" + jlocale + "_", null ); }
@Override public void setNumStars(int arg1) { if (!testjnOverride( "setNumStars" )) { super.setNumStars( arg1); return; } jInterface.Jnido( this, jchildidx + "setNumStars_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getNumStars(){ if (!testjnOverride( "getNumStars" )) return super.getNumStars(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getNumStars_" + jlocale + "_", null ); }
@Override public void setRating(float arg1) { if (!testjnOverride( "setRating" )) { super.setRating( arg1); return; } jInterface.Jnido( this, jchildidx + "setRating_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getRating(){ if (!testjnOverride( "getRating" )) return super.getRating(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getRating_" + jlocale + "_", null ); }
@Override public void setStepSize(float arg1) { if (!testjnOverride( "setStepSize" )) { super.setStepSize( arg1); return; } jInterface.Jnido( this, jchildidx + "setStepSize_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getStepSize(){ if (!testjnOverride( "getStepSize" )) return super.getStepSize(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getStepSize_" + jlocale + "_", null ); }
@Override protected synchronized void onMeasure(int arg1,int arg2) { if (!testjnOverride( "onMeasure" )) { super.onMeasure( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onMeasure_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public synchronized void setMax(int arg1) { if (!testjnOverride( "setMax" )) { super.setMax( arg1); return; } jInterface.Jnido( this, jchildidx + "setMax_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
