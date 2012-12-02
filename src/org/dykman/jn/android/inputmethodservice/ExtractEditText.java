package org.dykman.jn.android.inputmethodservice;
public class ExtractEditText extends android.inputmethodservice.ExtractEditText{
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
public ExtractEditText(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ExtractEditText(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public ExtractEditText(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void startInternalChanges(){ if (!testjnOverride( "startInternalChanges" )) { super.startInternalChanges(); return; } jInterface.Jnido( this, jchildidx + "startInternalChanges_" + jlocale + "_", null ); }
@Override public void finishInternalChanges(){ if (!testjnOverride( "finishInternalChanges" )) { super.finishInternalChanges(); return; } jInterface.Jnido( this, jchildidx + "finishInternalChanges_" + jlocale + "_", null ); }
@Override public void setExtractedText(android.view.inputmethod.ExtractedText arg1) { if (!testjnOverride( "setExtractedText" )) { super.setExtractedText( arg1); return; } jInterface.Jnido( this, jchildidx + "setExtractedText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onSelectionChanged(int arg1,int arg2) { if (!testjnOverride( "onSelectionChanged" )) { super.onSelectionChanged( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onSelectionChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean performClick(){ if (!testjnOverride( "performClick" )) return super.performClick(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "performClick_" + jlocale + "_", null ); }
@Override public boolean onTextContextMenuItem(int arg1) { if (!testjnOverride( "onTextContextMenuItem" )) return super.onTextContextMenuItem( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTextContextMenuItem_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isInputMethodTarget(){ if (!testjnOverride( "isInputMethodTarget" )) return super.isInputMethodTarget(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isInputMethodTarget_" + jlocale + "_", null ); }
@Override public boolean hasVerticalScrollBar(){ if (!testjnOverride( "hasVerticalScrollBar" )) return super.hasVerticalScrollBar(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasVerticalScrollBar_" + jlocale + "_", null ); }
@Override public boolean hasWindowFocus(){ if (!testjnOverride( "hasWindowFocus" )) return super.hasWindowFocus(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasWindowFocus_" + jlocale + "_", null ); }
@Override public boolean isFocused(){ if (!testjnOverride( "isFocused" )) return super.isFocused(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isFocused_" + jlocale + "_", null ); }
@Override public boolean hasFocus(){ if (!testjnOverride( "hasFocus" )) return super.hasFocus(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasFocus_" + jlocale + "_", null ); }
}
