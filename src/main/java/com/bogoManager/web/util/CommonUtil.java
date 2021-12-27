/**
 *  Base64인코딩/디코딩 방식을 이용한 데이터를 암호화/복호화하는 Business Interface class
 */
package com.bogoManager.web.util;

import java.lang.reflect.Array;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.codec.binary.Base64;

public class CommonUtil {

	static int pageStartNumBase = 0;
	public static int pageCutBaseNum = 10;

    /**
     * lang이 포함된 locale의 Locale ID를 담는다.
     * @param lang
     * @param langs
     * @return
     */
    public static List<String> localeMatchesLangList(String lang, List<String> langs){
		//returns array of all locales
        Locale[] localeList = SimpleDateFormat.getAvailableLocales();

        if(langs==null) {
        	langs = new ArrayList<String>();
        }

    	for (Locale locale : localeList) {
    		if(locale.toString().matches(".*"+lang+".*")){
            	langs.add("_" + locale.toString());
    		}
    	}
    	return langs;
	}
    /**
     * 값이 있는지 없는지 체크
     * obj == null or obj == '' 인경우 false
     * obj != null or obj != '' 인경우 true
     *
     * @param String data 암호화할 비밀번호
     * @return String result 암호화된 비밀번호
     * @exception Exception     *
     */
    @SuppressWarnings("rawtypes")
	public static boolean isEmpty(Object obj){
        if( obj instanceof String ) return obj==null || "".equals(obj.toString().trim());
        else if( obj instanceof List ) return obj==null || ((List)obj).isEmpty();
        else if( obj instanceof Map ) return obj==null || ((Map)obj).isEmpty();
        else if( obj instanceof Object[] ) return obj==null || Array.getLength(obj)==0;
        else return obj==null;
    }

