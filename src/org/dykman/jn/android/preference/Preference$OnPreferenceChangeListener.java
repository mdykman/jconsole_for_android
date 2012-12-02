package org.dykman.jn.android.preference;
public class Preference$OnPreferenceChangeListener implements android.preference.Preference.OnPreferenceChangeListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public Preference$OnPreferenceChangeListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public boolean onPreferenceChange(android.preference.Preference arg1,java.lang.Object arg2) { return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onPreferenceChange_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
