package test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Base {
	
	public static ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	

}
