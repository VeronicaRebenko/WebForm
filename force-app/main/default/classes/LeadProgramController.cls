public class LeadProgramController {
    public static final String LEAD_STATUS = 'New';
    public static final String LEAD_COMPANY = 'N/A'; 
    
    public static final String LEAD_RECORD_TYPE = 'Mobcast';
    
    public static final String DEFAULT_PROGRAMM_ID = 'P-00044';
    public static final String PAGE_DEFAULT_PROGRAMM = 'LeadStep1';
    public static final String PAGE_ALL_PROGRAMM = 'LeadProgrammStep1';
    
    public static final String ADD_VALUE = 'Please, enter a value.';
    public static final String SELECT_VALUE = 'Please, select a value.';
    public static final String ONLY_LETTERS = 'Please, enter only letters.';
    public static final String ONLY_PHONE = 'Please, enter valid phone number.';
    public static final String DEFAULT_VAL = '—Please select one—';
    
    
    public Lead lead;
    public String browserurl 	{get;set;}
    public String pageName {get; set;}
    
    public Lead getLead() {
        if(lead == null) lead = new Lead();
        return lead;
    }
    
    public SelectOption[] getOptions() {
        SelectOption[] options = new SelectOption[] {};
            
            options.add(new SelectOption('', DEFAULT_VAL));
        
        for (Product2 obj : [SELECT Id, Name FROM Product2]) {
            options.add(new SelectOption(obj.Id, obj.Name));
        }
        
        return options;
    }
    
    public PageReference step1() {
                
        if(pageName == PAGE_DEFAULT_PROGRAMM){
            return Page.LeadStep1;
        }
        return Page.LeadProgrammStep1;
    }
    
    public PageReference step2() {
        
        Boolean hasError = false;
               
        if(lead.Email == null) {
            lead.Email.addError(ADD_VALUE);
            hasError = true;
        }
        
        if(lead.LastName == null) {
            lead.LastName.addError(ADD_VALUE);
            hasError = true;
        }
        else if( !lead.LastName.isAlphaSpace()) {
            lead.LastName.addError(ONLY_LETTERS);
            hasError = true;
        }
        
        if(lead.Phone == null){
            lead.Phone.addError(ADD_VALUE);
            hasError = true;
        }
        else if( !Pattern.matches('[0-9(),./\\+-]+', lead.Phone)) {
            lead.Phone.addError(ONLY_PHONE);
            hasError = true;
        }
        
        if(lead.Nationality__c == null || lead.Nationality__c == DEFAULT_VAL){
            lead.Nationality__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(ApexPages.currentPage().getParameters().get('CheckboxInput') == 'on'){
            lead.Offers__c = true;
        } else {
            lead.Offers__c = false;
        }
        
        if (String.isBlank(pageName)) {
             pageName = ApexPages.currentPage().getParameters().get('currentVFpage');
        }  
        system.debug('pageName: ' + pageName);
        
        if (hasError) return step1();
        
        return Page.LeadStep2;
    }
    
    public PageReference step3() {
        Boolean hasError = false;
        
        if(lead.Degree__c == null || lead.Degree__c == DEFAULT_VAL) {
            lead.Degree__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(lead.Who_with_you__c == null) {
            lead.Who_with_you__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(lead.Own_business__c == null || lead.Own_business__c == DEFAULT_VAL) {
            lead.Own_business__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(lead.Can_invest__c == null || lead.Can_invest__c == DEFAULT_VAL) {
            lead.Can_invest__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(lead.Money_available__c == null || lead.Money_available__c == DEFAULT_VAL) {
            lead.Money_available__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if (hasError) return Page.LeadStep2;
        return Page.LeadStep3;
    }
    
    public PageReference save() { 
        Boolean hasError = false;
        
        if(lead.When_move__c == null || lead.When_move__c == DEFAULT_VAL) {
            lead.When_move__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(lead.Why_move__c == null) {
            lead.Why_move__c.addError(SELECT_VALUE);
            hasError = true;
        }
                
        if (hasError) return Page.LeadStep3;
               
        System.debug('browserurl: '+ browserurl);
        
        lead.Source_URL__c = browserurl.left(255);
        
        lead.company = LEAD_COMPANY;
        lead.status = LEAD_STATUS;
        
        lead.RecordTypeId = [select Id from RecordType where DeveloperName =: LEAD_RECORD_TYPE AND sObjectType = 'Lead' limit 1].Id;
        
        if(pageName == PAGE_DEFAULT_PROGRAMM){
            try{
                lead.Programme__c = [select Id, Name from Product2 where Programme_ID__c =: DEFAULT_PROGRAMM_ID limit 1].Id;
            } catch (Exception e) {
                System.debug('Programme not found: ' + DEFAULT_PROGRAMM_ID);
            }     
        }
        
        try {
            insert lead;   
        } catch (Exception e) {
            System.debug ('Lead Duplicate Rule was fired:' + e);
        }
        
        return Page.LeadStep4;
    }   
}