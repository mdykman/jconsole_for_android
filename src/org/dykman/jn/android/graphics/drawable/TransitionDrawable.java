package org.dykman.jn.android.graphics.drawable;
public class TransitionDrawable extends android.graphics.drawable.TransitionDrawable{
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
public TransitionDrawable(android.graphics.drawable.Drawable[] arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void startTransition(int arg1) { if (!testjnOverride( "startTransition" )) { super.startTransition( arg1); return; } jInterface.Jnido( this, jchildidx + "startTransition_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void resetTransition(){ if (!testjnOverride( "resetTransition" )) { super.resetTransition(); return; } jInterface.Jnido( this, jchildidx + "resetTransition_" + jlocale + "_", null ); }
@Override public void reverseTransition(int arg1) { if (!testjnOverride( "reverseTransition" )) { super.reverseTransition( arg1); return; } jInterface.Jnido( this, jchildidx + "reverseTransition_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void draw(android.graphics.Canvas arg1) { if (!testjnOverride( "draw" )) { super.draw( arg1); return; } jInterface.Jnido( this, jchildidx + "draw_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setCrossFadeEnabled(boolean arg1) { if (!testjnOverride( "setCrossFadeEnabled" )) { super.setCrossFadeEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setCrossFadeEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isCrossFadeEnabled(){ if (!testjnOverride( "isCrossFadeEnabled" )) return super.isCrossFadeEnabled(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isCrossFadeEnabled_" + jlocale + "_", null ); }
}
