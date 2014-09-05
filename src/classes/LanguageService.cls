//Create a resource mapping
// - * wildcard must be preceded and followed by a '/' unless * is end character
// - resource must start with '/'
// - one mapping per class
// - class must be global
@RestResource(urlMapping='/languages/*')
global with sharing class LanguageService {


	// ROUTES:
	// GET /languages/ - retrieve 10 languages
	// GET /languages/{id} - retrieve language with specific Id
	@HttpGet
	global static List<Language__c> getLanguages() {
		
		//Rest Context holds details of botht the request and the response
		RestRequest req = RestContext.request;

		String languageId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

		List<Language__c> languages = new List<Language__c>();
		if(languageId.length() > 0) {
			languages = [SELECT Name, Id, Type__c FROM Language__c WHERE Id = :languageId];
		} else {
			languages = [SELECT Name, Id, Type__c FROM Language__c LIMIT 10];
		}

		return languages;
	}

	// ROUTE:
	// POST /languages/ - create new language
	@HttpPost
	global static String createLanguage(String name, String type) {

		Language__c lang = new Language__c();
		lang.Name = name;
		lang.Type__c = type;
		insert lang;

		return lang.Id;
	}

	// ROUTE:
	// PUT /languages/{id} - update language with Id {id} to have new properties (all object provided as parameters)
	//@HttpPut
	//global static Language__c updateLanguagePUT(String name, String type) {
	//	RestRequest req = RestContext.request;

	//	String languageId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

	//	Language__c language = [SELECT Name, Id, Type__c FROM Language__c WHERE Id = :languageId];
		
	//	language.Name = name;
	//	language.Type__c = type;
	//	update language;

	//	return language;
	//}

	// ROUTE:
	// PUT /languages/{id} - update language with Id {id} to have new properties (all object provided as instance)
	@HttpPut
	global static Language__c updateLanguagePUT(Language__c language) {

		update language;

		return language;
	}

	// ROUTE:
	// PATCH /languages/{id} - update one or many fields on a language with Id {id}
	@HttpPatch
	global static Language__c updateLanguagePATCH(String name, String type) {
		RestRequest req = RestContext.request;

		String languageId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

		Language__c language = [SELECT Name, Id, Type__c FROM Language__c WHERE Id = :languageId];
		
		if(name != null) {
			language.Name = name;	
		}
		
		if(type != null) {
			language.Type__c = type;
		}
		update language;

		return language;
	}

	// ROUTE:
	// DELETE /languages/{id} - delete the language with Id {id}
	@HttpDelete
	global static String deleteLanguage() {
		RestRequest req = RestContext.request;

		String languageId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);

		Language__c language = [SELECT Name, Id, Type__c FROM Language__c WHERE Id = :languageId];

		delete language;

		return 'Deletion Successful';
	}

}