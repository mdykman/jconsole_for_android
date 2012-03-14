package org.dykman.j.android;

import java.io.File;

import org.dykman.j.ExecutionListener;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;

public class JActivity extends AbstractActivity implements ExecutionListener {
	Console console;
//	ViewGroup container = null;
    File root;
	JConsoleApp theApp;
	public static final String JCONSOLE = "J Console";
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
//		container = (ViewGroup) findViewById(R.id.mainLayout);
		theApp = (JConsoleApp) this.getApplication();
		console = (Console) findViewById(R.id.ws);
		console.setJActivity(this);

		theApp.setup(this,console);
		Intent ii = new Intent(getIntent());
		theApp.addFile(JCONSOLE, ii);
		/*
		if(savedInstanceState != null) {
			console.setText(savedInstanceState.getCharSequence("console"));
			int n = savedInstanceState.getInt("cursor");
			console.setSelection(n);
		}
		*/
	}
	@Override
	public void onBackPressed() {
		testQuit();
	}
	@Override
	public void onRestoreInstanceState(Bundle savedInstanceState) {
		console.setText(savedInstanceState.getCharSequence("console"));
		int n = savedInstanceState.getInt("cursor");
		console.setSelection(n);

	}
	@Override
	public void onSaveInstanceState(Bundle outState) {
		int pos = console.getSelectionStart();
		outState.putCharSequence("console",console.getText());
		outState.putInt("cursor",pos);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = this.getMenuInflater();
		inflater.inflate(R.menu.main, menu);
		return true;
	}
	
	@Override
	public boolean onMenuItemSelected(int featureId, MenuItem item) {
		boolean result = true;
		int itemId = item.getItemId();
		Log.d(JConsoleApp.LogTag,"selection " + itemId + ", " + getClass().getName());
		switch(itemId) {
			case R.id.clear:   console.clear();                break;
			case R.id.jbreak:  callBreak();                   break;
			default : result = false;
		}
		if(!result) {
			result = super.onMenuItemSelected(featureId, item);
		}
		return result;
	}
	
	protected FileEdit getEditor() {
		return console;
	}
	@Override
	protected void onDestroy() {
		theApp.setConsoleState(false);
		if(isFinishing()) {
			theApp.getjInterface().destroyJ();
		}
		super.onDestroy();
	}

	public void onCommandComplete(int code) {
		Log.d(JConsoleApp.LogTag, "commandComplete receives " + code);
	}
}