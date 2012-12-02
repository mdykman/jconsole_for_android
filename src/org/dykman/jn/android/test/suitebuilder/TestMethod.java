package org.dykman.jn.android.test.suitebuilder;
public class TestMethod extends android.test.suitebuilder.TestMethod{
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
public TestMethod(java.lang.reflect.Method arg1,java.lang.Class arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public TestMethod(java.lang.String arg1,java.lang.Class arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public TestMethod(junit.framework.TestCase arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean equals(java.lang.Object arg1) { if (!testjnOverride( "equals" )) return super.equals( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "equals_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public int hashCode(){ if (!testjnOverride( "hashCode" )) return super.hashCode(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "hashCode_" + jlocale + "_", null ); }
@Override public java.lang.String getName(){ if (!testjnOverride( "getName" )) return super.getName(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getName_" + jlocale + "_", null ); }
@Override public java.lang.annotation.Annotation getAnnotation(java.lang.Class arg1) { if (!testjnOverride( "getAnnotation" )) return super.getAnnotation( arg1); return (java.lang.annotation.Annotation) jInterface.Jnido( this, jchildidx + "getAnnotation_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.Class getEnclosingClass(){ if (!testjnOverride( "getEnclosingClass" )) return super.getEnclosingClass(); return (java.lang.Class) jInterface.Jnido( this, jchildidx + "getEnclosingClass_" + jlocale + "_", null ); }
@Override public java.lang.String getEnclosingClassname(){ if (!testjnOverride( "getEnclosingClassname" )) return super.getEnclosingClassname(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getEnclosingClassname_" + jlocale + "_", null ); }
@Override public junit.framework.TestCase createTest() throws java.lang.reflect.InvocationTargetException,java.lang.IllegalAccessException,java.lang.InstantiationException{ if (!testjnOverride( "createTest" )) return super.createTest(); return (junit.framework.TestCase) jInterface.Jnido( this, jchildidx + "createTest_" + jlocale + "_", null ); }
}
