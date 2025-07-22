public class BillCodeOptimized {
    Public Integer onlyOneSlice;
     Public Integer uptoThreeSlices;
     Public Integer moreThanThreeSlices;
    public static Integer bill (Integer noOfSlices){
        if (noOfSlices==1){
            return noOfSlices*8;            
        }
        else if(noOfSlices > 1  && noOfSlices <=3){
            return noOfSlices*7;
        }
        else{
            return noOfSlices*6;
        }
        
    }
    

}