// Version iterative
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <limits.h>

// la structure pile
struct Stack
{
unsigned capacity;
int top;
int *array;
};

// fonction pour créer une pile
struct Stack* createStack(unsigned capacity)
{
	struct Stack* stack =
		(struct Stack*) malloc(sizeof(struct Stack));
	stack -> capacity = capacity;
	stack -> top = -1;
	stack -> array =
		(int*) malloc(stack -> capacity * sizeof(int));
	return stack;
}

// fonction pour tester si pile est plein
int isFull(struct Stack* stack)
{
return (stack->top == stack->capacity - 1);
}

// fonction pour tester si pile est vide
int isEmpty(struct Stack* stack)
{
return (stack->top == -1);
}

// procedure pour empiler dans une pile
void push(struct Stack *stack, int item)
{
	if (isFull(stack))
		return;
	stack -> array[++stack -> top] = item;
}

// fonction pour dépiler d'une pile
int pop(struct Stack* stack)
{
	if (isEmpty(stack))
		return INT_MIN;
	return stack -> array[stack -> top--];
}

//procedure pour afficher les mouvement des disques
void moveDisk(char fromPeg, char toPeg, int disk)
{
	printf("Move the disk %d from \'%c\' to \'%c\'\n",
		disk, fromPeg, toPeg);
}

// fonction pour implementer une mouvement permise entre deux piquets
void moveDisksBetweenTwoPoles(struct Stack *src,
			struct Stack *dest, char s, char d)
{
	int pole1TopDisk = pop(src);
	int pole2TopDisk = pop(dest);

	// si piquet 1 est vide
	if (pole1TopDisk == INT_MIN)
	{
		push(src, pole2TopDisk);
		moveDisk(d, s, pole2TopDisk);
	}

	// si piquet 2 est vide
	else if (pole2TopDisk == INT_MIN)
	{
		push(dest, pole1TopDisk);
		moveDisk(s, d, pole1TopDisk);
	}

	// quand sommet piquet 1 > sommet piquet 2
	else if (pole1TopDisk > pole2TopDisk)
	{
		push(src, pole1TopDisk);
		push(src, pole2TopDisk);
		moveDisk(d, s, pole2TopDisk);
	}

	// quand sommet piquet 2 > sommet piquet 1
	else
	{
		push(dest, pole2TopDisk);
		push(dest, pole1TopDisk);
		moveDisk(s, d, pole1TopDisk);
	}
}

//Procedure qui implement tour de hanoi
void tohIterative(int num_of_disks, struct Stack
			*src, struct Stack *aux,
			struct Stack *dest)
{
	int i, total_num_of_moves;
	char s = 'A', d = 'C', a = 'B';

	//Si le nombre de disque est pair alors echanger le piquets destination avec l'auxiliaire
	if (num_of_disks % 2 == 0)
	{
		char temp = d;
		d = a;
		a = temp;
	}
	total_num_of_moves = pow(2, num_of_disks) - 1;

	//Le plus grand disques sont empiler d'abord
	for (i = num_of_disks; i >= 1; i--)
		push(src, i);

	for (i = 1; i <= total_num_of_moves; i++)
	{
		if (i % 3 == 1)
		moveDisksBetweenTwoPoles(src, dest, s, d);

		else if (i % 3 == 2)
		moveDisksBetweenTwoPoles(src, aux, s, a);

		else if (i % 3 == 0)
		moveDisksBetweenTwoPoles(aux, dest, a, d);
	}
}

// Programme Principal
int main()
{
	// le nombre des disques
	unsigned num_of_disks = 4;

	struct Stack *src, *dest, *aux;

	// Création de trois piles de taille égale a le nombre de disques
	src = createStack(num_of_disks);
	aux = createStack(num_of_disks);
	dest = createStack(num_of_disks);

	tohIterative(num_of_disks, src, aux, dest);
	return 0;
}



