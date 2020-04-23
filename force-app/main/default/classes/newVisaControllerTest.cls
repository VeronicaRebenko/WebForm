@isTest
public class newVisaControllerTest {
    
    @isTest 
    private static void testController(){
        
        newVisaController controller = new newVisaController();
        
        Test.setMock(HttpCalloutMock.class, new CalloutWPMock()); 
        
        Visa_Thought__c visa = controller.getVisa();
        
        controller.step1();
        controller.step2();
        //controller.freezePageSend();
        
        visa.Email__c = 'test@mail.com';
        visa.Born2Invest_Offers__c = true;
        visa.Full_name__c = '1111';
        visa.Telephone_number__c = 'test';
        visa.Nationality__c = 'China';
        
        controller.step2();
        
        visa.Full_name__c = 'Test Person';
        visa.Telephone_number__c = '11111111';
        
        controller.step2();
        controller.step3();
        
        visa.degree_qualification__c = 'Doctorate';
        visa.Who_is_coming_with_you__c = 'Parents';
        visa.Do_you_own_a_business__c = 'No';
        visa.How_much_can_you_invest__c = '51,000 - 100,000';
        visa.Money_available__c = 'Yes';
        
        controller.step3();
        controller.save();
        
        visa.Where_would_you_like_to_move__c = 'South America';
        visa.Why_do_you_want_to_move__c = 'Education';
        visa.When_would_you_like_to_move__c = '4-6 months';
        visa.LinkedIn__c = 'My linkedIn';
        
        controller.browserurl = 'site.com';

        controller.save();
    }
}