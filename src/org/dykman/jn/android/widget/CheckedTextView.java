package org.dykman.jn.android.widget;
public class CheckedTextView extends android.widget.CheckedTextView{
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
public CheckedTextView(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public CheckedTextView(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public CheckedTextView(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void toggle(){ if (!testjnOverride( "toggle" )) { super.toggle(); return; } jInterface.Jnido( this, jchildidx + "toggle_" + jlocale + "_", null ); }
@Override public boolean isChecked(){ if (!testjnOverride( "isChecked" )) return super.isChecked(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isChecked_" + jlocale + "_", null ); }
@Override public void setChecked(boolean arg1) { if (!testjnOverride( "setChecked" )) { super.setChecked( arg1); return; } jInterface.Jnido( this, jchildidx + "setChecked_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setCheckMarkDrawable(int arg1) { if (!testjnOverride( "setCheckMarkDrawable" )) { super.setCheckMarkDrawable( arg1); return; } jInterface.Jnido( this, jchildidx + "setCheckMarkDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setCheckMarkDrawable(android.graphics.drawable.Drawable arg1) { if (!testjnOverride( "setCheckMarkDrawable" )) { super.setCheckMarkDrawable( arg1); return; } jInterface.Jnido( this, jchildidx + "setCheckMarkDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setPadding(int arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "setPadding" )) { super.setPadding( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "setPadding_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override protected void onDraw(android.graphics.Canvas arg1) { if (!testjnOverride( "onDraw" )) { super.onDraw( arg1); return; } jInterface.Jnido( this, jchildidx + "onDraw_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected int[] onCreateDrawableState(int arg1) { if (!testjnOverride( "onCreateDrawableState" )) return super.onCreateDrawableState( arg1); return (int[]) jInterface.Jnidoi( this, jchildidx + "onCreateDrawableState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void drawableStateChanged(){ if (!testjnOverride( "drawableStateChanged" )) { super.drawableStateChanged(); return; } jInterface.Jnido( this, jchildidx + "drawableStateChanged_" + jlocale + "_", null ); }
@Override public boolean dispatchPopulateAccessibilityEvent(android.view.accessibility.AccessibilityEvent arg1) { if (!testjnOverride( "dispatchPopulateAccessibilityEvent" )) return super.dispatchPopulateAccessibilityEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "dispatchPopulateAccessibilityEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
