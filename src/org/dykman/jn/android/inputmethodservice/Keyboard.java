package org.dykman.jn.android.inputmethodservice;
public class Keyboard extends android.inputmethodservice.Keyboard{
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
public Keyboard(android.content.Context arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public Keyboard(android.content.Context arg1,int arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public Keyboard(android.content.Context arg1,int arg2,java.lang.CharSequence arg3,int arg4,int arg5, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4, arg5); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public java.util.List getKeys(){ if (!testjnOverride( "getKeys" )) return super.getKeys(); return (java.util.List) jInterface.Jnido( this, jchildidx + "getKeys_" + jlocale + "_", null ); }
@Override public java.util.List getModifierKeys(){ if (!testjnOverride( "getModifierKeys" )) return super.getModifierKeys(); return (java.util.List) jInterface.Jnido( this, jchildidx + "getModifierKeys_" + jlocale + "_", null ); }
@Override protected int getHorizontalGap(){ if (!testjnOverride( "getHorizontalGap" )) return super.getHorizontalGap(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getHorizontalGap_" + jlocale + "_", null ); }
@Override protected void setHorizontalGap(int arg1) { if (!testjnOverride( "setHorizontalGap" )) { super.setHorizontalGap( arg1); return; } jInterface.Jnido( this, jchildidx + "setHorizontalGap_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected int getVerticalGap(){ if (!testjnOverride( "getVerticalGap" )) return super.getVerticalGap(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getVerticalGap_" + jlocale + "_", null ); }
@Override protected void setVerticalGap(int arg1) { if (!testjnOverride( "setVerticalGap" )) { super.setVerticalGap( arg1); return; } jInterface.Jnido( this, jchildidx + "setVerticalGap_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected int getKeyHeight(){ if (!testjnOverride( "getKeyHeight" )) return super.getKeyHeight(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getKeyHeight_" + jlocale + "_", null ); }
@Override protected void setKeyHeight(int arg1) { if (!testjnOverride( "setKeyHeight" )) { super.setKeyHeight( arg1); return; } jInterface.Jnido( this, jchildidx + "setKeyHeight_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected int getKeyWidth(){ if (!testjnOverride( "getKeyWidth" )) return super.getKeyWidth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getKeyWidth_" + jlocale + "_", null ); }
@Override protected void setKeyWidth(int arg1) { if (!testjnOverride( "setKeyWidth" )) { super.setKeyWidth( arg1); return; } jInterface.Jnido( this, jchildidx + "setKeyWidth_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getHeight(){ if (!testjnOverride( "getHeight" )) return super.getHeight(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getHeight_" + jlocale + "_", null ); }
@Override public int getMinWidth(){ if (!testjnOverride( "getMinWidth" )) return super.getMinWidth(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getMinWidth_" + jlocale + "_", null ); }
@Override public boolean setShifted(boolean arg1) { if (!testjnOverride( "setShifted" )) return super.setShifted( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "setShifted_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isShifted(){ if (!testjnOverride( "isShifted" )) return super.isShifted(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isShifted_" + jlocale + "_", null ); }
@Override public int getShiftKeyIndex(){ if (!testjnOverride( "getShiftKeyIndex" )) return super.getShiftKeyIndex(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getShiftKeyIndex_" + jlocale + "_", null ); }
@Override public int[] getNearestKeys(int arg1,int arg2) { if (!testjnOverride( "getNearestKeys" )) return super.getNearestKeys( arg1, arg2); return (int[]) jInterface.Jnidoi( this, jchildidx + "getNearestKeys_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
