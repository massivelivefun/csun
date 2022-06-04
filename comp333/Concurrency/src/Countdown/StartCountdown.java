package Countdown;

public class StartCountdown {
    public static void main(String[] args) {
        Countdown countdown = new Countdown();
        Runnable r = () -> {
            synchronized(countdown) {
                countdown.printCount();
            }
        };

        Thread one = new Thread(r,"Thread One");
        Thread two = new Thread(r,"Thread Two");
        one.start();
        two.start();
    }
}
