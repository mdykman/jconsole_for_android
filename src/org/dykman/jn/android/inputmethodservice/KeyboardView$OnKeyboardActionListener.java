package org.dykman.jn.android.inputmethodservice;
public class KeyboardView$OnKeyboardActionListener implements android.inputmethodservice.KeyboardView.OnKeyboardActionListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public KeyboardView$OnKeyboardActionListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onPress(int arg1) { jInterface.Jnido( this, jchildidx + "onPress_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onRelease(int arg1) { jInterface.Jnido( this, jchildidx + "onRelease_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onKey(int arg1,int[] arg2) { jInterface.Jnido( this, jchildidx + "onKey_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onText(java.lang.CharSequence arg1) { jInterface.Jnido( this, jchildidx + "onText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void swipeLeft(){ jInterface.Jnido( this, jchildidx + "swipeLeft_" + jlocale + "_", null ); }
@Override public void swipeRight(){ jInterface.Jnido( this, jchildidx + "swipeRight_" + jlocale + "_", null ); }
@Override public void swipeDown(){ jInterface.Jnido( this, jchildidx + "swipeDown_" + jlocale + "_", null ); }
@Override public void swipeUp(){ jInterface.Jnido( this, jchildidx + "swipeUp_" + jlocale + "_", null ); }
}
