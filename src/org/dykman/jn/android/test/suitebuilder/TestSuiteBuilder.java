package org.dykman.jn.android.test.suitebuilder;
public class TestSuiteBuilder extends android.test.suitebuilder.TestSuiteBuilder{
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
public TestSuiteBuilder(java.lang.Class arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public TestSuiteBuilder(java.lang.String arg1,java.lang.ClassLoader arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.test.suitebuilder.TestSuiteBuilder includePackages(java.lang.String[] arg1) { if (!testjnOverride( "includePackages" )) return super.includePackages( arg1); return (android.test.suitebuilder.TestSuiteBuilder) jInterface.Jnido( this, jchildidx + "includePackages_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.test.suitebuilder.TestSuiteBuilder excludePackages(java.lang.String[] arg1) { if (!testjnOverride( "excludePackages" )) return super.excludePackages( arg1); return (android.test.suitebuilder.TestSuiteBuilder) jInterface.Jnido( this, jchildidx + "excludePackages_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.test.suitebuilder.TestSuiteBuilder addRequirements(java.util.List arg1) { if (!testjnOverride( "addRequirements" )) return super.addRequirements( arg1); return (android.test.suitebuilder.TestSuiteBuilder) jInterface.Jnido( this, jchildidx + "addRequirements_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.test.suitebuilder.TestSuiteBuilder named(java.lang.String arg1) { if (!testjnOverride( "named" )) return super.named( arg1); return (android.test.suitebuilder.TestSuiteBuilder) jInterface.Jnido( this, jchildidx + "named_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected java.lang.String getSuiteName(){ if (!testjnOverride( "getSuiteName" )) return super.getSuiteName(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getSuiteName_" + jlocale + "_", null ); }
}
