package org.dykman.jn.android.telephony.gsm;
public class SmsMessage extends android.telephony.gsm.SmsMessage{
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
public SmsMessage(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public java.lang.String getServiceCenterAddress(){ if (!testjnOverride( "getServiceCenterAddress" )) return super.getServiceCenterAddress(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getServiceCenterAddress_" + jlocale + "_", null ); }
@Override public java.lang.String getOriginatingAddress(){ if (!testjnOverride( "getOriginatingAddress" )) return super.getOriginatingAddress(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getOriginatingAddress_" + jlocale + "_", null ); }
@Override public java.lang.String getDisplayOriginatingAddress(){ if (!testjnOverride( "getDisplayOriginatingAddress" )) return super.getDisplayOriginatingAddress(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getDisplayOriginatingAddress_" + jlocale + "_", null ); }
@Override public java.lang.String getMessageBody(){ if (!testjnOverride( "getMessageBody" )) return super.getMessageBody(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getMessageBody_" + jlocale + "_", null ); }
@Override public java.lang.String getDisplayMessageBody(){ if (!testjnOverride( "getDisplayMessageBody" )) return super.getDisplayMessageBody(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getDisplayMessageBody_" + jlocale + "_", null ); }
@Override public java.lang.String getPseudoSubject(){ if (!testjnOverride( "getPseudoSubject" )) return super.getPseudoSubject(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getPseudoSubject_" + jlocale + "_", null ); }
@Override public long getTimestampMillis(){ if (!testjnOverride( "getTimestampMillis" )) return super.getTimestampMillis(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getTimestampMillis_" + jlocale + "_", null ); }
@Override public boolean isEmail(){ if (!testjnOverride( "isEmail" )) return super.isEmail(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isEmail_" + jlocale + "_", null ); }
@Override public java.lang.String getEmailBody(){ if (!testjnOverride( "getEmailBody" )) return super.getEmailBody(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getEmailBody_" + jlocale + "_", null ); }
@Override public java.lang.String getEmailFrom(){ if (!testjnOverride( "getEmailFrom" )) return super.getEmailFrom(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getEmailFrom_" + jlocale + "_", null ); }
@Override public int getProtocolIdentifier(){ if (!testjnOverride( "getProtocolIdentifier" )) return super.getProtocolIdentifier(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getProtocolIdentifier_" + jlocale + "_", null ); }
@Override public boolean isReplace(){ if (!testjnOverride( "isReplace" )) return super.isReplace(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isReplace_" + jlocale + "_", null ); }
@Override public boolean isCphsMwiMessage(){ if (!testjnOverride( "isCphsMwiMessage" )) return super.isCphsMwiMessage(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isCphsMwiMessage_" + jlocale + "_", null ); }
@Override public boolean isMWIClearMessage(){ if (!testjnOverride( "isMWIClearMessage" )) return super.isMWIClearMessage(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isMWIClearMessage_" + jlocale + "_", null ); }
@Override public boolean isMWISetMessage(){ if (!testjnOverride( "isMWISetMessage" )) return super.isMWISetMessage(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isMWISetMessage_" + jlocale + "_", null ); }
@Override public boolean isMwiDontStore(){ if (!testjnOverride( "isMwiDontStore" )) return super.isMwiDontStore(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isMwiDontStore_" + jlocale + "_", null ); }
@Override public byte[] getUserData(){ if (!testjnOverride( "getUserData" )) return super.getUserData(); return (byte[]) jInterface.Jnidoc( this, jchildidx + "getUserData_" + jlocale + "_", null ); }
@Override public byte[] getPdu(){ if (!testjnOverride( "getPdu" )) return super.getPdu(); return (byte[]) jInterface.Jnidoc( this, jchildidx + "getPdu_" + jlocale + "_", null ); }
@Override public int getStatusOnSim(){ if (!testjnOverride( "getStatusOnSim" )) return super.getStatusOnSim(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getStatusOnSim_" + jlocale + "_", null ); }
@Override public int getIndexOnSim(){ if (!testjnOverride( "getIndexOnSim" )) return super.getIndexOnSim(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getIndexOnSim_" + jlocale + "_", null ); }
@Override public int getStatus(){ if (!testjnOverride( "getStatus" )) return super.getStatus(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getStatus_" + jlocale + "_", null ); }
@Override public boolean isStatusReportMessage(){ if (!testjnOverride( "isStatusReportMessage" )) return super.isStatusReportMessage(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isStatusReportMessage_" + jlocale + "_", null ); }
@Override public boolean isReplyPathPresent(){ if (!testjnOverride( "isReplyPathPresent" )) return super.isReplyPathPresent(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isReplyPathPresent_" + jlocale + "_", null ); }
}
