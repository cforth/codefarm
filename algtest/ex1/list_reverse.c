#include <stdio.h>
#include <stdlib.h>

/*List Interface Start*/
typedef struct ListElmt_
{
    int num;
    struct ListElmt_ *next;
} ListElmt;


typedef struct List_
{
    ListElmt *head;
    int size;
} List;

void list_init(List *list)
{
    list->size = 0;
    list->head = NULL;
    return;
}

int list_ins_next(List *list, int num)
{
    ListElmt *new_element;
    if((new_element = (ListElmt*)malloc(sizeof(ListElmt))) == NULL)
        return -1;
    new_element->num = num;
    new_element->next = list->head;
    list->head = new_element;
    
    list->size++;
    return 0;
 }
 
 
void list_print(List *list)
{
    ListElmt *p = list->head;
    while(p != NULL) {
        printf("%d", p->num);
        p = p->next;
        if(p != NULL)
            printf("->");
    }
    printf("\n");

    return;
}

/*List Interface End*/
 

List *list_reverse(List *list, int index)
{   
    if(index > list->size || index < 1) {
        printf("Index too small or too large!\n");
        exit(0);
    }
    
    List *new_list_left = (List*)malloc(sizeof(List));
    list_init(new_list_left);
    List *new_list_right = (List*)malloc(sizeof(List));
    list_init(new_list_right);
    
    int i;
    ListElmt *p = list->head;
    
    for(i=1; i<=index; i++) {
        list_ins_next(new_list_left, p->num);
        p = p->next;
    }
    
    ListElmt *left_tail = new_list_left->head;
    while(left_tail->next != NULL) {
        left_tail = left_tail->next;
    }
    
    for(i=index+1; i<=list->size; i++) {
        list_ins_next(new_list_right, p->num);
        p = p->next;
    }
    
    left_tail->next = new_list_right->head;
    
    return new_list_left;
}

int main()
{
    List *my_list = (List*)malloc(sizeof(List));
    list_init(my_list);
    int n;
    for(n=6; n>0; n--)
        list_ins_next(my_list, n);
    
    list_print(my_list);
    List *my_new_list = list_reverse(my_list, 1);
    list_print(my_new_list);
    my_new_list = list_reverse(my_list, 2);
    list_print(my_new_list);
    my_new_list = list_reverse(my_list, 3);
    list_print(my_new_list);
    my_new_list = list_reverse(my_list, 4);
    list_print(my_new_list);
    my_new_list = list_reverse(my_list, 5);
    list_print(my_new_list);
    my_new_list = list_reverse(my_list, 6);
    list_print(my_new_list);
    my_new_list = list_reverse(my_list, 7);
    list_print(my_new_list);
    
    return 0;
}