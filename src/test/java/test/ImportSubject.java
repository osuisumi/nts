package test;

import com.haoyu.sip.textbook.service.impl.TextBookRelationService;

public class ImportSubject  extends Base{
	
	public static void main(String[] args) {
		TextBookRelationService tr  = (TextBookRelationService) ac.getBean("textBookRelationService");
		tr.importUtil("D:/import.xls");
		
	}

}
