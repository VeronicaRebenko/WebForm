@isTest
public class LeadProgramControllerTest {
   
    @isTest 
    private static void testDefaultProgramm(){
        
        LeadProgramController controller = new LeadProgramController();
        controller.pageName = LeadProgramController.PAGE_DEFAULT_PROGRAMM;
        
        Lead lead = controller.getLead();
        
        controller.step2();
 
        lead.Email = 'test@mail.com';
        lead.Offers__c = true;
        lead.LastName = '1111';
        lead.Phone = 'test';
        lead.Nationality__c = 'China';
        
        controller.step2();
        
        lead.LastName = 'Test Person';
        lead.Phone = '11111111';
        
        controller.step2();
        controller.step1();
        controller.step2();
        controller.step3();
        
        lead.Degree__c = 'Doctorate';
        lead.Who_with_you__c = 'Parents';
        lead.Own_business__c = 'No';
        lead.Can_invest__c = '51,000 - 100,000';
        lead.Money_available__c = 'Yes';
        
        controller.step3();
        controller.save();
        
        lead.Where_move__c = 'South America';
        lead.Why_move__c = 'Education';
        lead.When_move__c = '4-6 months';
        lead.LinkedIn__c = 'My linkedIn';
        
        controller.browserurl = 'site.com';

        controller.save();
    }
    
    @isTest 
    private static void testAllProgramm(){
        
        LeadProgramController controller = new LeadProgramController();
        
        controller.pageName = LeadProgramController.PAGE_ALL_PROGRAMM;
        
        List<Product2> prodlist = new List<Product2>();
        for(Integer i = 0; i < 10; i++) {
            prodlist.add(new Product2( name ='Test'+i) );   
        }
		insert prodlist;
        
        controller.getOptions();
        
        Lead lead = controller.getLead();
        
        lead.Email = 'test@mail.com';
        lead.Offers__c = true;
        lead.LastName = 'Test Person';
        lead.Phone = '11111111';
        lead.Nationality__c = 'China';
        
        controller.step2();
        controller.step1();
        controller.step2();
        
        lead.Degree__c = 'Doctorate';
        lead.Who_with_you__c = 'Parents';
        lead.Own_business__c = 'No';
        lead.Can_invest__c = '51,000 - 100,000';
        lead.Money_available__c = 'Yes';
        
        controller.step3();
        
        lead.Where_move__c = 'South America';
        lead.Why_move__c = 'Education';
        lead.When_move__c = '4-6 months';
        lead.LinkedIn__c = 'My linkedIn';
        
        controller.browserurl = 'site.com';
        
        controller.save();
    } 
}