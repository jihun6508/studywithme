package org.studywithme.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

public class changetime {
	public String time_longtoString(long time){
		boolean minuscheck = false;
		if(time < 0) minuscheck = true;
		int hour = Math.abs((int)time/60);
		int min = Math.abs((int)time%60);
		String strhour = Integer.toString(hour);
		String strmin = Integer.toString(min);

		if(hour < 10)
			strhour = '0' + strhour;

		if(min < 10)
			strmin = '0' + strmin;

		if(minuscheck)
			strhour = '-' + strhour;
		return strhour + ":" + strmin;
	}
	
	public String convertToKoreanDate(Date date) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        dateFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
        String koreanDate = dateFormat.format(date);
        return koreanDate;
    }
}
