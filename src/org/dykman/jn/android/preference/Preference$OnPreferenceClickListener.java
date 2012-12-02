package org.dykman.jn.android.preference;
public class Preference$OnPreferenceClickListener implements android.preference.Preference.OnPreferenceClickListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public Preference$OnPreferenceClickListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onPreferenceClick(android.preference.Preference arg1) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onPreferenceClick_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
