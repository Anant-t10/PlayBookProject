public class EmployeeManager {

    private map<Integer, Employee> keyToEmployee;
    
    public EmployeeManager(){
        keyToEmployee = new map<Integer, Employee>();
    }
    
    public void addEmployee(Integer id, String Name, String Department){
        
        Employee newEmployee = new Employee(id, Name, Department);
        keyToEmployee.put(id, newEmployee);
    }
    public void removeEmployee(Integer id){
      
        keyToEmployee.remove(id);
    }
    public void allEmployee(){
        
        for(Integer keyOfEmployee : keyToEmployee.keySet()){
            System.debug(keyToEmployee.get(keyOfEmployee));
        }
    }    
}