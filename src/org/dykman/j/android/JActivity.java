package org.dykman.j.android;

import java.io.File;

import org.dykman.j.ExecutionListener;

import android.app.AlertDialog;
import android.content.DialogInterface;
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

		Intent ii = new Intent(getIntent());
		theApp.addFile(JCONSOLE, ii);
		theApp.setConsoleState(true);
		/*
		if(savedInstanceState != null) {
			console.setText(savedInstanceState.getCharSequence("console"));
			int n = savedInstanceState.getInt("cursor");
			console.setSelection(n);
		}
		*/
	}
	public void quit() {
		this.finish();
		int pid = android.os.Process.myPid();
		android.os.Process.killProcess(pid);
	}
	public void testQuit() {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		builder.setMessage("Are you sure you want to exit J?")
			.setCancelable(false)
			.setPositiveButton("Yes",
				new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int id) {
						quit();
					}
				})
			.setNegativeButton("No", new DialogInterface.OnClickListener() {
				public void onClick(DialogInterface dialog, int id) {
					dialog.cancel();
				}
			});
		AlertDialog dialog = builder.create();
		dialog.show();
		
	}

	@Override
	public void finish() {
		super.finish();
	}
	@Override
	public void onPostCreate(Bundle savedInstanceState) {
		super.onPostCreate(savedInstanceState);
		theApp.setup(this,console);
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
	protected void callBreak() {
		theApp.getjInterface().callSuperJ(new String[]{"break_z_ ''"});
	}
	
	@Override
	public boolean onMenuItemSelected(int featureId, MenuItem item) {
		boolean result = true;
		int itemId = item.getItemId();
		Log.d(JConsoleApp.LogTag,"selection " + itemId + ", " + getClass().getName());
		switch(itemId) {
			case R.id.clear:   console.clear();                break;
			case R.id.jbreak:  callBreak();                   break;
			case R.id.exit:    testQuit();					  break;
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