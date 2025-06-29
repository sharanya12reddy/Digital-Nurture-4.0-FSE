public class Main {

    static class Logger {
        private static Logger instance;

        private Logger() {
        }

        public static Logger getInstance() {
            if (instance == null) {
                instance = new Logger();
            }
            return instance;
        }

        public void log(String message) {
            System.out.println("[LOG] " + message);
        }
    }

    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        System.out.println("Are both logger instances the same? " + (logger1 == logger2));

        logger1.log("This is the first log message.");
        logger2.log("This is the second log message.");
    }
}
