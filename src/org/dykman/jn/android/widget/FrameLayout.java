package org.dykman.jn.android.widget;
public class FrameLayout extends android.widget.FrameLayout{
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
public FrameLayout(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public FrameLayout(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public FrameLayout(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setForegroundGravity(int arg1) { if (!testjnOverride( "setForegroundGravity" )) { super.setForegroundGravity( arg1); return; } jInterface.Jnido( this, jchildidx + "setForegroundGravity_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected boolean verifyDrawable(android.graphics.drawable.Drawable arg1) { if (!testjnOverride( "verifyDrawable" )) return super.verifyDrawable( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "verifyDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void drawableStateChanged(){ if (!testjnOverride( "drawableStateChanged" )) { super.drawableStateChanged(); return; } jInterface.Jnido( this, jchildidx + "drawableStateChanged_" + jlocale + "_", null ); }
@Override public void setForeground(android.graphics.drawable.Drawable arg1) { if (!testjnOverride( "setForeground" )) { super.setForeground( arg1); return; } jInterface.Jnido( this, jchildidx + "setForeground_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.drawable.Drawable getForeground(){ if (!testjnOverride( "getForeground" )) return super.getForeground(); return (android.graphics.drawable.Drawable) jInterface.Jnido( this, jchildidx + "getForeground_" + jlocale + "_", null ); }
@Override protected void onMeasure(int arg1,int arg2) { if (!testjnOverride( "onMeasure" )) { super.onMeasure( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onMeasure_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void onLayout(boolean arg1,int arg2,int arg3,int arg4,int arg5) { if (!testjnOverride( "onLayout" )) { super.onLayout( arg1, arg2, arg3, arg4, arg5); return; } else super.onLayout( arg1, arg2, arg3, arg4, arg5); jInterface.Jnido( this, jchildidx + "onLayout_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override protected void onSizeChanged(int arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "onSizeChanged" )) { super.onSizeChanged( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "onSizeChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void draw(android.graphics.Canvas arg1) { if (!testjnOverride( "draw" )) { super.draw( arg1); return; } jInterface.Jnido( this, jchildidx + "draw_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean gatherTransparentRegion(android.graphics.Region arg1) { if (!testjnOverride( "gatherTransparentRegion" )) return super.gatherTransparentRegion( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "gatherTransparentRegion_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setMeasureAllChildren(boolean arg1) { if (!testjnOverride( "setMeasureAllChildren" )) { super.setMeasureAllChildren( arg1); return; } jInterface.Jnido( this, jchildidx + "setMeasureAllChildren_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean getConsiderGoneChildrenWhenMeasuring(){ if (!testjnOverride( "getConsiderGoneChildrenWhenMeasuring" )) return super.getConsiderGoneChildrenWhenMeasuring(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getConsiderGoneChildrenWhenMeasuring_" + jlocale + "_", null ); }
@Override protected boolean checkLayoutParams(android.view.ViewGroup.LayoutParams arg1) { if (!testjnOverride( "checkLayoutParams" )) return super.checkLayoutParams( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "checkLayoutParams_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
