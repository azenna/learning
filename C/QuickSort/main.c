#include <stdlib.h>
#include <stdio.h>

void swap(int* a, int* b){
    int temp = *a;
    *a = *b;
    *b = temp;
}

int partition(int arr[], int low, int high){
    int pivot = arr[high];
    int i = (low-1);
    
    for(int j = low; j <= high-1; j++){
        if(arr[j]<pivot){
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i+1], &arr[high]);
    return (i+1);
}

void quickSort(int arr[], int low, int high){
    if(low<high){
        int pivot = partition(arr, low, high);
        quickSort(arr, low, pivot-1);
        quickSort(arr, pivot+1, high);
    }
}

void printList(int arr[], int length){
    int i;
    for(i = 0; i < length; i++){
        printf("%d\n", arr[i]);
    }
    printf("\n");
}

void main(){
    int arr[] = {10,2,6,7,3,4,5,9,8,1};
    int arrLength = 10;
    swap(&arr[1],&arr[2]);
    quickSort(arr, 0, 9);
    printList(arr, arrLength);
}