package org.dykman.jn.android.text.method;
public class TextKeyListener extends android.text.method.TextKeyListener{
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
public TextKeyListener(android.text.method.TextKeyListener.Capitalize arg1,boolean arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void release(){ if (!testjnOverride( "release" )) { super.release(); return; } jInterface.Jnido( this, jchildidx + "release_" + jlocale + "_", null ); }
@Override public int getInputType(){ if (!testjnOverride( "getInputType" )) return super.getInputType(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getInputType_" + jlocale + "_", null ); }
@Override public boolean onKeyDown(android.view.View arg1,android.text.Editable arg2,int arg3,android.view.KeyEvent arg4) { if (!testjnOverride( "onKeyDown" )) return super.onKeyDown( arg1, arg2, arg3, arg4); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyDown_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public boolean onKeyUp(android.view.View arg1,android.text.Editable arg2,int arg3,android.view.KeyEvent arg4) { if (!testjnOverride( "onKeyUp" )) return super.onKeyUp( arg1, arg2, arg3, arg4); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyUp_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public boolean onKeyOther(android.view.View arg1,android.text.Editable arg2,android.view.KeyEvent arg3) { if (!testjnOverride( "onKeyOther" )) return super.onKeyOther( arg1, arg2, arg3); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyOther_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void onSpanAdded(android.text.Spannable arg1,java.lang.Object arg2,int arg3,int arg4) { if (!testjnOverride( "onSpanAdded" )) { super.onSpanAdded( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "onSpanAdded_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void onSpanRemoved(android.text.Spannable arg1,java.lang.Object arg2,int arg3,int arg4) { if (!testjnOverride( "onSpanRemoved" )) { super.onSpanRemoved( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "onSpanRemoved_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void onSpanChanged(android.text.Spannable arg1,java.lang.Object arg2,int arg3,int arg4,int arg5,int arg6) { if (!testjnOverride( "onSpanChanged" )) { super.onSpanChanged( arg1, arg2, arg3, arg4, arg5, arg6); return; } jInterface.Jnido( this, jchildidx + "onSpanChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
}
