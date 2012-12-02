package org.dykman.jn.android.widget;
public class MultiAutoCompleteTextView extends android.widget.MultiAutoCompleteTextView{
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
public MultiAutoCompleteTextView(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public MultiAutoCompleteTextView(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public MultiAutoCompleteTextView(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setTokenizer(android.widget.MultiAutoCompleteTextView.Tokenizer arg1) { if (!testjnOverride( "setTokenizer" )) { super.setTokenizer( arg1); return; } jInterface.Jnido( this, jchildidx + "setTokenizer_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void performFiltering(java.lang.CharSequence arg1,int arg2) { if (!testjnOverride( "performFiltering" )) { super.performFiltering( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "performFiltering_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void performFiltering(java.lang.CharSequence arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "performFiltering" )) { super.performFiltering( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "performFiltering_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public boolean enoughToFilter(){ if (!testjnOverride( "enoughToFilter" )) return super.enoughToFilter(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "enoughToFilter_" + jlocale + "_", null ); }
@Override public void performValidation(){ if (!testjnOverride( "performValidation" )) { super.performValidation(); return; } jInterface.Jnido( this, jchildidx + "performValidation_" + jlocale + "_", null ); }
@Override protected void replaceText(java.lang.CharSequence arg1) { if (!testjnOverride( "replaceText" )) { super.replaceText( arg1); return; } jInterface.Jnido( this, jchildidx + "replaceText_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
