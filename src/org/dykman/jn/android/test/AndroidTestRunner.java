package org.dykman.jn.android.test;
public class AndroidTestRunner extends android.test.AndroidTestRunner{
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
public AndroidTestRunner(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void setTestClassName(java.lang.String arg1,java.lang.String arg2) { if (!testjnOverride( "setTestClassName" )) { super.setTestClassName( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setTestClassName_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setTest(junit.framework.Test arg1) { if (!testjnOverride( "setTest" )) { super.setTest( arg1); return; } jInterface.Jnido( this, jchildidx + "setTest_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void clearTestListeners(){ if (!testjnOverride( "clearTestListeners" )) { super.clearTestListeners(); return; } jInterface.Jnido( this, jchildidx + "clearTestListeners_" + jlocale + "_", null ); }
@Override public void addTestListener(junit.framework.TestListener arg1) { if (!testjnOverride( "addTestListener" )) { super.addTestListener( arg1); return; } jInterface.Jnido( this, jchildidx + "addTestListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected junit.framework.TestResult createTestResult(){ if (!testjnOverride( "createTestResult" )) return super.createTestResult(); return (junit.framework.TestResult) jInterface.Jnido( this, jchildidx + "createTestResult_" + jlocale + "_", null ); }
@Override public java.util.List getTestCases(){ if (!testjnOverride( "getTestCases" )) return super.getTestCases(); return (java.util.List) jInterface.Jnido( this, jchildidx + "getTestCases_" + jlocale + "_", null ); }
@Override public java.lang.String getTestClassName(){ if (!testjnOverride( "getTestClassName" )) return super.getTestClassName(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getTestClassName_" + jlocale + "_", null ); }
@Override public junit.framework.TestResult getTestResult(){ if (!testjnOverride( "getTestResult" )) return super.getTestResult(); return (junit.framework.TestResult) jInterface.Jnido( this, jchildidx + "getTestResult_" + jlocale + "_", null ); }
@Override public void runTest(){ if (!testjnOverride( "runTest" )) { super.runTest(); return; } jInterface.Jnido( this, jchildidx + "runTest_" + jlocale + "_", null ); }
@Override public void runTest(junit.framework.TestResult arg1) { if (!testjnOverride( "runTest" )) { super.runTest( arg1); return; } jInterface.Jnido( this, jchildidx + "runTest_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setContext(android.content.Context arg1) { if (!testjnOverride( "setContext" )) { super.setContext( arg1); return; } jInterface.Jnido( this, jchildidx + "setContext_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setInstrumentation(android.app.Instrumentation arg1) { if (!testjnOverride( "setInstrumentation" )) { super.setInstrumentation( arg1); return; } jInterface.Jnido( this, jchildidx + "setInstrumentation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setInstrumentaiton(android.app.Instrumentation arg1) { if (!testjnOverride( "setInstrumentaiton" )) { super.setInstrumentaiton( arg1); return; } jInterface.Jnido( this, jchildidx + "setInstrumentaiton_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected java.lang.Class loadSuiteClass(java.lang.String arg1) throws java.lang.ClassNotFoundException { if (!testjnOverride( "loadSuiteClass" )) return super.loadSuiteClass( arg1); return (java.lang.Class) jInterface.Jnido( this, jchildidx + "loadSuiteClass_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void testStarted(java.lang.String arg1) { if (!testjnOverride( "testStarted" )) { super.testStarted( arg1); return; } jInterface.Jnido( this, jchildidx + "testStarted_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void testEnded(java.lang.String arg1) { if (!testjnOverride( "testEnded" )) { super.testEnded( arg1); return; } jInterface.Jnido( this, jchildidx + "testEnded_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void testFailed(int arg1,junit.framework.Test arg2,java.lang.Throwable arg3) { if (!testjnOverride( "testFailed" )) { super.testFailed( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "testFailed_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override protected void runFailed(java.lang.String arg1) { if (!testjnOverride( "runFailed" )) { super.runFailed( arg1); return; } jInterface.Jnido( this, jchildidx + "runFailed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
