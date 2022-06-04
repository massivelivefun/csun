import java.util.Scanner;

public class Concurrency {
    static double a = 1, b;
    static long delay;

    public static void main(String[] args) {
        Scanner scr = new Scanner(System.in);
        System.out.print("Enter a delay value: ");
        try {
            delay = scr.nextLong();
        } catch (Exception e) {
            System.out.println("Read an invalid delay value.");
            return;
        }

        Runnable r1 = () -> {
            if (a == 1) {
                try {
                    Thread.sleep(delay);
                    b = a / 2.0;
                    System.out.println(
                        Thread.currentThread().getName() + ": " + b);
                } catch (InterruptedException e) {
                    // Do nothing.
                }
            }
        };

        Runnable r2 = () -> a = 12;

        Thread threadA = new Thread(r1, "Thread A");
        Thread threadB = new Thread(r2, "Thread B");
        threadA.start();
        threadB.start();
    }
}
