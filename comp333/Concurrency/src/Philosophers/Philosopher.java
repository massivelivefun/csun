package Philosophers;

public class Philosopher implements Runnable {
    // The forks on either side of the philosophers.
    private final Object leftFork;
    private final Object rightFork;

    public Philosopher(final Object leftFork, final Object rightFork) {
        this.leftFork = leftFork;
        this.rightFork = rightFork;
    }

    private void doAction(String action) throws InterruptedException {
        System.out.println(Thread.currentThread().getName() + " " + action);
        Thread.sleep(((int) (Math.random() * 100)));
    }

    @Override
    public void run() {
        try {
            while (true) {
                // The philosopher is thinking.
                doAction(System.nanoTime() + ": Thinking");
                synchronized (leftFork) {
                    doAction(System.nanoTime() + ": Picked up left fork");
                    synchronized (rightFork) {
                        // The philosopher is eating with both forks.
                        doAction(System.nanoTime() +
                            ": Picked up right fork - eating");
                        doAction(System.nanoTime() + ": Put down right fork");
                    }
                    // The philosopher is back to thinking.
                    doAction(System.nanoTime() +
                        ": Put down left fork. Back to thinking");
                }
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
