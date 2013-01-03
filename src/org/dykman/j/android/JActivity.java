package org.dykman.j.android;

import java.io.File;

import org.dykman.j.ExecutionListener;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
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

//  private Handler timerHandler = new Handler();
  private Handler[] timerHandler = { new Handler(), new Handler(), new Handler(), new Handler(), new Handler(), new Handler(), new Handler(), new Handler(), new Handler(), new Handler(), new Handler()};
  private long[] timerInterval = {0,0,0,0,0,0,0,0,0,0,0};
  private String[] timerVerb = {null,null,null,null,null,null,null,null,null,null,"sys_timer_z_"};

  private Runnable[] timerTask = {null,null,null,null,null,null,null,null,null,null,null};

  public JActivity () {
  timerTask[0] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[0], null);
       if (timerInterval[0] > 0) timerHandler[0].postDelayed(this, timerInterval[0]);
     }
   };

  timerTask[1] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[1], null);
       if (timerInterval[1] > 0) timerHandler[1].postDelayed(this, timerInterval[1]);
     }
   };

  timerTask[2] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[2], null);
       if (timerInterval[2] > 0) timerHandler[2].postDelayed(this, timerInterval[2]);
     }
   };

  timerTask[3] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[3], null);
       if (timerInterval[3] > 0) timerHandler[3].postDelayed(this, timerInterval[3]);
     }
   };

  timerTask[4] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[4], null);
       if (timerInterval[4] > 0) timerHandler[4].postDelayed(this, timerInterval[4]);
     }
   };

  timerTask[5] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[5], null);
       if (timerInterval[5] > 0) timerHandler[5].postDelayed(this, timerInterval[5]);
     }
   };

  timerTask[6] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[6], null);
       if (timerInterval[6] > 0) timerHandler[6].postDelayed(this, timerInterval[6]);
     }
   };

  timerTask[7] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[7], null);
       if (timerInterval[7] > 0) timerHandler[7].postDelayed(this, timerInterval[7]);
     }
   };

  timerTask[8] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[8], null);
       if (timerInterval[8] > 0) timerHandler[8].postDelayed(this, timerInterval[8]);
     }
   };

  timerTask[9] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[9], null);
       if (timerInterval[9] > 0) timerHandler[9].postDelayed(this, timerInterval[9]);
     }
   };

  timerTask[10] = new Runnable() {
     public void run() {
       JConsoleApp.theApp.jInterface.Jnido( this, timerVerb[10], null);
       if (timerInterval[10] > 0) timerHandler[10].postDelayed(this, timerInterval[10]);
     }
   };
  }

	public void setjtimer(int i, int time, String verb) {
    if (i > 10 || i < 0) return;
    timerHandler[i].removeCallbacks(timerTask[i]);
    timerInterval[i]  = Math.max (0l, (long)time);
    if (verb != null && verb.length() > 0 && verb.trim().length() > 0) timerVerb[i]  = verb;
    if (timerVerb[i] != null && (timerInterval[i] > 0))
      timerHandler[i].postDelayed(timerTask[i], timerInterval[i]);
  }
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
//		container = (ViewGroup) findViewById(R.id.mainLayout);
		theApp = (JConsoleApp) this.getApplication();
		console = (Console) findViewById(R.id.ws);
		console.setJActivity(this);

		Intent ii = new Intent(getIntent());
		ii.setFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
		theApp.addIntent(JCONSOLE, ii);
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

	@Override
	public boolean onMenuItemSelected(int featureId, MenuItem item) {
		boolean result = true;
		int itemId = item.getItemId();
		Log.d(JConsoleApp.LogTag,"selection " + itemId + ", " + getClass().getName());
		switch(itemId) {
			case R.id.clear:   console.clear();                break;
			case R.id.jbreak:  theApp.jInterface.callBreak();                   break;
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
