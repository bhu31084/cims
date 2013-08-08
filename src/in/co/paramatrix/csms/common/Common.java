// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(5) braces fieldsfirst noctor nonlb space lnc 
// Source File Name:   Common.java

package in.co.paramatrix.csms.common;

import in.co.paramatrix.csms.logwriter.LogWriter;

import java.io.FileInputStream;
import java.io.PrintStream;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Date;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Properties;
import java.util.StringTokenizer;

public class Common {

	String str1;
	String str2;
	double gdamt;
	String gsamt;

	public Common() {
		/* 203 */str1 = "";
		/* 204 */str2 = "";
		/* 205 */gdamt = 0.0D;
		/* 206 */gsamt = "";
	}

	public static java.util.Date convertStringToDate(String dateString) {
		/* 15 */StringTokenizer stDate = new StringTokenizer(dateString, "/");
		/* 18 */int dd = 0;
		/* 18 */int mm = 0;
		/* 18 */int yyyy = 0;
		/* 20 */if (stDate.countTokens() == 3) {
			/* 21 */dd = Integer.parseInt(stDate.nextToken());
			/* 22 */mm = Integer.parseInt(stDate.nextToken());
			/* 23 */yyyy = Integer.parseInt(stDate.nextToken());
		}
		/* 27 */Calendar c = Calendar.getInstance();
		/* 28 */if (dd > 0 && mm > 0 && yyyy > 0) {
			/* 29 */c.set(yyyy, mm - 1, dd);
		}
		/* 32 */return c.getTime();
	}

	private long differenceInDays(Date date1, Date date2) {
		/* 36 */long msPerDay = 0x5265c00L;
		/* 37 */long date1Milliseconds = date1.getTime();
		/* 38 */long date2Milliseconds = date2.getTime();
		/* 39 */long result = (date1Milliseconds - date2Milliseconds) / 0x5265c00L;
		/* 41 */return result;
	}

	public String formatFromEnteredFormat(String strDate1) {
		/* 47 */String strRetDate = "";
		/* 48 */int iLastIndex = strDate1.lastIndexOf("/");
		/* 49 */if (iLastIndex > 0) {
			/* 50 */String strYear = strDate1.substring(iLastIndex + 3);
			/* 51 */String strDay = strDate1
					.substring(0, strDate1.indexOf("/"));
			/* 52 */String strMonth = strDate1.substring(
					strDate1.indexOf("/") + 1, iLastIndex);
			/* 54 */strRetDate = (new StringBuilder(String.valueOf(strDay)))
					.append("-").append(strMonth).append("-").append(strYear)
					.toString();
		}
		/* 56 */return strRetDate;
	}

	public String formatDate(String strDate1) {
		/* 61 */if (strDate1 == null || strDate1.trim().equals("")) {
			/* 62 */return "";
		}
		/* 65 */String strRetDate = "";
		/* 66 */int iLastIndex = strDate1.lastIndexOf("/");
		/* 67 */if (iLastIndex > 0) {
			/* 68 */String strYear = strDate1.substring(iLastIndex + 1);
			/* 69 */String strDay = strDate1
					.substring(0, strDate1.indexOf("/"));
			/* 70 */String strMonth = strDate1.substring(
					strDate1.indexOf("/") + 1, iLastIndex);
			/* 72 */strRetDate = (new StringBuilder(String.valueOf(strYear)))
					.append("-").append(strMonth).append("-").append(strDay)
					.toString();
		}
		/* 74 */return strRetDate;
	}

	public String formatDatewithTime(String strDate1) {
		/* 79 */if (strDate1 == null || strDate1.trim().equals("")) {
			/* 80 */return "";
		}
		/* 83 */String strRetDate = "";
		/* 84 */int iLastIndex = strDate1.lastIndexOf("/");
		/* 85 */if (iLastIndex > 0) {
			/* 86 */String strYear = strDate1.substring(iLastIndex + 1);
			/* 87 */String strDay = strDate1
					.substring(0, strDate1.indexOf("/"));
			/* 88 */String strMonth = strDate1.substring(
					strDate1.indexOf("/") + 1, iLastIndex);
			/* 90 */String strYear1 = strYear.substring(0, 4);
			/* 91 */String strTime = strYear.substring(5, 13);
			/* 92 */strRetDate = (new StringBuilder(String.valueOf(strYear1)))
					.append("-").append(strMonth).append("-").append(strDay)
					.append(" ").append(strTime).toString();
		} else {
			/* 95 */strRetDate = strDate1;
		}
		/* 97 */return strRetDate;
	}

