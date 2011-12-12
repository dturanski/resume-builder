package com.dturanski.resume;

import grails.converters.JSON;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;

import org.apache.log4j.Logger;
import org.codehaus.groovy.grails.commons.GrailsClassUtils;
import org.codehaus.groovy.grails.commons.GrailsDomainClass;
import org.codehaus.groovy.grails.commons.GrailsDomainClassProperty;
import org.codehaus.groovy.grails.web.converters.ConverterUtil;
import org.codehaus.groovy.grails.web.converters.exceptions.ConverterException;
import org.codehaus.groovy.grails.web.converters.marshaller.json.DeepDomainClassMarshaller;
import org.codehaus.groovy.grails.web.json.JSONWriter;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

public class MyDomainClassMarshaller extends DeepDomainClassMarshaller {
	 
	private static Logger log = Logger.getLogger(MyDomainClassMarshaller.class);
	private static List<String> excludedProperties = Arrays.asList(new String[]{"id","version"}); 

	public MyDomainClassMarshaller( ) {
		super(false);
		 
	}

	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void marshalObject(Object value, JSON json)
			throws ConverterException {
		log.debug("marshalling " + value);
		JSONWriter writer = json.getWriter();
	 
		Class<?> clazz = value.getClass();
		GrailsDomainClass domainClass = ConverterUtil.getDomainClass(clazz
				.getName());
		BeanWrapper beanWrapper = new BeanWrapperImpl(value);

		writer.object();

		GrailsDomainClassProperty[] properties = domainClass
				.getProperties();

		for (GrailsDomainClassProperty property : properties) {
			if (excludedProperties.contains(property.getName())){
				continue;
			}
			
			log.debug("--> property:"+property.getName());
			
			writer.key(property.getName());
			if (!property.isAssociation()) {
				// Write non-relation property
				Object val = beanWrapper.getPropertyValue(property.getName());
				json.convertAnother(val);
			} else {
				Object referenceObject = beanWrapper.getPropertyValue(property
						.getName());
				if (isRenderDomainClassRelations()) {
					if (referenceObject == null) {
						writer.value(null);
					} else {
						 
						if (referenceObject instanceof SortedMap) {
							referenceObject = new TreeMap(
									(SortedMap) referenceObject);
						} else if (referenceObject instanceof SortedSet) {
							referenceObject = new TreeSet(
									(SortedSet) referenceObject);
						} else if (referenceObject instanceof Set) {
							referenceObject = new HashSet((Set) referenceObject);
						} else if (referenceObject instanceof Map) {
							referenceObject = new HashMap((Map) referenceObject);
						} else if (referenceObject instanceof Collection) {
							referenceObject = new ArrayList(
									(Collection) referenceObject);
						}
						json.convertAnother(referenceObject);
					}
				} else {
					if (referenceObject == null) {
						json.value(null);
					} else {
						GrailsDomainClass referencedDomainClass = property
								.getReferencedDomainClass();

						// Embedded are now always fully rendered
						if (referencedDomainClass == null
								|| property.isEmbedded()
								|| GrailsClassUtils.isJdk5Enum(property
										.getType())) {
							json.convertAnother(referenceObject);
						} else if (property.isOneToOne()
								|| property.isManyToOne()
								|| property.isEmbedded()) {
							asShortObject(referenceObject, json,
									referencedDomainClass.getIdentifier(),
									referencedDomainClass);
						} else {
							GrailsDomainClassProperty referencedIdProperty = referencedDomainClass
									.getIdentifier();
							@SuppressWarnings("unused")
							String refPropertyName = referencedDomainClass
									.getPropertyName();
							if (referenceObject instanceof Collection) {
								Collection o = (Collection) referenceObject;
								writer.array();
								for (Object el : o) {
									asShortObject(el, json,
											referencedIdProperty,
											referencedDomainClass);
								}
								writer.endArray();
							} else if (referenceObject instanceof Map) {
								Map<Object, Object> map = (Map<Object, Object>) referenceObject;
								for (Map.Entry<Object, Object> entry : map
										.entrySet()) {
									String key = String.valueOf(entry.getKey());
									Object o = entry.getValue();
									writer.object();
									writer.key(key);
									asShortObject(o, json,
											referencedIdProperty,
											referencedDomainClass);
									writer.endObject();
								}
							}
						}
					}
				}
			}

		}
		writer.endObject();
	}

}
