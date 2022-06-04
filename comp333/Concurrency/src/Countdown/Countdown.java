package Countdown;

public class Countdown {
    public void printCount() {
        for (int i = 10; i > 0; i--) {
            System.out.println(
                Thread.currentThread().getName() + "  ---  " + i
            );
        }
        System.out.println("BlastOff!");
    }
}