	public String formatDateWithSlash(String strDate1) {
		/* 101 */if (strDate1 == null || strDate1.trim().equals("")) {
			/* 102 */return "";
		}
		/* 105 */String strRetDate = "";
		/* 106 */int iLastIndex = strDate1.lastIndexOf("-");
		/* 107 */if (iLastIndex > 0) {
			/* 108 */String strYear = strDate1.substring(iLastIndex + 1);
			/* 109 */String strDay = strDate1.substring(0, strDate1
					.indexOf("-"));
			/* 110 */String strMonth = strDate1.substring(
					strDate1.indexOf("-") + 1, iLastIndex);
			/* 112 */strRetDate = (new StringBuilder(String.valueOf(strYear)))
					.append("/").append(strMonth).append("/").append(strDay)
					.toString();
		}
		/* 114 */return strRetDate;
	}

	public String formatDateNewSlash(String strDate1) {
		/* 118 */String transdate = null;
		/* 119 */transdate = strDate1;
		/* 120 */transdate = transdate.substring(0, 10);
		/* 121 */transdate = transdate.replace('-', '/');
		/* 122 */String transyear = transdate.substring(0, 4);
		/* 124 */String transmonth = transdate.substring(5, 7);
		/* 126 */String transday = transdate.substring(8, 10);
		/* 129 */transdate = (new StringBuilder(String.valueOf(transday)))
				.append("/").append(transmonth).append("/").append(transyear)
				.toString();
		/* 131 */return transdate;
	}

	public String formatDateTimeNewSlash(String strDate1) {
		/* 137 */String transdate = null;
		/* 138 */transdate = strDate1;
		/* 139 */transdate = transdate.substring(0, 19);
		/* 140 */transdate = transdate.replace('-', '/');
		/* 141 */String transyear = transdate.substring(0, 4);
		/* 143 */String transmonth = transdate.substring(5, 7);
		/* 145 */String transday = transdate.substring(8, 10);
		/* 147 */String strTime = transdate.substring(11, 19);
		/* 148 */int i = Integer.parseInt(transmonth);
		/* 149 */if (i < 10) {
			/* 150 */transmonth = transmonth.substring(1, 2);
		}
		/* 152 */transdate = (new StringBuilder(String.valueOf(transday)))
				.append("/").append(transmonth).append("/").append(transyear)
				.append(" ").append(strTime).toString();
		/* 156 */return transdate;
	}

	public String convertNullToBlank(String gsData) {
		/* 160 */if (gsData == null || gsData.trim().equalsIgnoreCase("null")) {
			/* 161 */return "";
		} else {
			/* 162 */return gsData;
		}
	}

	public String convertNullToZero(String gsData) {
		/* 166 */if (gsData == null || gsData.trim().equalsIgnoreCase("null")) {
			/* 167 */return "0";
		} else {
			/* 168 */return gsData;
		}
	}

