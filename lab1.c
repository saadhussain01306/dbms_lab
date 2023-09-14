/*
Consider a structure named Student with attributes as SID, NAME, 
BRANCH, SEMESTER, ADDRESS. 
Write a program in C/C++/ and perform the following operations using 
the concept of files.
a. Insert a new student
b. Modify the address of the student based on SID
c. Delete a student
d. List all the students
e. List all the students of CSE branch.
f. List all the students of CSE branch and reside in Kuvempunagar.
*/

#include<stdio.h>
#include<stdlib.h>
#include<string.h>

typedef struct student{
    char SID[20];
    char name[25];
    char branch[25];
    char semester[25];
    char address[25];
}stu;
stu st;

void insert_new(){
    printf("Enter the student ID of the student\n");
    scanf("%s",st.SID);
    printf("Enter the name of the student\n");
    scanf("%s",st.name);
    printf("Enter the Branch of the student\n");
    scanf("%s",st.branch);
    printf("Enter the Semester in which the student is present\n");
    scanf("%s",st.semester);
    printf("Enter the address at which the student reside\n");
    scanf("%s",st.address);
    
    FILE *fp;
    fp=fopen("student_info.txt","a");
    
    if(fp==NULL){
        printf("Error Can't open the file now\n");
        return;
    }
    
       fprintf(fp,"%s\t%s\t%s\t%s\t%s\n",
       st.SID,st.name,st.branch,st.semester,st.address);
       
       fclose(fp);
       printf("The student data has been added to the file\n");
         
}

void modify_add(){
   char new_ID[25];
   int flag=0;
   printf("Enter the student ID whose address need to be modified\n");
   scanf("%s",new_ID);
   FILE *fp=fopen("student_info.txt","r");
   if(fp==NULL){
     printf("Error opening the file\n");
     return;
     
   }
   FILE *fp1=fopen("sample.txt","a");
   if(fp1==NULL){
     printf("Error opening the file\n");
     return;
   }
   while(fscanf(fp,"%s%s%s%s%s",st.SID,st.name,st.branch,st.semester,
   st.address)!=EOF){
     if (strcmp(st.SID,new_ID)==0){
        printf("Enter the new address of the student\n");
        scanf("%s",st.address);
          flag=1;
     }
           fprintf(fp1,"%s\t%s\t%s\t%s\t%s\n",st.SID,st.name,st.branch,st.semester,
   st.address);
   }
 if(flag){
    printf("The address is successfully modified\n");
}
else{
    printf("The student with the given student ID do not exist\n");
    
  }
 fclose(fp);
 fclose(fp1);
 
 remove("student_info.txt");
 rename("sample.txt","student_info.txt");
  
}

void delete_st(){
     char new_ID[25];
     int flag=0;
     
   printf("Enter the student ID whose entry in the file is to be deleted\n");
   scanf("%s",new_ID);
   FILE *fp=fopen("student_info.txt","r");
   if(fp==NULL){
     printf("Error opening the file\n");
     return;
   }
   FILE *fp1=fopen("sample.txt","a");
   if(fp1==NULL){
     printf("Error opening the file\n");
     return;
   }
   while(fscanf(fp,"%s%s%s%s%s",st.SID,st.name,st.branch,st.semester,
   st.address)!=EOF){
     if (strcmp(st.SID,new_ID)!=0){
    fprintf(fp1,"%s\t%s\t%s\t%s\t%s\n",st.SID,st.name,st.branch,st.semester,
   st.address);
     }
     else{
        flag=1;
     }
      
   }
 if(flag){
    printf("The student with the given ID is deleted successfully\n");
}
else{
    printf("The given student do not exist\n");
    
  }
 fclose(fp);
 fclose(fp1);
 
 remove("student_info.txt");
 rename("sample.txt","student_info.txt");
  
}

void list_all(){
    int flag=0;
    FILE *fp=fopen("student_info.txt","r");
    if(fp==NULL){
     printf("Error opening the file\n");
     return;
   } 
   
   printf("The list of all the students\n"); 
   while(fscanf(fp,"%s%s%s%s%s",st.SID,st.name,st.branch,st.semester,
   st.address)!=EOF){
        printf("Student ID       :- %s\n",st.SID);
        printf("Student Name     :- %s\n",st.name);
        printf("Student Branch   :- %s\n",st.branch);
        printf("Student Semester :- %s\n",st.semester);
        printf("Student Address  :- %s\n",st.address);
        printf("\n\n");flag=1;
   }
   if(flag==0){
       printf("There is no student present in the given file\n");
   }
   fclose(fp);
}

void list_cse(){
     int flag=0;
      FILE *fp=fopen("student_info.txt","r");
    if(fp==NULL){
     printf("Error opening the file\n");
     return;
   } 
   
   printf("The list of all the students of CSE branch\n"); 
   while(fscanf(fp,"%s%s%s%s%s",st.SID,st.name,st.branch,st.semester,
   st.address)!=EOF){
        if(strcmp(st.branch,"CSE")==0){
        printf("Student ID       :- %s\n",st.SID);
        printf("Student Name     :- %s\n",st.name);
        printf("Student Branch   :- %s\n",st.branch);
        printf("Student Semester :- %s\n",st.semester);
        printf("Student Address  :- %s\n",st.address);
        printf("\n\n");
        flag=1;
        }  
   }
   if(flag==0){
       printf("there is no student present in CSE in the file\n");
   }
   fclose(fp); 
}

void list_cse_kuv(){
    int flag=0;
    FILE *fp=fopen("student_info.txt","r");
    if(fp==NULL){
     printf("Error opening the file\n");
     return;
   } 
   
   printf("The list of all the students of CSE branch and residing in kuvenpunagar\n"); 
   while(fscanf(fp,"%s%s%s%s%s",st.SID,st.name,st.branch,st.semester,
   st.address)!=EOF){
        if(strcmp(st.branch,"CSE")==0 && strcmp(st.address,"kuvempunagar")==0){
        printf("Student ID       :- %s\n",st.SID);
        printf("Student Name     :- %s\n",st.name);
        printf("Student Branch   :- %s\n",st.branch);
        printf("Student Semester :- %s\n",st.semester);
        printf("Student Address  :- %s\n",st.address);
        printf("\n\n");
        flag=1;
        }  
   }
   if(flag==0){
       printf("there is no student of whose branch is CSE and reside in kuvempunagar\n");
   }
   fclose(fp);
}

int main() {
    int choice;
    while (1) {
        printf("\nMenu:\n");
        printf("1. Insert a new student\n");
        printf("2. Modify the address of a student based on SID\n");
        printf("3. Delete a student\n");
        printf("4. List all students\n");
        printf("5. List all students of CSE branch\n");
        printf("6. List all students of CSE branch residing in Kuvempunagar\n");
        printf("7. Exit\n");
        printf("\n\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                insert_new();
                printf("\n");
                break;
            case 2:
                modify_add();
                printf("\n");
                break;
            case 3:
                delete_st();
                printf("\n");
                break;
            case 4:
                list_all();
                printf("\n");
                break;
            case 5:
                list_cse();
                printf("\n");
                break;
            case 6:
                list_cse_kuv();
                printf("\n");
                break;
            case 7:
                exit(0);
                printf("\n");
                break;
            default:
                printf("Invalid choice!!!\n");
                printf("\n");
                break;
        }
    }

    return 0;
}
