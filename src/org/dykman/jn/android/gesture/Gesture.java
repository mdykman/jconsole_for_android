package org.dykman.jn.android.gesture;
public class Gesture extends android.gesture.Gesture{
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
public Gesture(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public float getLength(){ if (!testjnOverride( "getLength" )) return super.getLength(); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getLength_" + jlocale + "_", null ); }
@Override public java.util.ArrayList getStrokes(){ if (!testjnOverride( "getStrokes" )) return super.getStrokes(); return (java.util.ArrayList) jInterface.Jnido( this, jchildidx + "getStrokes_" + jlocale + "_", null ); }
@Override public int getStrokesCount(){ if (!testjnOverride( "getStrokesCount" )) return super.getStrokesCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getStrokesCount_" + jlocale + "_", null ); }
@Override public void addStroke(android.gesture.GestureStroke arg1) { if (!testjnOverride( "addStroke" )) { super.addStroke( arg1); return; } jInterface.Jnido( this, jchildidx + "addStroke_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.RectF getBoundingBox(){ if (!testjnOverride( "getBoundingBox" )) return super.getBoundingBox(); return (android.graphics.RectF) jInterface.Jnido( this, jchildidx + "getBoundingBox_" + jlocale + "_", null ); }
@Override public android.graphics.Path toPath(){ if (!testjnOverride( "toPath" )) return super.toPath(); return (android.graphics.Path) jInterface.Jnido( this, jchildidx + "toPath_" + jlocale + "_", null ); }
@Override public android.graphics.Path toPath(android.graphics.Path arg1) { if (!testjnOverride( "toPath" )) return super.toPath( arg1); return (android.graphics.Path) jInterface.Jnido( this, jchildidx + "toPath_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.graphics.Path toPath(int arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "toPath" )) return super.toPath( arg1, arg2, arg3, arg4); return (android.graphics.Path) jInterface.Jnido( this, jchildidx + "toPath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public android.graphics.Path toPath(android.graphics.Path arg1,int arg2,int arg3,int arg4,int arg5) { if (!testjnOverride( "toPath" )) return super.toPath( arg1, arg2, arg3, arg4, arg5); return (android.graphics.Path) jInterface.Jnido( this, jchildidx + "toPath_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public long getID(){ if (!testjnOverride( "getID" )) return super.getID(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getID_" + jlocale + "_", null ); }
@Override public android.graphics.Bitmap toBitmap(int arg1,int arg2,int arg3,int arg4,int arg5) { if (!testjnOverride( "toBitmap" )) return super.toBitmap( arg1, arg2, arg3, arg4, arg5); return (android.graphics.Bitmap) jInterface.Jnido( this, jchildidx + "toBitmap_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public android.graphics.Bitmap toBitmap(int arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "toBitmap" )) return super.toBitmap( arg1, arg2, arg3, arg4); return (android.graphics.Bitmap) jInterface.Jnido( this, jchildidx + "toBitmap_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
}
