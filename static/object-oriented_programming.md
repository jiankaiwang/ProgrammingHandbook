# Object-Oriented Programming

<script type="text/javascript" src="../js/general.js"></script>

###Class definition
---

```cpp
// the header containing the object information
#include <string>

using namespace std;

class person {
	public:
		person() { nptr = NULL; }
		~person() { delete nptr; }
		string getData(int getOption) {
			switch(getOption) {
				case 0: return firstName;
				case 1: return lastName;
				case 2: return place;
				case 3: return phone;
			}
		}
		void setPerson(string getString[]) {
			firstName = getString[0];
			lastName = getString[1];
			place = getString[2];
			phone = getString[3];
		}
		person *nptr;
	private:
		string firstName;
		string lastName;
		string place;
		string phone;
};
```

###Create a object
---

```cpp
// the main programming body use the header containing the object information	
#include <iostream>
#include <cstdlib>
#include <string>
#include <fstream>
#include "person.h"

using namespace std;

int main(int argv, char* args[]) {
    ifstream fin("input.txt");
    if(!fin) { 
		cerr << "File error." << endl; 
		return 1; 
	}

    string saveData[4];
    person *head = new person(), *find = new person();

    while(fin >> saveData[0]) {
        for(int i = 1 ; i <= 3 ; i++) {
            fin >> saveData[i];
        }
        person *newPerson = new person();
        newPerson->setPerson(saveData);
        if(! head->nptr) {
            head->nptr = newPerson;
        }
        else {
            find = head;
            while(find->nptr) {
                find = find->nptr;
            }
            find->nptr = newPerson;
        }
    }

    find = head;
    while(find->nptr) {
        for(int i = 0 ; i < 4; i++) {
            cout << find->nptr->getData(i);
            switch(i) {
                case 3: cout << endl; break;
                default: cout << "\t"; break;
            }
        }
        find = find->nptr;
    }
    fin.close();
    return 0;
}
```


