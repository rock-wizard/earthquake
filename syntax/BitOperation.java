package syntax;

public class BitOperation {
    public static void main(String[] args) {
        int a = 6;
        System.out.println((a & (1L << 1)) != 0);
    }
}
