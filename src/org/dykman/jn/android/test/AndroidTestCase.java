package org.dykman.jn.android.test;
public class AndroidTestCase extends android.test.AndroidTestCase{
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
public AndroidTestCase(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public android.content.Context getContext(){ if (!testjnOverride( "getContext" )) return super.getContext(); return (android.content.Context) jInterface.Jnido( this, jchildidx + "getContext_" + jlocale + "_", null ); }
@Override protected void setUp() throws java.lang.Exception{ if (!testjnOverride( "setUp" )) { super.setUp(); return; } jInterface.Jnido( this, jchildidx + "setUp_" + jlocale + "_", null ); }
@Override protected void tearDown() throws java.lang.Exception{ if (!testjnOverride( "tearDown" )) { super.tearDown(); return; } jInterface.Jnido( this, jchildidx + "tearDown_" + jlocale + "_", null ); }
@Override public void testAndroidTestCaseSetupProperly(){ if (!testjnOverride( "testAndroidTestCaseSetupProperly" )) { super.testAndroidTestCaseSetupProperly(); return; } jInterface.Jnido( this, jchildidx + "testAndroidTestCaseSetupProperly_" + jlocale + "_", null ); }
@Override public void setContext(android.content.Context arg1) { if (!testjnOverride( "setContext" )) { super.setContext( arg1); return; } jInterface.Jnido( this, jchildidx + "setContext_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void assertActivityRequiresPermission(java.lang.String arg1,java.lang.String arg2,java.lang.String arg3) { if (!testjnOverride( "assertActivityRequiresPermission" )) { super.assertActivityRequiresPermission( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "assertActivityRequiresPermission_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void assertReadingContentUriRequiresPermission(android.net.Uri arg1,java.lang.String arg2) { if (!testjnOverride( "assertReadingContentUriRequiresPermission" )) { super.assertReadingContentUriRequiresPermission( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "assertReadingContentUriRequiresPermission_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void assertWritingContentUriRequiresPermission(android.net.Uri arg1,java.lang.String arg2) { if (!testjnOverride( "assertWritingContentUriRequiresPermission" )) { super.assertWritingContentUriRequiresPermission( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "assertWritingContentUriRequiresPermission_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void scrubClass(java.lang.Class arg1) throws java.lang.IllegalAccessException { if (!testjnOverride( "scrubClass" )) { super.scrubClass( arg1); return; } jInterface.Jnido( this, jchildidx + "scrubClass_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
