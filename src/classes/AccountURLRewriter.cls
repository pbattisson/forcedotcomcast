global class AccountURLRewriter implements Site.UrlRewriter {
	
	String ACCOUNTROOT = '/accounts/';
	String ACCOUNTVIEW = '/accounts?id=';

    global PageReference mapRequestUrl(PageReference friendlyUrl) {

    	String url = friendlyUrl.getURL();

    	if(url.startsWith(ACCOUNTROOT)) {

    		//Extract the name of the account
            String name = url.substring(ACCOUNTROOT.length(), url.length());

            name = name.replaceAll('-', ' ');

            //Query for the ID of an account with this name
            Account acc = [SELECT Id FROM Account WHERE Name =:name LIMIT 1];

           //Return a page in Visualforce format
            return new PageReference(ACCOUNTVIEW + acc.id);

    	}

    	return null;

    }

    global PageReference[] generateUrlFor(PageReference[] salesforceUrls) {

    	List<PageReference> pageReferences = new List<PageReference>();

    	for(PageReference pr : salesforceUrls) {

    		Id accId = pr.getParameters().get('id');
    		String name = [SELECT Id, Name FROM Account WHERE Id = :accId].Name.replaceAll(' ', '-');
    		
    		pageReferences.add(new PageReference(ACCOUNTROOT + name));
    	}

    	return pageReferences;
    }
	
}