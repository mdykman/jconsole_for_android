package org.dykman.jn.android.widget;
public class EditText extends android.widget.EditText{
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
public EditText(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public EditText(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public EditText(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override protected boolean getDefaultEditable(){ if (!testjnOverride( "getDefaultEditable" )) return super.getDefaultEditable(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getDefaultEditable_" + jlocale + "_", null ); }
@Override protected android.text.method.MovementMethod getDefaultMovementMethod(){ if (!testjnOverride( "getDefaultMovementMethod" )) return super.getDefaultMovementMethod(); return (android.text.method.MovementMethod) jInterface.Jnido( this, jchildidx + "getDefaultMovementMethod_" + jlocale + "_", null ); }
@Override public void setText(java.lang.CharSequence arg1,android.widget.TextView.BufferType arg2) { if (!testjnOverride( "setText" )) { super.setText( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setSelection(int arg1,int arg2) { if (!testjnOverride( "setSelection" )) { super.setSelection( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setSelection_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setSelection(int arg1) { if (!testjnOverride( "setSelection" )) { super.setSelection( arg1); return; } jInterface.Jnido( this, jchildidx + "setSelection_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void selectAll(){ if (!testjnOverride( "selectAll" )) { super.selectAll(); return; } jInterface.Jnido( this, jchildidx + "selectAll_" + jlocale + "_", null ); }
@Override public void extendSelection(int arg1) { if (!testjnOverride( "extendSelection" )) { super.extendSelection( arg1); return; } jInterface.Jnido( this, jchildidx + "extendSelection_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setEllipsize(android.text.TextUtils.TruncateAt arg1) { if (!testjnOverride( "setEllipsize" )) { super.setEllipsize( arg1); return; } jInterface.Jnido( this, jchildidx + "setEllipsize_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
