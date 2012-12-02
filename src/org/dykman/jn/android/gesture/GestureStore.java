package org.dykman.jn.android.gesture;
public class GestureStore extends android.gesture.GestureStore{
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
public GestureStore(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void load(java.io.InputStream arg1) throws java.io.IOException { if (!testjnOverride( "load" )) { super.load( arg1); return; } jInterface.Jnido( this, jchildidx + "load_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void load(java.io.InputStream arg1,boolean arg2) throws java.io.IOException { if (!testjnOverride( "load" )) { super.load( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "load_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void save(java.io.OutputStream arg1) throws java.io.IOException { if (!testjnOverride( "save" )) { super.save( arg1); return; } jInterface.Jnido( this, jchildidx + "save_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void save(java.io.OutputStream arg1,boolean arg2) throws java.io.IOException { if (!testjnOverride( "save" )) { super.save( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "save_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setOrientationStyle(int arg1) { if (!testjnOverride( "setOrientationStyle" )) { super.setOrientationStyle( arg1); return; } jInterface.Jnido( this, jchildidx + "setOrientationStyle_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getOrientationStyle(){ if (!testjnOverride( "getOrientationStyle" )) return super.getOrientationStyle(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getOrientationStyle_" + jlocale + "_", null ); }
@Override public void setSequenceType(int arg1) { if (!testjnOverride( "setSequenceType" )) { super.setSequenceType( arg1); return; } jInterface.Jnido( this, jchildidx + "setSequenceType_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getSequenceType(){ if (!testjnOverride( "getSequenceType" )) return super.getSequenceType(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getSequenceType_" + jlocale + "_", null ); }
@Override public java.util.Set getGestureEntries(){ if (!testjnOverride( "getGestureEntries" )) return super.getGestureEntries(); return (java.util.Set) jInterface.Jnido( this, jchildidx + "getGestureEntries_" + jlocale + "_", null ); }
@Override public java.util.ArrayList recognize(android.gesture.Gesture arg1) { if (!testjnOverride( "recognize" )) return super.recognize( arg1); return (java.util.ArrayList) jInterface.Jnido( this, jchildidx + "recognize_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void addGesture(java.lang.String arg1,android.gesture.Gesture arg2) { if (!testjnOverride( "addGesture" )) { super.addGesture( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "addGesture_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void removeGesture(java.lang.String arg1,android.gesture.Gesture arg2) { if (!testjnOverride( "removeGesture" )) { super.removeGesture( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "removeGesture_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void removeEntry(java.lang.String arg1) { if (!testjnOverride( "removeEntry" )) { super.removeEntry( arg1); return; } jInterface.Jnido( this, jchildidx + "removeEntry_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.util.ArrayList getGestures(java.lang.String arg1) { if (!testjnOverride( "getGestures" )) return super.getGestures( arg1); return (java.util.ArrayList) jInterface.Jnido( this, jchildidx + "getGestures_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean hasChanged(){ if (!testjnOverride( "hasChanged" )) return super.hasChanged(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasChanged_" + jlocale + "_", null ); }
}
