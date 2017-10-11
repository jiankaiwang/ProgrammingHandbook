# Synchronize Threading

<script type="text/javascript" src="../js/general.js"></script>

###Background
---

* Multiple tasking method is to ask operation system for another process to execute the program. Multiple tasking method is similar with parallel on synchronization, resource locking, etc. The resource usage, including variable accesing, is the key and core to be disscussed. Basically, it is better trying not to use the same resource in multiple tasks and in parallel computing. The following is two methods for synchronizing among threads.

###Synchronized by function
---

* The better way is to control the function which might use key resources.

```Java
class synLockFunBody extends Thread {
	// resource locking method for solving critical section issues
	// method.1: synchronized function
	public synchronized void run() {
		int getRes = addSum(0,10000);
		System.out.println(getName() + "-> 1 :" + Integer.toString(getRes));
		getRes = addSum(10000,20000);
		System.out.println(getName() + "-> 2 :" + Integer.toString(getRes));
		getRes = addSum(20000,30000);
		System.out.println(getName() + "-> 3 :" + Integer.toString(getRes));
	}
	
	private int addSum(int start, int end) {
		int sumAll = 0;
		for(int i = start; i <= end; i++) {
			sumAll += i;
		}
		return sumAll;
	}
}  

public class useThreadInSafe {
	public static void main(String[] args) {
		// instance.1: Use Thread class and passing synLockFunBody object as constructor
		// the same object but to execute different threads
		synLockFunBody sfb = new synLockFunBody();
		Thread thr1 = new Thread(sfb);
		Thread thr2 = new Thread(sfb);
		Thread thr3 = new Thread(sfb);
		Thread thr4 = new Thread(sfb);
		thr1.start();
		thr2.start();
		thr3.start();
		thr4.start();
		
		// instance.2: Use different objects and to execute different threads itself
		synLockFunBody sfb1 = new synLockFunBody();
		synLockFunBody sfb2 = new synLockFunBody();
		synLockFunBody sfb3 = new synLockFunBody();
		synLockFunBody sfb4 = new synLockFunBody();
		sfb1.start();
		sfb2.start();
		sfb3.start();
		sfb4.start();
	}
}
```

###Synchronized by sections
---

* In most cases, the first method could meet needs. Sometimes, the function synchronized would be not allowed, the method of section synchronized would be the solution.

```Java
class synLockFunSection extends Thread {
	// resource locking method for solving critical section issues
	public void run() {
		int getRes = addSum(0,10000);
		System.out.println(getName() + "-> 1 :" + Integer.toString(getRes));
		// method.2: synchronized partial sections of program
		synchronized(this) {
			getRes = addSum(10000,20000);
			System.out.println(getName() + "-> 2 :" + Integer.toString(getRes));
			getRes = addSum(20000,30000);
			System.out.println(getName() + "-> 3 :" + Integer.toString(getRes));
		}
	}
	
	private int addSum(int start, int end) {
		int sumAll = 0;
		for(int i = start; i <= end; i++) {
			sumAll += i;
		}
		return sumAll;
	}
}  


public class useThreadInSafe {
	public static void main(String[] args) {		
		// doing synchronized partial sections only works on
		// the same object with different threads
		synLockFunSection sfs = new synLockFunSection();
		Thread sfsThr1 = new Thread(sfs);
		Thread sfsThr2 = new Thread(sfs);
		Thread sfsThr3 = new Thread(sfs);
		Thread sfsThr4 = new Thread(sfs);
		sfsThr1.start();
		sfsThr2.start();
		sfsThr3.start();
		sfsThr4.start();
	}
}
```







