public class Fitness {
    public Static Decimal bmiCalculator(Integer Weight, Decimal Height){
        if (Weight<=0 ||Height<=0){
            return -1;
        }
        Decimal bmi= Weight/(Height*Height);
        return bmi;
    }
    
    public Static Decimal speedCalculator(Integer Distance, Decimal TimeinMinutes){
         if (Distance<=0 ||TimeinMinutes<=0){
            return -1;
        }
        Decimal Speed = Distance*60/TimeinMinutes;
        return Speed ;
    }
}