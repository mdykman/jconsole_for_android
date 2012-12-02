package org.dykman.jn.android.text.method;
public class CharacterPickerDialog extends android.text.method.CharacterPickerDialog{
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
public CharacterPickerDialog(android.content.Context arg1,android.view.View arg2,android.text.Editable arg3,java.lang.String arg4,boolean arg5, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4, arg5); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override protected void onCreate(android.os.Bundle arg1) { if (!testjnOverride( "onCreate" )) { super.onCreate( arg1); return; } jInterface.Jnido( this, jchildidx + "onCreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onItemClick(android.widget.AdapterView arg1,android.view.View arg2,int arg3,long arg4) { if (!testjnOverride( "onItemClick" )) { super.onItemClick( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "onItemClick_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void onClick(android.view.View arg1) { if (!testjnOverride( "onClick" )) { super.onClick( arg1); return; } jInterface.Jnido( this, jchildidx + "onClick_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
