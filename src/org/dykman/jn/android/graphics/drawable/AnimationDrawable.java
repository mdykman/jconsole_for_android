package org.dykman.jn.android.graphics.drawable;
public class AnimationDrawable extends android.graphics.drawable.AnimationDrawable{
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
public AnimationDrawable(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void run(){ if (!testjnOverride( "run" )) { super.run(); return; } jInterface.Jnido( this, jchildidx + "run_" + jlocale + "_", null ); }
@Override public void start(){ if (!testjnOverride( "start" )) { super.start(); return; } jInterface.Jnido( this, jchildidx + "start_" + jlocale + "_", null ); }
@Override public void stop(){ if (!testjnOverride( "stop" )) { super.stop(); return; } jInterface.Jnido( this, jchildidx + "stop_" + jlocale + "_", null ); }
@Override public void inflate(android.content.res.Resources arg1,org.xmlpull.v1.XmlPullParser arg2,android.util.AttributeSet arg3) throws org.xmlpull.v1.XmlPullParserException,java.io.IOException { if (!testjnOverride( "inflate" )) { super.inflate( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "inflate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean setVisible(boolean arg1,boolean arg2) { if (!testjnOverride( "setVisible" )) return super.setVisible( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "setVisible_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean isRunning(){ if (!testjnOverride( "isRunning" )) return super.isRunning(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isRunning_" + jlocale + "_", null ); }
@Override public void unscheduleSelf(java.lang.Runnable arg1) { if (!testjnOverride( "unscheduleSelf" )) { super.unscheduleSelf( arg1); return; } jInterface.Jnido( this, jchildidx + "unscheduleSelf_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getNumberOfFrames(){ if (!testjnOverride( "getNumberOfFrames" )) return super.getNumberOfFrames(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getNumberOfFrames_" + jlocale + "_", null ); }
@Override public android.graphics.drawable.Drawable getFrame(int arg1) { if (!testjnOverride( "getFrame" )) return super.getFrame( arg1); return (android.graphics.drawable.Drawable) jInterface.Jnido( this, jchildidx + "getFrame_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDuration(int arg1) { if (!testjnOverride( "getDuration" )) return super.getDuration( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDuration_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isOneShot(){ if (!testjnOverride( "isOneShot" )) return super.isOneShot(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isOneShot_" + jlocale + "_", null ); }
@Override public void setOneShot(boolean arg1) { if (!testjnOverride( "setOneShot" )) { super.setOneShot( arg1); return; } jInterface.Jnido( this, jchildidx + "setOneShot_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void addFrame(android.graphics.drawable.Drawable arg1,int arg2) { if (!testjnOverride( "addFrame" )) { super.addFrame( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "addFrame_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.graphics.drawable.Drawable mutate(){ if (!testjnOverride( "mutate" )) return super.mutate(); return (android.graphics.drawable.Drawable) jInterface.Jnido( this, jchildidx + "mutate_" + jlocale + "_", null ); }
}
