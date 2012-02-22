package org.dykman.j.android;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android.app.Activity;
import android.content.Context;
import android.text.Editable;
import android.util.AttributeSet;
import android.util.Log;
import android.widget.EditText;

public class FileEdit extends EditText {

	boolean textChanged = false;
	int cursorPosition = 0;
//	File file;
	String name;
	protected Activity jActivity;

	public void setActivity(Activity activity) {
		jActivity = activity;
	}
	public FileEdit(Context context, AttributeSet attrs, int defStyle) {
		super(context,attrs,defStyle);
//		this.jActivity = (JActivity)jActivity;
//		init();
	}
	
	public FileEdit(Context context, AttributeSet attrs) {
		super(context,attrs);
//		this.jActivity = (JActivity)jActivity;
//		init();
	}
	
	public FileEdit(Context jActivity) {
		super(jActivity);
//		this.jActivity = (JActivity)jActivity;
//		init();
	}
	/*
	public File getFile() {
		return file;
	}
	 */
	public void setName(String s) {
		Log.d(JConsoleApp.LogTag,"setname: " + s);
		name =s ;
	}
	
	public String getName() {
		return name;
	}
	
	public String getLineForPosition(int n) {
		StringBuilder sb = new StringBuilder(getText());
		int start = sb.lastIndexOf("\n", n);
		int end = sb.indexOf("\n", start + 1);
		return sb.substring(start + 1, end == -1 ? sb.length() : end);
	}

	public void markCursor() {
		cursorPosition = getSelectionStart();
	}
	
	public void restoreCursor() {
		setSelection(cursorPosition);
	}
	/*
	public void setFile(File file) {
		this.file = file;
	}
	*/
	public boolean isTextChanged() {
		return textChanged;
	}
	public void setTextChanged(boolean b) {
		textChanged = b;
	}
	/*
	final private void init() {
		ViewGroup.LayoutParams params = new ViewGroup.LayoutParams(
			ViewGroup.LayoutParams.MATCH_PARENT,
			ViewGroup.LayoutParams.MATCH_PARENT);
//		setLayoutParams(params);
//		setGravity(Gravity.TOP);
		setTypeface(Typeface.MONOSPACE);
		setHorizontallyScrolling(true);
		this.setFreezesText(true);
	}
*/
	public void open(File f) throws IOException {
/*
		if(f != null) {
			this.file = f;
		}
*/
		ByteArrayOutputStream bb = new ByteArrayOutputStream();
		byte[] buf = new byte[4096];
		if(f.exists()) {
			InputStream in = new FileInputStream(f);
			int n;
			while((n = in.read(buf)) != -1) {
				bb.write(buf, 0, n);
			}
			in.close();
			beginBatchEdit();
			setTextKeepState(bb.toString());
			endBatchEdit();
		}
		if(getText().length() > 0) {
			this.setSelection(1);
		}
		this.setSelection(0);
		textChanged = false;
	}
	
	public void appendSeq(CharSequence seq) {
		Editable sp = getText();
		beginBatchEdit();
		sp.append(seq);
		endBatchEdit();
	}

	public void save(File file) throws IOException {
		if(textChanged) {
			OutputStream out = new FileOutputStream(file);
			out.write(getText().toString().getBytes());
			out.close();
			textChanged = false;
		}
	}
	
	public String createTitle() {
		String n = getName();
		if(n != null) {
			StringBuilder sb = new StringBuilder(getName());
			if(textChanged) {
				sb.append(" *");
			}
			return sb.toString();
		}
		else {
			return null;
		}
	}
	
	public boolean getTextChanged() {
		return textChanged;
	}
	
	@Override
	public void onTextChanged(CharSequence seq,int start, int lengthBefore, int lengthAfter) {
		if(textChanged == false) {
			String tit = createTitle();
			if(tit != null) {
				textChanged = true;
				tit = createTitle();
				jActivity.setTitle(tit);
			}
		}
	}
}
