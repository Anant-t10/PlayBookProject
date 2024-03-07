@isTest
public class ConversionTEST {
	
    @isTest static void testcase1(){
        Integer answer = Conversion.meterToCentimeter(50);
        System.assertEquals(5000,answer);
    }
    @isTest static void testcase2(){
        Integer answer = Conversion.meterToCentimeter(0);
        System.assertEquals(0,answer);
    }
}