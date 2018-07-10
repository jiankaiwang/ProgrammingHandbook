# Threading in Java



###Background
---

* Multiple tasking method is to ask operation system for another process to execute the program. Multiple tasking method is similar with parallel on synchronization, resource locking, etc. The following are two examples using different methods to implement multiple threads in java.

###inherit from class {Thread}
---

* Inheritance from class{Thread} is the suggested method for implementing multiple threads. The following example is to calculate the prime sum ranging from 0 to 10000 by 4 threads. Use the object created by class{vector} to save threading results due to support of thread-safe.

```Java
import java.util.Vector;

class addPrimeSum extends Thread {
	private Vector<saveData> concurrencyVector;
	// constructor
	public addPrimeSum(Vector<saveData> getRank) {
		concurrencyVector = getRank;
	}
	public void run() {
		int ttl = 2, getRes = 0;
		for(int i = 3 ; i < 10000 ; i++) {
			getRes = checkPrime(i);
			switch(getRes) {
				// a prime
				case 1: ttl += i; break;
			}
		}
		// print out the result
		System.out.println(getName() + ":" + ttl);
		// but also put result into vector due to Thread-safe existing in Vector class
		saveData sd = new saveData(getName(),ttl);
		concurrencyVector.add(sd);
	}
	private int checkPrime(int getNum) {
		int checkFlag = 0;
		for(int i = 1; i <= Math.sqrt(getNum); i++) {
			switch(getNum % i) {
				case 0: checkFlag += 1; break;
			}
			if(checkFlag >= 2) { return 0; }
		}
		return 1;
	}
}

class saveData {
	// private
	private String threadName;
	private int thrRes;
	
	// public
	public saveData(String getName, int getRes) {
		threadName = getName;
		thrRes = getRes;
	}
	
	public String getThrName() { return threadName; }
	public int getCalRes() { return thrRes; }
}

public class useThread {
	public static void main(String[] args) {
		// inherit class Thread
		// use vector to save multiple thread results, add "import java.util.Vector"
		Vector<saveData> apsResult = new Vector<saveData>();
		addPrimeSum aps1 = new addPrimeSum(apsResult);
		addPrimeSum aps2 = new addPrimeSum(apsResult);
		addPrimeSum aps3 = new addPrimeSum(apsResult);
		addPrimeSum aps4 = new addPrimeSum(apsResult);
		aps1.start();
		aps2.start();
		aps3.start();
		aps4.start();
		try {
			// use join() to make main process wait for thread complete
			aps1.join();
			aps2.join();
			aps3.join();
			aps4.join();
		} catch (InterruptedException e) {
			System.out.println("Error: thread had been interrupted.");
		}
		System.out.println("All threads are completed");
		System.out.println("The concurrency result is: ");
		for(int i = 0; i < apsResult.size(); i++) {
			System.out.println(apsResult.elementAt(i).getThrName() + ":" + apsResult.elementAt(i).getCalRes());
		}	
	}
}	
```

###by implements (Runnable)
---

* Due to policy that one class could only inherit from one parent class, the first method could not be implemented. The second method use 'implements(Runnable)' to do the multiple threading techniques.

```Java
import java.util.Vector;

class addPrimeSumRunable implements Runnable {
	// private members
	private String threadName = "";
	private Vector<saveData> concurrencyVector;
	// constructor
	public addPrimeSumRunable(String getName, Vector<saveData> getConVector) {
		threadName = getName;
		concurrencyVector = getConVector;
	}
	// threading body
	public void run() {
		int ttl = 2, getRes = 0;
		for(int i = 3 ; i < 10000 ; i++) {
			getRes = checkPrime(i);
			switch(getRes) {
				// a prime
				case 1: ttl += i; break;
			}
		}
		// print out the result
		System.out.println(threadName + ":" +ttl);
		// and save the result into concurrency vector
		saveData sd = new saveData(threadName,ttl);
		concurrencyVector.add(sd);
	}
	private int checkPrime(int getNum) {
		int checkFlag = 0;
		for(int i = 1; i <= Math.sqrt(getNum); i++) {
			switch(getNum % i) {
				case 0: checkFlag += 1; break;
			}
			if(checkFlag >= 2) { return 0; }
		}
		return 1;
	}
}

class saveData {
	// private
	private String threadName;
	private int thrRes;
	
	// public
	public saveData(String getName, int getRes) {
		threadName = getName;
		thrRes = getRes;
	}
	
	public String getThrName() { return threadName; }
	public int getCalRes() { return thrRes; }
}

public class useThread {
	public static void main(String[] args) {
		// implement runnable interface
		// use vector to save multiple thread results, add "import java.util.Vector"
		Vector<saveData> adspResult = new Vector<saveData>();
		// step.1: generate object executing runnable threads
		addPrimeSumRunable adsp1 = new addPrimeSumRunable("Thread-1",adspResult);
		addPrimeSumRunable adsp2 = new addPrimeSumRunable("Thread-2",adspResult);
		addPrimeSumRunable adsp3 = new addPrimeSumRunable("Thread-3",adspResult);
		addPrimeSumRunable adsp4 = new addPrimeSumRunable("Thread-4",adspResult);
		// step.2: use runnable object for constructing Thread object
		Thread thr1 = new Thread(adsp1);
		Thread thr2 = new Thread(adsp2);
		Thread thr3 = new Thread(adsp3);
		Thread thr4 = new Thread(adsp4);
		// step.3: start threads
		thr1.start();
		thr2.start();
		thr3.start();
		thr4.start();
		try {
			// use join() to make main process wait for thread complete
			thr1.join();
			thr2.join();
			thr3.join();
			thr4.join();
		} catch (InterruptedException e) {
			System.out.println("Error: thread had been interrupted.");
		}
		System.out.println("All threads are completed");
				System.out.println("The concurrency result is: ");
		for(int i = 0; i < adspResult.size(); i++) {
			System.out.println(adspResult.elementAt(i).getThrName() + ":" + adspResult.elementAt(i).getCalRes());
		}
	}
}
```





