package org.dykman.jn.android.test;
public class InstrumentationTestCase extends android.test.InstrumentationTestCase{
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
public InstrumentationTestCase(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void injectInstrumentation(android.app.Instrumentation arg1) { if (!testjnOverride( "injectInstrumentation" )) { super.injectInstrumentation( arg1); return; } jInterface.Jnido( this, jchildidx + "injectInstrumentation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void injectInsrumentation(android.app.Instrumentation arg1) { if (!testjnOverride( "injectInsrumentation" )) { super.injectInsrumentation( arg1); return; } jInterface.Jnido( this, jchildidx + "injectInsrumentation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.app.Instrumentation getInstrumentation(){ if (!testjnOverride( "getInstrumentation" )) return super.getInstrumentation(); return (android.app.Instrumentation) jInterface.Jnido( this, jchildidx + "getInstrumentation_" + jlocale + "_", null ); }
@Override public void runTestOnUiThread(java.lang.Runnable arg1) throws java.lang.Throwable { if (!testjnOverride( "runTestOnUiThread" )) { super.runTestOnUiThread( arg1); return; } jInterface.Jnido( this, jchildidx + "runTestOnUiThread_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void runTest() throws java.lang.Throwable{ if (!testjnOverride( "runTest" )) { super.runTest(); return; } jInterface.Jnido( this, jchildidx + "runTest_" + jlocale + "_", null ); }
@Override public void sendKeys(java.lang.String arg1) { if (!testjnOverride( "sendKeys" )) { super.sendKeys( arg1); return; } jInterface.Jnido( this, jchildidx + "sendKeys_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void sendKeys(int[] arg1) { if (!testjnOverride( "sendKeys" )) { super.sendKeys( arg1); return; } jInterface.Jnido( this, jchildidx + "sendKeys_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void sendRepeatedKeys(int[] arg1) { if (!testjnOverride( "sendRepeatedKeys" )) { super.sendRepeatedKeys( arg1); return; } jInterface.Jnido( this, jchildidx + "sendRepeatedKeys_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void tearDown() throws java.lang.Exception{ if (!testjnOverride( "tearDown" )) { super.tearDown(); return; } jInterface.Jnido( this, jchildidx + "tearDown_" + jlocale + "_", null ); }
}
