package org.dykman.jn.android.view.animation;
public class Animation$AnimationListener implements android.view.animation.Animation.AnimationListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public Animation$AnimationListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onAnimationStart(android.view.animation.Animation arg1) { jInterface.Jnido( this, jchildidx + "onAnimationStart_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onAnimationEnd(android.view.animation.Animation arg1) { jInterface.Jnido( this, jchildidx + "onAnimationEnd_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onAnimationRepeat(android.view.animation.Animation arg1) { jInterface.Jnido( this, jchildidx + "onAnimationRepeat_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
