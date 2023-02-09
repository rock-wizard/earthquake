package syntax;

import java.util.ArrayList;

public class ListComparison {
    public static void main(String[] args) {
        ArrayList<String> arrayDefault = new ArrayList<>(10);
        System.out.println(Integer.toHexString(arrayDefault.hashCode()));
        arrayDefault.add("sdas");
        System.out.println(Integer.toHexString(arrayDefault.hashCode()));

        System.out.println(Integer.toHexString(arrayDefault.hashCode()));
        arrayDefault.add("sdas");
        System.out.println(Integer.toHexString(arrayDefault.hashCode()));
        System.out.println(arrayDefault.size());
        //System.out.println(arrayDefault.get(5));
    }
}
