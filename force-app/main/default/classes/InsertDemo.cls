public class InsertDemo {

    public void insertAccount(){
        
        List<Account> AccountList = new List<Account>();
        
        Account newAccount = new Account();
        newAccount.Name = 'Anant';
        newAccount.BillingCity = 'Chicago';
        
        AccountList.add(newAccount);
        Try{
            Insert AccountList;
            System.debug('Account inserted');
        }catch(Exception e){
            System.debug(e);
        }
    }
}