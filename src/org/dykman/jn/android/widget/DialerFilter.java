package org.dykman.jn.android.widget;
public class DialerFilter extends android.widget.DialerFilter{
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
public DialerFilter(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public DialerFilter(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void onFinishInflate(){ if (!testjnOverride( "onFinishInflate" )) { super.onFinishInflate(); return; } jInterface.Jnido( this, jchildidx + "onFinishInflate_" + jlocale + "_", null ); }
@Override protected void onFocusChanged(boolean arg1,int arg2,android.graphics.Rect arg3) { if (!testjnOverride( "onFocusChanged" )) { super.onFocusChanged( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "onFocusChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean isQwertyKeyboard(){ if (!testjnOverride( "isQwertyKeyboard" )) return super.isQwertyKeyboard(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isQwertyKeyboard_" + jlocale + "_", null ); }
@Override public boolean onKeyDown(int arg1,android.view.KeyEvent arg2) { if (!testjnOverride( "onKeyDown" )) return super.onKeyDown( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyDown_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean onKeyUp(int arg1,android.view.KeyEvent arg2) { if (!testjnOverride( "onKeyUp" )) return super.onKeyUp( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyUp_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getMode(){ if (!testjnOverride( "getMode" )) return super.getMode(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getMode_" + jlocale + "_", null ); }
@Override public void setMode(int arg1) { if (!testjnOverride( "setMode" )) { super.setMode( arg1); return; } jInterface.Jnido( this, jchildidx + "setMode_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.CharSequence getLetters(){ if (!testjnOverride( "getLetters" )) return super.getLetters(); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "getLetters_" + jlocale + "_", null ); }
@Override public java.lang.CharSequence getDigits(){ if (!testjnOverride( "getDigits" )) return super.getDigits(); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "getDigits_" + jlocale + "_", null ); }
@Override public java.lang.CharSequence getFilterText(){ if (!testjnOverride( "getFilterText" )) return super.getFilterText(); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "getFilterText_" + jlocale + "_", null ); }
@Override public void clearText(){ if (!testjnOverride( "clearText" )) { super.clearText(); return; } jInterface.Jnido( this, jchildidx + "clearText_" + jlocale + "_", null ); }
@Override public void setLettersWatcher(android.text.TextWatcher arg1) { if (!testjnOverride( "setLettersWatcher" )) { super.setLettersWatcher( arg1); return; } jInterface.Jnido( this, jchildidx + "setLettersWatcher_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setDigitsWatcher(android.text.TextWatcher arg1) { if (!testjnOverride( "setDigitsWatcher" )) { super.setDigitsWatcher( arg1); return; } jInterface.Jnido( this, jchildidx + "setDigitsWatcher_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setFilterWatcher(android.text.TextWatcher arg1) { if (!testjnOverride( "setFilterWatcher" )) { super.setFilterWatcher( arg1); return; } jInterface.Jnido( this, jchildidx + "setFilterWatcher_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void removeFilterWatcher(android.text.TextWatcher arg1) { if (!testjnOverride( "removeFilterWatcher" )) { super.removeFilterWatcher( arg1); return; } jInterface.Jnido( this, jchildidx + "removeFilterWatcher_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onModeChange(int arg1,int arg2) { if (!testjnOverride( "onModeChange" )) { super.onModeChange( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onModeChange_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