    public static boolean isNotEmpty(Object s){
        return !isEmpty(s);
    }

    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용)
     *
     * @param String data 암호화할 비밀번호
     * @return String result 암호화된 비밀번호
     * @exception Exception
     */
    public static String encryptPassword(String data) throws Exception {
		if (data == null) {
		    return "";
		}

		byte[] plainText = null; // 평문
		byte[] hashValue = null; // 해쉬값
		plainText = data.getBytes();

		MessageDigest md = MessageDigest.getInstance("SHA-256");
		hashValue = md.digest(plainText);

		/*
		BASE64Encoder encoder = new BASE64Encoder();
		return encoder.encode(hashValue);
		*/
		return new String(Base64.encodeBase64(hashValue));
    }

    /**
     * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용)
     * @param data 암호화할 비밀번호
     * @param salt Salt
     * @return 암호화된 비밀번호
     * @throws Exception
     */
    public static String encryptPassword(String data, byte[] salt) throws Exception {

		if (data == null) {
		    return "";
		}

		byte[] hashValue = null; // 해쉬값

		MessageDigest md = MessageDigest.getInstance("SHA-256");

		md.reset();
		md.update(salt);
		hashValue = md.digest(data.getBytes());

		return new String(Base64.encodeBase64(hashValue));
    }

    /**
     * 비밀번호를 암호화된 패스워드 검증(salt가 사용된 경우만 적용).
     *
     * @param data 원 패스워드
     * @param encoded 해쉬처리된 패스워드(Base64 인코딩)
     * @return
     * @throws Exception
     */
    public static boolean checkPassword(String data, String encoded, byte[] salt) throws Exception {
    	byte[] hashValue = null; // 해쉬값

    	MessageDigest md = MessageDigest.getInstance("SHA-256");

    	md.reset();
    	md.update(salt);
    	hashValue = md.digest(data.getBytes());

    	return MessageDigest.isEqual(hashValue, Base64.decodeBase64(encoded.getBytes()));
    }
	public static HashMap<String, Object> pagingNumCheck(HashMap<String, Object> paramMap, Integer pageDataTotal) {
    	String cutNumTxt = (String) paramMap.get("pageCut");
    	String pageNumTxt = (String) paramMap.get("pageNum");
    	Integer cutNum = pageCutBaseNum;
    	Integer pageNum = pageStartNumBase+1;

    	if(pageNumTxt!=null && !pageNumTxt.equals("")){
    		pageNum = Integer.parseInt(pageNumTxt);
    	}
    	if(cutNumTxt!=null){
        	cutNum = Integer.parseInt(cutNumTxt);
    	}
    	int pageTotal = (int) Math.ceil((float)pageDataTotal/(float)cutNum);

    	int pageStart = pageNum-4;
    	int pageEnd = pageNum+5;
    	if(pageStart < 1){
    		pageStart = 1;
    	}
    	if(pageTotal < 10 || pageEnd > pageTotal){
    		pageEnd = pageTotal;
    	}else if(pageTotal > 10 && pageEnd < 10 && pageStart == 1){
    		pageEnd = 10;
    	}

    	if(pageTotal > 10){
	    	int i = pageNum-pageStart;
	    	int j = pageEnd-pageNum;

	    	if(0 < j && pageStart > 1){
	    		pageStart = pageStart-(5-j);
	    	}else if(j==0){
	    		pageStart -= 9-i;
	    	}
    	}


    	Integer startNum = pageStartNumBase;

    	if(pageNum > 1 ){
    		startNum = pageNum;
    		paramMap.put("startNum", (cutNum*(startNum-1)));
    	}else{
    		paramMap.put("startNum", startNum);
    	}
    	if(startNum==pageStartNumBase) startNum = 1;
    	int pageCutNum = cutNum*pageNum;
    	if(pageCutNum > pageDataTotal){
    		pageCutNum = pageDataTotal;
    	}

		paramMap.put("cutNum", cutNum);
    	paramMap.put("pageStart", pageStart);
    	paramMap.put("pageCutNum", cutNum);
    	paramMap.put("pageEnd", pageEnd);
    	paramMap.put("pageNum", pageNum);
    	paramMap.put("pageTotal", pageTotal);
		return paramMap;
	}
	
	public static HashMap<String, Object> pagingNumTotalCheck(HashMap<String, Object> paramMap, Integer pageDataTotal, String type) {
		String cutNumTxt = (String) paramMap.get("pageCut");
		String pageNumTxt = null;
		if(type!=null){
			pageNumTxt = (String) paramMap.get("pageNum"+type);
		}
    	 
    	Integer cutNum = pageCutBaseNum;
    	Integer pageNum = pageStartNumBase+1;

    	if(pageNumTxt!=null && !pageNumTxt.equals("")){
    		pageNum = Integer.parseInt(pageNumTxt);
    	}
    	if(cutNumTxt!=null){
        	cutNum = Integer.parseInt(cutNumTxt);
    	}
    	int pageTotal = (int) Math.ceil((float)pageDataTotal/(float)cutNum);

    	int pageStart = pageNum-4;
    	int pageEnd = pageNum+5;
    	if(pageStart < 1){
    		pageStart = 1;
    	}
    	if(pageTotal < 10 || pageEnd > pageTotal){
    		pageEnd = pageTotal;
    	}else if(pageTotal > 10 && pageEnd < 10 && pageStart == 1){
    		pageEnd = 10;
    	}

    	if(pageTotal > 10){
	    	int i = pageNum-pageStart;
	    	int j = pageEnd-pageNum;

	    	if(0 < j && pageStart > 1){
	    		pageStart = pageStart-(5-j);
	    	}else if(j==0){
	    		pageStart -= 9-i;
	    	}
    	}


    	Integer startNum = pageStartNumBase;

    	if(pageNum > 1 ){
    		startNum = pageNum;
    		paramMap.put("startNum", (cutNum*(startNum-1)));
    	}else{
    		paramMap.put("startNum", startNum);
    	}
    	if(startNum==pageStartNumBase) startNum = 1;
    	int pageCutNum = cutNum*pageNum;
    	if(pageCutNum > pageDataTotal){
    		pageCutNum = pageDataTotal;
    	}
    	
    	if(type != null){
    		paramMap.put("cutNum", cutNum);
        	paramMap.put("pageStart", pageStart);
        	paramMap.put("pageCutNum"+type, cutNum);
        	paramMap.put("pageEnd", pageEnd);
        	paramMap.put("pageNum", pageNum);
        	paramMap.put("pageTotal", pageTotal);
    	}

		
		return paramMap;
    	
	}

	public static String getLastDay(String year, String month) {
		GregorianCalendar calendar = new GregorianCalendar();
		int yearInt = Integer.parseInt(year);
		int monthInt = Integer.parseInt(month);
		monthInt = monthInt - 1;
		calendar.set(yearInt, monthInt, 1);
		int dayInt = calendar.getActualMaximum(GregorianCalendar.DAY_OF_MONTH);
		return Integer.toString(dayInt);
	}

	public static String getLastDay(String yearMonth) {
		GregorianCalendar calendar = new GregorianCalendar();
		String[] yearMonthArry = yearMonth.split("-");
		int yearInt = Integer.parseInt(yearMonthArry[0]);
		int monthInt = Integer.parseInt(yearMonthArry[1]);
		monthInt = monthInt - 1;
		calendar.set(yearInt, monthInt, 1);
		int dayInt = calendar.getActualMaximum(GregorianCalendar.DAY_OF_MONTH);
		return Integer.toString(dayInt);
	}

	@SuppressWarnings("deprecation")
	public static String getLastDay() {
		GregorianCalendar calendar = new GregorianCalendar();
		Date today = new Date();
		calendar.set(today.getYear(), today.getMonth(), 1);
		int dayInt = calendar.getActualMaximum(GregorianCalendar.DAY_OF_MONTH);
		return Integer.toString(dayInt);
	}

	public static String getYearMonth() {
		GregorianCalendar calendar = new GregorianCalendar();
		int month = calendar.get(Calendar.MONTH)+1;
		String monthStr = null;
		if(month < 10) monthStr = "0"+month;
		else monthStr = Integer.toString(month);
		return Integer.toString(calendar.get(Calendar.YEAR))+"-"+monthStr;
	}
}