@isTest
public class Covid19Test {
    @isTest
    public static void getTreatedTest(){
        //Instance of the class
        Covid19 jaipur = new Covid19(10);
        integer treated = jaipur.getTreated();
        System.assertEquals(10,treated,'Treated count does not match');
        Covid19 hyd = new Covid19(155);
        treated = hyd.getTreated();
        System.assertEquals(155,treated,'Treated count does not match');
        // checking recoveredInCountry is working
        System.assertEquals(165,Covid19.recoveredInCountry,'Treated count does not match');
        // checking -ve scenario.
        Covid19 chennai = new Covid19(13);
       // System.assertEquals(0,treated,'Treated count does not match');
       // checking another method
          chennai.treatPatient();
        treated = chennai.getTreated();
        
        System.assert(treated ==14, 'value is not matching');
        System.assert(Covid19.recoveredInCountry ==179, 'value is not matching');                     
        
    }
     @isTest
    public static void getTreatedTestNegative(){
        //Instance of the class
        Covid19 jaipur = new Covid19(-10);
        integer treated = jaipur.getTreated();
        System.assertEquals(0,treated,'Treated count does not match');
                           
        
    }

}