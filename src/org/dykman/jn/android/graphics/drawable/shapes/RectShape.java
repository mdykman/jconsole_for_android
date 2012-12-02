package org.dykman.jn.android.graphics.drawable.shapes;
public class RectShape extends android.graphics.drawable.shapes.RectShape{
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
public RectShape(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public android.graphics.drawable.shapes.RectShape clone() throws java.lang.CloneNotSupportedException{ if (!testjnOverride( "clone" )) return super.clone(); return (android.graphics.drawable.shapes.RectShape) jInterface.Jnido( this, jchildidx + "clone_" + jlocale + "_", null ); }
@Override public void draw(android.graphics.Canvas arg1,android.graphics.Paint arg2) { if (!testjnOverride( "draw" )) { super.draw( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "draw_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void onResize(float arg1,float arg2) { if (!testjnOverride( "onResize" )) { super.onResize( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onResize_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
