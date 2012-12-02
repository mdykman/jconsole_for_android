package org.dykman.jn.android.test;
public class InstrumentationTestRunner extends android.test.InstrumentationTestRunner{
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
public InstrumentationTestRunner(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public java.lang.ClassLoader getLoader(){ if (!testjnOverride( "getLoader" )) return super.getLoader(); return (java.lang.ClassLoader) jInterface.Jnido( this, jchildidx + "getLoader_" + jlocale + "_", null ); }
@Override public void onCreate(android.os.Bundle arg1) { if (!testjnOverride( "onCreate" )) { super.onCreate( arg1); return; } jInterface.Jnido( this, jchildidx + "onCreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected android.test.AndroidTestRunner getAndroidTestRunner(){ if (!testjnOverride( "getAndroidTestRunner" )) return super.getAndroidTestRunner(); return (android.test.AndroidTestRunner) jInterface.Jnido( this, jchildidx + "getAndroidTestRunner_" + jlocale + "_", null ); }
@Override public void onStart(){ if (!testjnOverride( "onStart" )) { super.onStart(); return; } jInterface.Jnido( this, jchildidx + "onStart_" + jlocale + "_", null ); }
@Override public junit.framework.TestSuite getTestSuite(){ if (!testjnOverride( "getTestSuite" )) return super.getTestSuite(); return (junit.framework.TestSuite) jInterface.Jnido( this, jchildidx + "getTestSuite_" + jlocale + "_", null ); }
@Override public junit.framework.TestSuite getAllTests(){ if (!testjnOverride( "getAllTests" )) return super.getAllTests(); return (junit.framework.TestSuite) jInterface.Jnido( this, jchildidx + "getAllTests_" + jlocale + "_", null ); }
}
