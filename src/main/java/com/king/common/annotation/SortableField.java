package com.king.common.annotation;

import java.lang.reflect.Field;

public class SortableField {

	public SortableField() {
	}

	public SortableField(MetaData meta, Field field) {
		super();
		this.meta = meta;
		this.field = field;
		this.name = field.getName();
		this.type = field.getType();
	}

	public SortableField(MetaData meta, String name, Class<?> type) {
		super();
		this.meta = meta;
		this.name = name;
		this.type = type;
	}

	private MetaData meta;
	private Field field;
	private String name;
	private Class<?> type;

	public MetaData getMeta() {
		return meta;
	}

	public void setMeta(MetaData meta) {
		this.meta = meta;
	}

	public Field getField() {
		return field;
	}

	public void setField(Field field) {
		this.field = field;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Class<?> getType() {
		return type;
	}

	public void setType(Class<?> type) {
		this.type = type;
	}

}
