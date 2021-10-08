#include <stdio.h>
#include <stdlib.h>

typedef struct Node{
  int data;
  struct Node* next;
}Node;

Node* initNode(){
  Node* newN = malloc(sizeof(Node));
  newN->data = rand() % (1000 -0);
  newN->next = NULL;
}

void addNodes(int amount, Node* first){
  Node* cur = first;
  while(cur->next != NULL){
    cur = cur->next;
  }
  for(int i = 0; i <= amount; i++){
    cur->next = initNode();
    cur = cur->next;
  }
}

void printNodes(Node* first){
  Node* cur = first;
  int loopC = 0;
  while(cur != NULL){
    printf("Node %d: value:%d-", loopC, cur->data);
    loopC++;
    cur = cur->next;
  }
  printf("\n");
}

void swap(Node* prev, Node* cur, Node** first){
  Node* next = cur->next;
  if(next==NULL){return;}
  Node* nextO = next->next;
  cur->next = nextO;
  if(prev != NULL){prev->next = next;}
  else{*first = next;}
  next->next = cur;

}

void bubbleSort(Node** first){
  int switchC = -1;
  while(switchC != 0){
    switchC = 0;
    Node* cur = *first;
    Node* prev = NULL;
    Node* next = NULL;
    while(cur->next != NULL){
      next = cur->next;
      if(next->data <= cur->data){
        swap(prev, cur, first);
        switchC++;
      }
      prev = cur;
      cur = next;      
    }
  }
}

void main(){
  Node* first = initNode();
  addNodes(10, first);
  printNodes(first);
  bubbleSort(&first);
  printNodes(first);
}

