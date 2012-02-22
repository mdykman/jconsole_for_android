package org.dykman.j.android;

import java.io.File;
import java.io.IOException;

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
		console.setActivity(this);

		theApp.setup(this,console);
		Intent ii = new Intent(getIntent());
		theApp.addFile(JCONSOLE, ii);
		if(savedInstanceState != null) {
			console.setText(savedInstanceState.getCharSequence("console"));
			int n = savedInstanceState.getInt("cursor");
			console.setSelection(n);
		}
	}
	@Override
	public void onBackPressed() {
		testQuit();
	}
	public String buildTitle(File f)  throws IOException {
		return JCONSOLE;
	}

	/*
	public ViewGroup getContainer() {
		return container;
	}
	*/
	@Override
	public void onRestoreInstanceState(Bundle outState) {
	}
	@Override
	public void onSaveInstanceState(Bundle outState) {
		int pos = console.getSelectionStart();
		outState.putCharSequence("console",console.getText());
		outState.putInt("cursor",pos);
//		outState.putParcelable("console", console);
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
			case R.id.clear:   clearConsole();                break;
			case R.id.jbreak:  callBreak();                   break;
			case R.id.reset:   theApp.reset();                break;
			default : result = false;
		}
		if(!result) {
			result = super.onMenuItemSelected(featureId, item);
		}
		return result;
	}
	
/*
	@Override
	public boolean onMenuItemSelected(int featureId, MenuItem item) {
		boolean result = true;
		switch(item.getItemId()) {
			case R.id.reset:   reset();                       break;
			case R.id.clear:   clearConsole();                break;
			case R.id.newf:    newFile();                     break;
//			case R.id.open:    requestFileOpen(); 	          break;
			case R.id.open:    {
				requestFileOpen(); 	          
				break;
			}
			case R.id.window:  requestWindowSelect();     	  break;
			case R.id.jbreak:  callBreak();                   break;
			case R.id.save:    saveCurrent();                 break;
			case R.id.saveas:  requestFileSaveAs();           break;
			case R.id.close:   theApp.closeCurrent();         break;
			case R.id.exit:    testQuit();					  break;
			case R.id.log:     showHistoryDialog();			  break;
			case R.id.runl:    runCurrentLine();              break;
			case R.id.runc:    theApp.runCurrentFile(console); break; 
			case R.id.runf:    requestFileRun();              break;
			case R.id.vocab:   showHelp(R.string.help_start); break;
			case R.id.learning: showHelp(R.string.learning);  break;
			case R.id.readme:  showTextFile(R.string.readme); break;
			case R.id.aboutj:  showTextFile(R.string.aboutj); break;
			default: result = false;
		}
		return result;
	}
*/
	/*

	public void newFile() {
		File tmp = new File(root, tempDir);
		int i = 1;
		File newf = new File(tmp, Integer.toString(i) + ".ijs");
		while (theApp.hasEditor(newf.getName()) || newf.exists()) {
			newf = new File(tmp, Integer.toString(++i) + ".ijs");
		}
		EditorData data = openEditor(newf);
		theApp.setWindow(data, data.name);
	}
*/
	protected FileEdit getEditor() {
		return console;
	}
	@Override
	protected void onDestroy() {
		theApp.setConsoleState(false);
//		theApp.getCurrentEditor().markCursor();
//		jInterface.removeExecutionListener(this);
		if(isFinishing()) {
			theApp.getjInterface().destroyJ();
		}
		super.onDestroy();
	}

	public void onCommandComplete(int code) {
		Log.d(JConsoleApp.LogTag, "commandComplete receives " + code);
	}
	class EngineOutput {
		int type;
		String content;

		EngineOutput(int type, String content) {
			this.type = type;
			this.content = content;
		}
	}
/*
	public void reset() {
		Toast.makeText(this, "resetting console", Toast.LENGTH_SHORT).show();

		theApp.getjInterface().reset();
		console.replaceText("");
		theApp.bootStrapSession(this,"''");
//		console.prompt();
		InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
		imm.restartInput(console);
	}
	*/
}