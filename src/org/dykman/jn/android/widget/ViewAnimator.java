package org.dykman.jn.android.widget;
public class ViewAnimator extends android.widget.ViewAnimator{
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
public ViewAnimator(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ViewAnimator(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setDisplayedChild(int arg1) { if (!testjnOverride( "setDisplayedChild" )) { super.setDisplayedChild( arg1); return; } jInterface.Jnido( this, jchildidx + "setDisplayedChild_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDisplayedChild(){ if (!testjnOverride( "getDisplayedChild" )) return super.getDisplayedChild(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDisplayedChild_" + jlocale + "_", null ); }
@Override public void showNext(){ if (!testjnOverride( "showNext" )) { super.showNext(); return; } jInterface.Jnido( this, jchildidx + "showNext_" + jlocale + "_", null ); }
@Override public void showPrevious(){ if (!testjnOverride( "showPrevious" )) { super.showPrevious(); return; } jInterface.Jnido( this, jchildidx + "showPrevious_" + jlocale + "_", null ); }
@Override public void addView(android.view.View arg1,int arg2,android.view.ViewGroup.LayoutParams arg3) { if (!testjnOverride( "addView" )) { super.addView( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "addView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void removeAllViews(){ if (!testjnOverride( "removeAllViews" )) { super.removeAllViews(); return; } jInterface.Jnido( this, jchildidx + "removeAllViews_" + jlocale + "_", null ); }
@Override public void removeView(android.view.View arg1) { if (!testjnOverride( "removeView" )) { super.removeView( arg1); return; } jInterface.Jnido( this, jchildidx + "removeView_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeViewAt(int arg1) { if (!testjnOverride( "removeViewAt" )) { super.removeViewAt( arg1); return; } jInterface.Jnido( this, jchildidx + "removeViewAt_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeViewInLayout(android.view.View arg1) { if (!testjnOverride( "removeViewInLayout" )) { super.removeViewInLayout( arg1); return; } jInterface.Jnido( this, jchildidx + "removeViewInLayout_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeViews(int arg1,int arg2) { if (!testjnOverride( "removeViews" )) { super.removeViews( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "removeViews_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void removeViewsInLayout(int arg1,int arg2) { if (!testjnOverride( "removeViewsInLayout" )) { super.removeViewsInLayout( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "removeViewsInLayout_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.view.View getCurrentView(){ if (!testjnOverride( "getCurrentView" )) return super.getCurrentView(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getCurrentView_" + jlocale + "_", null ); }
@Override public android.view.animation.Animation getInAnimation(){ if (!testjnOverride( "getInAnimation" )) return super.getInAnimation(); return (android.view.animation.Animation) jInterface.Jnido( this, jchildidx + "getInAnimation_" + jlocale + "_", null ); }
@Override public void setInAnimation(android.view.animation.Animation arg1) { if (!testjnOverride( "setInAnimation" )) { super.setInAnimation( arg1); return; } jInterface.Jnido( this, jchildidx + "setInAnimation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setInAnimation(android.content.Context arg1,int arg2) { if (!testjnOverride( "setInAnimation" )) { super.setInAnimation( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setInAnimation_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.view.animation.Animation getOutAnimation(){ if (!testjnOverride( "getOutAnimation" )) return super.getOutAnimation(); return (android.view.animation.Animation) jInterface.Jnido( this, jchildidx + "getOutAnimation_" + jlocale + "_", null ); }
@Override public void setOutAnimation(android.view.animation.Animation arg1) { if (!testjnOverride( "setOutAnimation" )) { super.setOutAnimation( arg1); return; } jInterface.Jnido( this, jchildidx + "setOutAnimation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOutAnimation(android.content.Context arg1,int arg2) { if (!testjnOverride( "setOutAnimation" )) { super.setOutAnimation( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setOutAnimation_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setAnimateFirstView(boolean arg1) { if (!testjnOverride( "setAnimateFirstView" )) { super.setAnimateFirstView( arg1); return; } jInterface.Jnido( this, jchildidx + "setAnimateFirstView_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getBaseline(){ if (!testjnOverride( "getBaseline" )) return super.getBaseline(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBaseline_" + jlocale + "_", null ); }
}