	public String convrtamtto(double amt, String amtin, int rounding) {
		/* 209 */DecimalFormat formatter = new DecimalFormat("####0.00");
		/* 211 */formatter.setMaximumFractionDigits(3);
		/* 212 */formatter.setMinimumFractionDigits(3);
		/* 214 */DecimalFormat formatter1 = new DecimalFormat("####0.00");
		/* 216 */formatter1.setMaximumFractionDigits(2);
		/* 217 */formatter1.setMinimumFractionDigits(2);
		/* 219 */String gbdamt = "";
		/* 220 */String gbdamt1 = "";
		/* 221 */String mystr = "";
		/* 222 */String strwhole = "";
		/* 226 */if (amtin.equalsIgnoreCase("L")) {
			/* 228 */gbdamt1 = formatter.format(amt / 100000D);
			/* 232 */strwhole = gbdamt1.substring(0, gbdamt1.indexOf("."));
			/* 236 */str1 = gbdamt1.substring(gbdamt1.indexOf("."), gbdamt1
					.length());
			/* 238 */str2 = str1.substring(3, str1.length());
			/* 241 */mystr = str1.substring(0, str1.length() - 1);
			/* 245 */if (Integer.parseInt(str2) >= 5) {
				/* 247 */gdamt = Double.parseDouble(mystr) + 0.01D;
				/* 250 */gsamt = formatter1.format(gdamt);
				/* 253 */gbdamt = gsamt.substring(gsamt.indexOf("."), gsamt
						.length());
				/* 255 */if (gsamt.substring(0, gsamt.indexOf(".")).equals("1")) {
					/* 257 */int strwholeplusone = Integer.parseInt(strwhole) + 1;
					/* 259 */gbdamt = (new StringBuilder(String.valueOf(String
							.valueOf(strwholeplusone)))).append(gbdamt)
							.toString();
				} else {
					/* 262 */gbdamt = (new StringBuilder(String
							.valueOf(strwhole))).append(gbdamt).toString();
				}
			} else {
				/* 266 */gbdamt = formatter1.format(amt / 100000D);
			}
		}
		/* 275 */if (amtin.equalsIgnoreCase("M")) {
			/* 277 */gbdamt1 = formatter.format(amt / 1000000D);
			/* 278 */strwhole = gbdamt1.substring(0, gbdamt1.indexOf("."));
			/* 280 */str1 = gbdamt1.substring(gbdamt1.indexOf("."), gbdamt1
					.length());
			/* 282 */str2 = str1.substring(3, str1.length());
			/* 284 */mystr = str1.substring(0, str1.length() - 1);
			/* 286 */if (Integer.parseInt(str2) >= 5) {
				/* 288 */gdamt = Double.parseDouble(mystr) + 0.01D;
				/* 290 */gsamt = formatter1.format(gdamt);
				/* 291 */gbdamt = gsamt.substring(gsamt.indexOf("."), gsamt
						.length());
				/* 293 */if (gsamt.substring(0, gsamt.indexOf(".")).equals("1")) {
					/* 295 */int strwholeplusone = Integer.parseInt(strwhole) + 1;
					/* 297 */gbdamt = (new StringBuilder(String.valueOf(String
							.valueOf(strwholeplusone)))).append(gbdamt)
							.toString();
				} else {
					/* 300 */gbdamt = (new StringBuilder(String
							.valueOf(strwhole))).append(gbdamt).toString();
				}
			} else {
				/* 305 */gbdamt = formatter1.format(amt / 1000000D);
			}
		}
		/* 315 */if (amtin.equalsIgnoreCase("C")) {
			/* 317 */gbdamt1 = formatter.format(amt / 10000000D);
			/* 319 */strwhole = gbdamt1.substring(0, gbdamt1.indexOf("."));
			/* 321 */str1 = gbdamt1.substring(gbdamt1.indexOf("."), gbdamt1
					.length());
			/* 323 */str2 = str1.substring(3, str1.length());
			/* 325 */mystr = str1.substring(0, str1.length() - 1);
			/* 327 */if (Integer.parseInt(str2) >= 5) {
				/* 329 */gdamt = Double.parseDouble(mystr) + 0.01D;
				/* 331 */gsamt = formatter1.format(gdamt);
				/* 332 */gbdamt = gsamt.substring(gsamt.indexOf("."), gsamt
						.length());
				/* 334 */if (gsamt.substring(0, gsamt.indexOf(".")).equals("1")) {
					/* 336 */int strwholeplusone = Integer.parseInt(strwhole) + 1;
					/* 338 */gbdamt = (new StringBuilder(String.valueOf(String
							.valueOf(strwholeplusone)))).append(gbdamt)
							.toString();
				} else {
					/* 341 */gbdamt = (new StringBuilder(String
							.valueOf(strwhole))).append(gbdamt).toString();
				}
			} else {
				/* 346 */gbdamt = formatter1.format(amt / 10000000D);
			}
		}
		/* 356 */if (amtin.equalsIgnoreCase("D")) {
			/* 388 */gbdamt = formatter1.format(amt / 1.0D);
		}
		/* 394 */return gbdamt;
	}

	public String mycurrency(double val) {
		/* 402 */BigDecimal bd = (new BigDecimal(val)).setScale(0, 6);
		/* 404 */int big = bd.intValue();
		/* 405 */String tempString = (new Integer(big)).toString();
		/* 406 */String convertString = "";
		/* 407 */int comma = 1;
		/* 408 */char c = 'c';
		/* 409 */if (tempString.length() >= 3) {
			/* 410 */int numberlength = tempString.length();
			/* 411 */StringBuffer sb = new StringBuffer(convertString);
			/* 412 */sb = sb.reverse();
			/* 413 */convertString = sb.toString();
			/* 414 */for (int cnt = numberlength - 1; cnt >= 0;) {
				/* 415 */c = tempString.charAt(cnt);
				/* 416 */System.out.println(cnt);
				/* 417 */if (comma == 4) {
					/* 418 */convertString = (new StringBuilder(String
							.valueOf(convertString))).append(",").toString();
				}
				/* 420 */if (comma > 4 && comma % 2 == 0) {
					/* 421 */convertString = (new StringBuilder(String
							.valueOf(convertString))).append(",").toString();
				}
				/* 423 */convertString = (new StringBuilder(String
						.valueOf(convertString))).append(c).toString();
				/* 414 */cnt--;
				/* 414 */comma++;
			}

			/* 425 */sb = new StringBuffer(convertString);
			/* 426 */sb = sb.reverse();
			/* 427 */convertString = sb.toString();
		} else {
			/* 429 */convertString = (new StringBuilder(String
					.valueOf(convertString))).append(tempString).toString();
		}
		/* 431 */return convertString;
	}

	public String commasep(double val) {
		/* 439 */BigDecimal bd = (new BigDecimal(val)).setScale(2, 6);
		/* 442 */boolean negFlag = false;
		/* 443 */String tempString = bd.toString();
		/* 444 */return tempString;
	}

