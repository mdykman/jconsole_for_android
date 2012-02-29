package org.dykman.j;

import java.util.ArrayList;
import java.util.List;

import org.dykman.j.android.JConsoleApp;

import android.util.Log;

public class JInterface {

	/// output format constants from jlib.h
	public static final int MTYOFM	 =	1;	/* formatted result array output */
	public static final int MTYOER	 =	2;	/* error output */
	public static final int MTYOLOG	 =	3;	/* output log */
	public static final int MTYOSYS	 =	4;	/* system assertion failure */
	public static final int MTYOEXIT =	5;	/* exit */
	public static final int MTYOFILE =	6;	/* output 1!:2[2 */
	
	public static final String LOGTAG = "j-interface";

	private long nativeInstance = 0L;

	private List<ExecutionListener> execlist = new ArrayList<ExecutionListener>();
	private List<OutputListener> outputs = new ArrayList<OutputListener>();

    public int callJ(String s) {
    	int result = -1;
    	try {
    		if(nativeInstance == 0L) {
	    		synchronized(this) {
			    	if(nativeInstance == 0L) {
			    			nativeInstance = initializeJ();
			    	}
	    		}
    		}
	    	result = callJNative(nativeInstance,s);
	    	
    	} catch(Throwable e) {
    		Log.e(JConsoleApp.LogTag, "error executing sentence: " + s, e);
    	} finally { 
	    	for(ExecutionListener l : execlist) {
	    		l.onCommandComplete(result);
	    	}
    	}
    	return result;
    }

    protected synchronized long initializeJ() {
    	return initializeJNative();
    }
    
    public synchronized void destroyJ() {
    	if(nativeInstance != 0L) {
    		destroyJNative(nativeInstance);
    		nativeInstance = 0L;
    	}
    }
	public Object getVariable(String ident) {
		return getVariableNative(nativeInstance, ident);
	}

	public void reset() {
    	if(nativeInstance != 0L) {
    		synchronized(this) {
	        	if(nativeInstance != 0L) {
		    		nativeInstance = 0L;
		    		destroyJ();
	        	}
	        	nativeInstance = initializeJ();
    		}
    	}
	}

    public void addExecutionListener(ExecutionListener listener) {
		if(!execlist.contains(listener)) {
			execlist.add(listener);
		}
	}
	public void removeExecutionListener(ExecutionListener listener) {
		if(execlist.contains(listener)) {
			execlist.remove(listener);
		}
	}
	
	public void addOutputListener(OutputListener listener) {
		if(!outputs.contains(listener)) {
			outputs.add(listener);
		}
	}
	
	public void removeOutputListener(OutputListener listener) {
		if(outputs.contains(listener)) {
			outputs.remove(listener);
		}
	}
/// not implemented, returns null
    native public Object getVariableNative(long inst,String name); 
  /// not implemented, returns null
    native public void setVariableNative(long inst,String name, Object value); 
	
    native public int callJNative(long inst,String s); 
    native public void destroyJNative(long inst); 
    native public long initializeJNative();

// to be called back from library    
    public void output(int type,String s) {
    	for(OutputListener oo : outputs) {
    		oo.onOutput(type,s);
    	}
    }
    
    static {
    	try {
    		// shipped with application
    		System.loadLibrary("j");
    	} catch(Exception e) {
    		Log.e("J-interface", "failed to load j shared object", e);
    	}
    }

}
