public class DeletionDemo {

    public void deleteAccount(){
        
        List<Account> accountList = new List<Account>();  
        Account acc= [SELECT Name, Id FROM Account WHERE Name='Anant']; 
      
        accountList.add(acc);
        delete accountList;
        System.debug('Account deleted');
    }

}