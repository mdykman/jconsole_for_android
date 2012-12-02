package org.dykman.jn.android.content;
public class SharedPreferences$OnSharedPreferenceChangeListener2 implements android.content.SharedPreferences.OnSharedPreferenceChangeListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public SharedPreferences$OnSharedPreferenceChangeListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onSharedPreferenceChanged(android.content.SharedPreferences arg1,java.lang.String arg2) { jInterface.Jnido( this, "onSharedPreferenceChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
