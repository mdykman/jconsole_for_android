package org.dykman.jn.android.widget;
public class ToggleButton extends android.widget.ToggleButton{
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
public ToggleButton(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public ToggleButton(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public ToggleButton(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setChecked(boolean arg1) { if (!testjnOverride( "setChecked" )) { super.setChecked( arg1); return; } jInterface.Jnido( this, jchildidx + "setChecked_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.CharSequence getTextOn(){ if (!testjnOverride( "getTextOn" )) return super.getTextOn(); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "getTextOn_" + jlocale + "_", null ); }
@Override public void setTextOn(java.lang.CharSequence arg1) { if (!testjnOverride( "setTextOn" )) { super.setTextOn( arg1); return; } jInterface.Jnido( this, jchildidx + "setTextOn_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.CharSequence getTextOff(){ if (!testjnOverride( "getTextOff" )) return super.getTextOff(); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "getTextOff_" + jlocale + "_", null ); }
@Override public void setTextOff(java.lang.CharSequence arg1) { if (!testjnOverride( "setTextOff" )) { super.setTextOff( arg1); return; } jInterface.Jnido( this, jchildidx + "setTextOff_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onFinishInflate(){ if (!testjnOverride( "onFinishInflate" )) { super.onFinishInflate(); return; } jInterface.Jnido( this, jchildidx + "onFinishInflate_" + jlocale + "_", null ); }
@Override public void setBackgroundDrawable(android.graphics.drawable.Drawable arg1) { if (!testjnOverride( "setBackgroundDrawable" )) { super.setBackgroundDrawable( arg1); return; } jInterface.Jnido( this, jchildidx + "setBackgroundDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void drawableStateChanged(){ if (!testjnOverride( "drawableStateChanged" )) { super.drawableStateChanged(); return; } jInterface.Jnido( this, jchildidx + "drawableStateChanged_" + jlocale + "_", null ); }
}
