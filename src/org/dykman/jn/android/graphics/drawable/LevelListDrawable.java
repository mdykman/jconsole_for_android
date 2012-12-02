package org.dykman.jn.android.graphics.drawable;
public class LevelListDrawable extends android.graphics.drawable.LevelListDrawable{
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
public LevelListDrawable(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void inflate(android.content.res.Resources arg1,org.xmlpull.v1.XmlPullParser arg2,android.util.AttributeSet arg3) throws org.xmlpull.v1.XmlPullParserException,java.io.IOException { if (!testjnOverride( "inflate" )) { super.inflate( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "inflate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void addLevel(int arg1,int arg2,android.graphics.drawable.Drawable arg3) { if (!testjnOverride( "addLevel" )) { super.addLevel( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "addLevel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override protected boolean onLevelChange(int arg1) { if (!testjnOverride( "onLevelChange" )) return super.onLevelChange( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onLevelChange_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.drawable.Drawable mutate(){ if (!testjnOverride( "mutate" )) return super.mutate(); return (android.graphics.drawable.Drawable) jInterface.Jnido( this, jchildidx + "mutate_" + jlocale + "_", null ); }
}
