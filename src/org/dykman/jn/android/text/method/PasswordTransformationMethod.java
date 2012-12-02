package org.dykman.jn.android.text.method;
public class PasswordTransformationMethod extends android.text.method.PasswordTransformationMethod{
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
public PasswordTransformationMethod(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public java.lang.CharSequence getTransformation(java.lang.CharSequence arg1,android.view.View arg2) { if (!testjnOverride( "getTransformation" )) return super.getTransformation( arg1, arg2); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "getTransformation_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void beforeTextChanged(java.lang.CharSequence arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "beforeTextChanged" )) { super.beforeTextChanged( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "beforeTextChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void onTextChanged(java.lang.CharSequence arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "onTextChanged" )) { super.onTextChanged( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "onTextChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void afterTextChanged(android.text.Editable arg1) { if (!testjnOverride( "afterTextChanged" )) { super.afterTextChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "afterTextChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onFocusChanged(android.view.View arg1,java.lang.CharSequence arg2,boolean arg3,int arg4,android.graphics.Rect arg5) { if (!testjnOverride( "onFocusChanged" )) { super.onFocusChanged( arg1, arg2, arg3, arg4, arg5); return; } jInterface.Jnido( this, jchildidx + "onFocusChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
}