	public static int calculateDifference(Date a, Date b) {
		/* 479 */int tempDifference = 0;
		/* 480 */int difference = 0;
		/* 481 */Calendar earlier = Calendar.getInstance();
		/* 482 */Calendar later = Calendar.getInstance();
		/* 484 */if (a.compareTo(b) < 0) {
			/* 485 */earlier.setTime(a);
			/* 486 */later.setTime(b);
		} else {
			/* 488 */earlier.setTime(b);
			/* 489 */later.setTime(a);
		}
		/* 493 */for (; earlier.get(1) != later.get(1); earlier.add(6,
				tempDifference)) {
			/* 493 */tempDifference = 365 * (later.get(1) - earlier.get(1));
			/* 495 */difference += tempDifference;
		}

		/* 500 */if (earlier.get(6) != later.get(6)) {
			/* 502 */tempDifference = later.get(6) - earlier.get(6);
			/* 504 */difference += tempDifference;
		}
		/* 507 */return difference;
	}

	public static String changeDate(String date) {
		/* 514 */String year = date.substring(0, 4);
		/* 515 */int mon = Integer.parseInt(date.substring(5, 7));
		/* 516 */int day = Integer.parseInt(date.substring(8, 10));
		/* 517 */String hr = date.substring(11, 13);
		/* 518 */String min = date.substring(14, 16);
		/* 519 */String sec = date.substring(17, 19);
		/* 521 */StringBuffer newDate = new StringBuffer();
		/* 522 */newDate.append(day);
		/* 523 */newDate.append("/");
		/* 524 */newDate.append(mon);
		/* 525 */newDate.append("/");
		/* 526 */newDate.append(year);
		/* 527 */newDate.append(" ");
		/* 528 */newDate.append(hr);
		/* 529 */newDate.append(":");
		/* 530 */newDate.append(min);
		/* 531 */newDate.append(":");
		/* 532 */newDate.append(sec);
		/* 533 */return newDate.toString();
	}

	public static String getUrl() {
		LogWriter lw = null;
		lw = new LogWriter();
		LogWriter logwriter = new LogWriter();
		URL u = LogWriter.class.getResource("LogWriter.class");
		String PROPERTIE_FILE = u.getPath();
		int length = PROPERTIE_FILE.indexOf("/WEB-INF/");
		PROPERTIE_FILE = (new StringBuilder("/")).append(
		PROPERTIE_FILE.substring(1, length + 8)).append(
				"/MailConfig.properties/").toString();
		PROPERTIE_FILE = PROPERTIE_FILE.replaceAll("%20", " ");
		Properties poolProperties = new Properties();
		try {
		poolProperties.load(new FileInputStream(PROPERTIE_FILE));
		
		}catch (Exception propertyException) {
		  propertyException.printStackTrace();
		  lw.writeErrLog(propertyException.toString());
		}
		return poolProperties.getProperty("applicationURL");
	}
	
	public static String joinSecetoryEmail() {
		LogWriter lw = null;
		lw = new LogWriter();
		LogWriter logwriter = new LogWriter();
		URL u = LogWriter.class.getResource("LogWriter.class");
		String PROPERTIE_FILE = u.getPath();
		int length = PROPERTIE_FILE.indexOf("/WEB-INF/");
		PROPERTIE_FILE = (new StringBuilder("/")).append(
		PROPERTIE_FILE.substring(1, length + 8)).append(
				"/MailConfig.properties/").toString();
		PROPERTIE_FILE = PROPERTIE_FILE.replaceAll("%20", " ");
		Properties poolProperties = new Properties();
		try {
		poolProperties.load(new FileInputStream(PROPERTIE_FILE));
		
		}catch (Exception propertyException) {
		  propertyException.printStackTrace();
		  lw.writeErrLog(propertyException.toString());
		}
		return poolProperties.getProperty("joinSectoryEmailId");
	}
	
	public static String getBcciTvLink(){
		LogWriter lw = null;
		lw = new LogWriter();
		LogWriter logwriter = new LogWriter();
		URL u = LogWriter.class.getResource("LogWriter.class");
		String PROPERTIE_FILE = u.getPath();
		int length = PROPERTIE_FILE.indexOf("/WEB-INF/");
		PROPERTIE_FILE = (new StringBuilder("/")).append(
		PROPERTIE_FILE.substring(1, length + 8)).append(
				"/MailConfig.properties/").toString();
		PROPERTIE_FILE = PROPERTIE_FILE.replaceAll("%20", " ");
		Properties poolProperties = new Properties();
		try {
		poolProperties.load(new FileInputStream(PROPERTIE_FILE));
		
		}catch (Exception propertyException) {
		  propertyException.printStackTrace();
		  lw.writeErrLog(propertyException.toString());
		}
		return poolProperties.getProperty("bcciTvURL");
	}
}
