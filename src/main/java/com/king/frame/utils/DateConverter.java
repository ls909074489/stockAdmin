package com.king.frame.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.beanutils.ConversionException;
import org.apache.commons.beanutils.Converter;

public class DateConverter implements Converter {

	private final String YYYYMMDD = "yyyy-MM-dd";
	
	public Object convert(Class type, Object value) {
		if (value == null) {
			return null;
		}

		if (value instanceof Date) {
			return value;
		}

		if (value instanceof Long) {
			Long longValue = (Long) value;
			return new Date(longValue.longValue());
		}

		if (value instanceof String) {
			if(value.equals(""))
				return null;
			SimpleDateFormat sdf = new SimpleDateFormat(YYYYMMDD);
			try {
				return sdf.parse((String) value);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		try {
			return value.toString(); 
		} catch (Exception e) {
			throw new ConversionException(e);
		}
	}
}
