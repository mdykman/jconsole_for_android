package org.dykman.j.android;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.dykman.j.JInterface;

import android.util.Log;

public class AndroidJInterface extends JInterface {
	
	int downloadFile(String urlS, String fileS) {
		
		int result = -1;
		try {
			Map<String, String> nv = System.getenv();
			
			for(Map.Entry<String, String> en : nv.entrySet() ) {
				Log.d(LOGTAG,"env: " + en.getKey() + "=" + en.getValue());
			}
			URL url = new URL(urlS);
			File file = new File(fileS);
			if(! file.canWrite()) {
				Log.e(LOGTAG,"failed to download, file is not writeable: " 
						 + file.getPath());
				return -2;
			}
			HttpGet get = new HttpGet(url.toURI());
			HttpClient client = new DefaultHttpClient();
			HttpResponse response = client.execute(get);
			HttpEntity entity = response.getEntity();
			InputStream in = entity.getContent();
			OutputStream out = new FileOutputStream(file);
			byte [] buff = new byte[8092];
			int s;
			while((s = in.read(buff)) != -1) {
				out.write(buff,0,s);
			}
			result = (int)entity.getContentLength();
			out.close();
			
		} catch(MalformedURLException e) {
			Log.e(LOGTAG,"failed to download file due to malformed url: " + urlS);
			result = -3;
		} catch(IOException e) {
			Log.e(LOGTAG,"failed to download file due to IOException: " + e.getLocalizedMessage());
			result = -4;
		} catch(Exception e) {
			Log.e(LOGTAG,"failed to download file." ,e);
			result = -1;
		}
		
		return result;
	}

}
