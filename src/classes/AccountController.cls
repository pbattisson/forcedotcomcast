public with sharing class AccountController {

	public List<Account> accounts {get; private set;}
	public Account account {get; private set;}

	public AccountController() {
		Id accId = ApexPages.currentPage().getParameters().get('id');
		if(accId == null) {
			accounts = [SELECT Name, Id FROM Account];
		} else {
			account = [SELECT Name, AccountNumber, Id FROM Account WHERE Id = :accId];
		}
	}
}