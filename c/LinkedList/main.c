#include <stdio.h>
#include <stdlib.h>

typedef struct Person{
    char* name;
    int age;
    struct Person* friend;
}Person;

Person* first = NULL;

Person* initPerson(char* name, int age){
    Person* newPerson = malloc(sizeof(Person));
    newPerson->name = name;
    newPerson->age = age;
    newPerson->friend = NULL;
    return newPerson;

}

void addFriend(Person* newFriend, Person* person){
    person->friend = newFriend;
}

int getLength(){
    Person* curPerson = first;
    int length = 0;
    while(1){
        length++;
        if(!curPerson->friend){
            break;
        }
        curPerson = curPerson->friend;
    }
    return length;
}

Person* getPerson(int index){
    Person* curPerson = first;
    for(int i = 0; i<= index; i++){
        if(i==index){
            return curPerson;
        }
        else {
            curPerson = curPerson->friend;
        }
    }  
}

void appendPerson(Person* newPerson){
    getPerson(getLength()-1)->friend = newPerson;
}

void printPersonsList(){
    Person* curPerson = first;
    for(int i = 0; i<getLength(); i++){
        printf("%s%d\n", curPerson->name, curPerson->age);
        curPerson = curPerson->friend;
    } 
}

void insertPerson(Person* newPerson, int index){
    int myCond = (index>0) ? 1 : 0;
    Person* prevPerson = myCond ? getPerson(index-1) : getPerson(index);
    Person* prevFriend = prevPerson->friend;
    prevPerson->friend = (myCond) ? newPerson : prevFriend;
    newPerson->friend = (myCond) ? prevFriend : prevPerson;
    if(!myCond){first = newPerson;}
}

void swap(Person* swapped, Person* prev){
    Person* fri = swapped->friend;
    if(fri==NULL){
        return;
    }
    Person* oFri = fri->friend;
    swapped->friend = oFri;
    if(prev != NULL){
        prev->friend = fri;
    }
    else{
        first = fri;
    }
    fri->friend = swapped;
}

void reverseList(){
    Person* currentPerson = first;
    Person* prevFriend = NULL;
    Person* nextFriend = NULL;
    while(currentPerson){
        //It is important that I explain this to myself
        //set the next equal to the next friend of the current person
        nextFriend = currentPerson->friend;
        //change the friend of the current person to the previous person in order to reverse the list
        currentPerson->friend = prevFriend;
        //set the previous person to the current one so the above step can be repeated
        prevFriend = currentPerson;
        //set currentPerson to next friend to repeat the loop
        currentPerson = nextFriend;
    }
    first = prevFriend;
}

void bubbleSort(){
    int switchCount = -1;
    while(switchCount != 0){
        switchCount = 0;
        Person* cur = first;
        Person* prev = NULL;
        Person* next = NULL;
        while(cur->friend != NULL){
            next = cur->friend;
            if(next->age < cur->age){
                swap(cur, prev);
                switchCount++;
            }
            prev = cur;
            cur = next;
        }
    }
}

void clean(){
    Person* curPerson = first; 
    while(1){
        Person* curPersonFriend = curPerson->friend;
        printf("freeing %s", curPerson->name);
        free(curPerson);
        if(!curPersonFriend){
            break;
        }
        curPerson = curPersonFriend;
    }  
}

int main(){
    first = initPerson("Zach\n", rand());
    Person* kass = initPerson("Kass\n", rand());
    addFriend(kass, first);
    Person* malachi = initPerson("Malachi\n", rand());
    appendPerson(malachi);
    Person* john = initPerson("John\n", rand());
    insertPerson(john, 1);
    Person* nick = initPerson("Nick\n", 1);
    appendPerson(nick);
    printPersonsList();
    bubbleSort();
    printPersonsList();
    clean();
}