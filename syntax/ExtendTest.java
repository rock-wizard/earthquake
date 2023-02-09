package syntax;

class Father {
    public String name;

    public Father() {

    }

    public Father(String name) {
        this.name = name;
    }
}

public class ExtendTest extends Father {
    public String sex;

    public ExtendTest(){
        
    }

    public ExtendTest(String name) {
        //this();
        super(name);
    }

    public static void main(String[] args) {
        ExtendTest ins = new ExtendTest("rabbit");
        System.out.println(ins.sex);
    }
}
