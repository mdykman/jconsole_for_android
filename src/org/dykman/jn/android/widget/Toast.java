package org.dykman.jn.android.widget;
public class Toast extends android.widget.Toast{
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
public Toast(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void show(){ if (!testjnOverride( "show" )) { super.show(); return; } jInterface.Jnido( this, jchildidx + "show_" + jlocale + "_", null ); }
@Override public void cancel(){ if (!testjnOverride( "cancel" )) { super.cancel(); return; } jInterface.Jnido( this, jchildidx + "cancel_" + jlocale + "_", null ); }
@Override public void setView(android.view.View arg1) { if (!testjnOverride( "setView" )) { super.setView( arg1); return; } jInterface.Jnido( this, jchildidx + "setView_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.view.View getView(){ if (!testjnOverride( "getView" )) return super.getView(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getView_" + jlocale + "_", null ); }
@Override public void setDuration(int arg1) { if (!testjnOverride( "setDuration" )) { super.setDuration( arg1); return; } jInterface.Jnido( this, jchildidx + "setDuration_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDuration(){ if (!testjnOverride( "getDuration" )) return super.getDuration(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDuration_" + jlocale + "_", null ); }
@Override public void setMargin(float arg1,float arg2) { if (!testjnOverride( "setMargin" )) { super.setMargin( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setMargin_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public float getHorizontalMargin(){ if (!testjnOverride( "getHorizontalMargin" )) return super.getHorizontalMargin(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getHorizontalMargin_" + jlocale + "_", null ); }
@Override public float getVerticalMargin(){ if (!testjnOverride( "getVerticalMargin" )) return super.getVerticalMargin(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getVerticalMargin_" + jlocale + "_", null ); }
@Override public void setGravity(int arg1,int arg2,int arg3) { if (!testjnOverride( "setGravity" )) { super.setGravity( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "setGravity_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public int getGravity(){ if (!testjnOverride( "getGravity" )) return super.getGravity(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getGravity_" + jlocale + "_", null ); }
@Override public int getXOffset(){ if (!testjnOverride( "getXOffset" )) return super.getXOffset(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getXOffset_" + jlocale + "_", null ); }
@Override public int getYOffset(){ if (!testjnOverride( "getYOffset" )) return super.getYOffset(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getYOffset_" + jlocale + "_", null ); }
@Override public void setText(int arg1) { if (!testjnOverride( "setText" )) { super.setText( arg1); return; } jInterface.Jnido( this, jchildidx + "setText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setText(java.lang.CharSequence arg1) { if (!testjnOverride( "setText" )) { super.setText( arg1); return; } jInterface.Jnido( this, jchildidx + "setText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
