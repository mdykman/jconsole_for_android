package org.dykman.jn.android.preference;
public class PreferenceManager$OnActivityDestroyListener implements android.preference.PreferenceManager.OnActivityDestroyListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public PreferenceManager$OnActivityDestroyListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onActivityDestroy(){ jInterface.Jnido( this, jchildidx + "onActivityDestroy_" + jlocale + "_", null ); }
}
