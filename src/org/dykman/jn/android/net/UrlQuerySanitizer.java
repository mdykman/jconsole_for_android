package org.dykman.jn.android.net;
public class UrlQuerySanitizer extends android.net.UrlQuerySanitizer{
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
public UrlQuerySanitizer(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public UrlQuerySanitizer(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void clear(){ if (!testjnOverride( "clear" )) { super.clear(); return; } jInterface.Jnido( this, jchildidx + "clear_" + jlocale + "_", null ); }
@Override public java.lang.String getValue(java.lang.String arg1) { if (!testjnOverride( "getValue" )) return super.getValue( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getValue_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String unescape(java.lang.String arg1) { if (!testjnOverride( "unescape" )) return super.unescape( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "unescape_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setUnregisteredParameterValueSanitizer(android.net.UrlQuerySanitizer.ValueSanitizer arg1) { if (!testjnOverride( "setUnregisteredParameterValueSanitizer" )) { super.setUnregisteredParameterValueSanitizer( arg1); return; } jInterface.Jnido( this, jchildidx + "setUnregisteredParameterValueSanitizer_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void parseUrl(java.lang.String arg1) { if (!testjnOverride( "parseUrl" )) { super.parseUrl( arg1); return; } jInterface.Jnido( this, jchildidx + "parseUrl_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void parseQuery(java.lang.String arg1) { if (!testjnOverride( "parseQuery" )) { super.parseQuery( arg1); return; } jInterface.Jnido( this, jchildidx + "parseQuery_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.util.Set getParameterSet(){ if (!testjnOverride( "getParameterSet" )) return super.getParameterSet(); return (java.util.Set) jInterface.Jnido( this, jchildidx + "getParameterSet_" + jlocale + "_", null ); }
@Override public java.util.List getParameterList(){ if (!testjnOverride( "getParameterList" )) return super.getParameterList(); return (java.util.List) jInterface.Jnido( this, jchildidx + "getParameterList_" + jlocale + "_", null ); }
@Override public boolean hasParameter(java.lang.String arg1) { if (!testjnOverride( "hasParameter" )) return super.hasParameter( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasParameter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void registerParameter(java.lang.String arg1,android.net.UrlQuerySanitizer.ValueSanitizer arg2) { if (!testjnOverride( "registerParameter" )) { super.registerParameter( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "registerParameter_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void registerParameters(java.lang.String[] arg1,android.net.UrlQuerySanitizer.ValueSanitizer arg2) { if (!testjnOverride( "registerParameters" )) { super.registerParameters( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "registerParameters_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setAllowUnregisteredParamaters(boolean arg1) { if (!testjnOverride( "setAllowUnregisteredParamaters" )) { super.setAllowUnregisteredParamaters( arg1); return; } jInterface.Jnido( this, jchildidx + "setAllowUnregisteredParamaters_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean getAllowUnregisteredParamaters(){ if (!testjnOverride( "getAllowUnregisteredParamaters" )) return super.getAllowUnregisteredParamaters(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getAllowUnregisteredParamaters_" + jlocale + "_", null ); }
@Override public void setPreferFirstRepeatedParameter(boolean arg1) { if (!testjnOverride( "setPreferFirstRepeatedParameter" )) { super.setPreferFirstRepeatedParameter( arg1); return; } jInterface.Jnido( this, jchildidx + "setPreferFirstRepeatedParameter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean getPreferFirstRepeatedParameter(){ if (!testjnOverride( "getPreferFirstRepeatedParameter" )) return super.getPreferFirstRepeatedParameter(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getPreferFirstRepeatedParameter_" + jlocale + "_", null ); }
@Override protected void parseEntry(java.lang.String arg1,java.lang.String arg2) { if (!testjnOverride( "parseEntry" )) { super.parseEntry( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "parseEntry_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void addSanitizedEntry(java.lang.String arg1,java.lang.String arg2) { if (!testjnOverride( "addSanitizedEntry" )) { super.addSanitizedEntry( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "addSanitizedEntry_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected boolean isHexDigit(char arg1) { if (!testjnOverride( "isHexDigit" )) return super.isHexDigit( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isHexDigit_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected int decodeHexDigit(char arg1) { if (!testjnOverride( "decodeHexDigit" )) return super.decodeHexDigit( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "decodeHexDigit_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}