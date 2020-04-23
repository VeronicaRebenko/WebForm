public class newVisaController {
    
    public static final String ADD_VALUE = 'Please, enter a value.';
    public static final String SELECT_VALUE = 'Please, select a value.';
    public static final String TICK_VALUE = 'Please, tick a checkbox.';
    public static final String ONLY_LETTERS = 'Please, enter only letters.';
    public static final String ONLY_PHONE = 'Please, enter valid phone number.';
    
    //public static final String FREEZE = 'FREEZE';
    //public static final String UNFREEZE = 'UNFREEZE';
    //public Boolean freezed = false;
    
    public Visa_Thought__c visa;
    public String browserurl 	{get;set;}
    
    public Visa_Thought__c getVisa() {
        if(visa == null) visa = new Visa_Thought__c();
        return visa;
    }
    
    public PageReference step1() {
        return Page.VisaStep1;
    }
    
    public PageReference step2() {
        
        Boolean hasError = false;
        
        if(visa.Email__c == null) {
            visa.Email__c.addError(ADD_VALUE);
            hasError = true;
        }
        
        if(visa.Born2Invest_Offers__c == false) {
            visa.Born2Invest_Offers__c.addError(TICK_VALUE);
            hasError = true;
        }
        
        if(visa.Full_name__c == null) {
            visa.Full_name__c.addError(ADD_VALUE);
            hasError = true;
        }
        else if( !visa.Full_name__c.isAlphaSpace()) {
            visa.Full_name__c.addError(ONLY_LETTERS);
            hasError = true;
        }
        
        if(visa.Telephone_number__c == null){
            visa.Telephone_number__c.addError(ADD_VALUE);
            hasError = true;
        }
        else if( !Pattern.matches('[0-9(),./\\+-]+', visa.Telephone_number__c)) {
            visa.Telephone_number__c.addError(ONLY_PHONE);
            hasError = true;
        }
        
         if(visa.Nationality__c == null){
            visa.Nationality__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if (hasError) return Page.VisaStep1;
        return Page.VisaStep2;
    }
    
    public PageReference step3() {
        Boolean hasError = false;
        
        if(visa.degree_qualification__c == null) {
            visa.degree_qualification__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(visa.Who_is_coming_with_you__c == null) {
            visa.Who_is_coming_with_you__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(visa.Do_you_own_a_business__c == null) {
            visa.Do_you_own_a_business__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(visa.How_much_can_you_invest__c == null) {
            visa.How_much_can_you_invest__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(visa.Money_available__c == null) {
            visa.Money_available__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if (hasError) return Page.VisaStep2;
        return Page.VisaStep3;
    }
    
    public PageReference save() { 
        Boolean hasError = false;
        
        if(visa.Where_would_you_like_to_move__c == null) {
            visa.Where_would_you_like_to_move__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
        if(visa.Why_do_you_want_to_move__c == null) {
            visa.Why_do_you_want_to_move__c.addError(SELECT_VALUE);
            hasError = true;
        } 
        
        if(visa.When_would_you_like_to_move__c == null) {
            visa.When_would_you_like_to_move__c.addError(SELECT_VALUE);
            hasError = true;
        }
        
         if(visa.LinkedIn__c == null) {
            visa.LinkedIn__c.addError(ADD_VALUE);
            hasError = true;
        }
        
        
        if (hasError) return Page.VisaStep3;
        
        
        System.debug('browserurl: '+ browserurl);
        
        visa.Source_URL__c = browserurl.left(255);
        insert visa;
        
        //unfreezePageSend();
        
        return Page.visaStep4;
    }
    
    /*
    public void freezePageSend(){
        if(!freezed) {
            freezed = true;
            CalloutWP.makeCallout(FREEZE, browserurl);
            system.debug('sent to freeze: ' + browserurl);
        }    
    }
    
    public void unfreezePageSend(){
        if(freezed) {
            freezed = false;
            CalloutWP.makeCallout(UNFREEZE, browserurl);
            system.debug('sent to unfreeze: ' + browserurl);
        }    
    }
*/
    
}