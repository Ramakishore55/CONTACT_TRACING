@isTest
public class FitnessTest {
    @isTest
    public static void bmiCalculatorTest(){
       // Fitness newins = new Fitness();
        Decimal myBmi= (Fitness.bmiCalculator(60,1.67)).setScale(1, RoundingMode.HALF_UP);
        
        System.assertEquals(21.5,myBmi, 'values are not matching');
        
    }
    @isTest
    public static void speedCalculatorTest(){
       // Fitness newins = new Fitness();
        Decimal mySpeed= Fitness.speedCalculator(7,10);
        System.assertEquals(42,mySpeed, 'values are not matching');
        
    }
     @isTest
    public static void bmiCalculatorTestNegative(){      
        Decimal myBmi= (Fitness.bmiCalculator(-60,-1.67)).setScale(1);        
        System.assertEquals(-1,myBmi, 'values can\'t be zero');
        
    }
    @isTest
    public static void speedCalculatorTestNegative(){       
        Decimal mySpeed= Fitness.speedCalculator(-7,10);
        System.assertEquals(-1,mySpeed, 'values can\'t be zero');
        
    }

}