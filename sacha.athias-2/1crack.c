
// Sacha ATHIAS SRS 2023

/* Lors de l'analyse du binaire crackme nous avons remarqué que c'est la fonction
 * my_streq qui s'occupe de faire la comparaison entre le serial entré par l'utilisateur
 * et celui généré par le programme crackme.
 *
 * Extrait desassemblage du binaire crackme:
 * 1. 0x08048616 <+154>:   call   0x80483e4 <my_streq>
 * 2. 0x0804861b <+159>:   test   %eax,%eax
 * 3. 0x0804861d <+161>:   je     0x8048666 <main+234>
 * 4. 0x0804861f <+163>:   movl   $0x0,-0xc(%ebp)
 * 5. 0x08048626 <+170>:   jmp    0x804863e <main+194>
 *
 * En analysant le code assembleur, on remarque que la fonction my_streq à pour objectif 
 * de comparer le serial utilisateur avec celui généré par le programme lui même. Après
 * l'appel à la fonction il y'a une vérification à la ligne 2 du retour de la fonction.
 * Si le code de retour est 0 il y'a un jump d'effectué, sinon la fonction continue.
 *
 *
 * Il existe différente afin de "bypass" le check le test du serial généré:
 * 	- Il est possible d'insérer un jump juste avant la condition afin de
 * 	sauter celle-ci
 * 	- On peut supprimer la condition
 * 	- On peut modifier la condition:
 * 		- pour retourner toujours vraie
 * 		- pour retourner le contraire de la condition initial, il est vrai
 * 		que d'un point de vue probabiliste il est très probable de trouver 
 * 		le bon "serial" correspondant à l'entrée de l'utilisateur.
 *
 * La solution qui me semble la plus facile à implémenter est la suppression du jump après
 * le test de la condition "je	0x8048666 <main+234>"
 *
 * On commence à 0x8048000 et l'instruction que l'ont veut supprimer est à "l'adresse" 0x804861d
 * (via objdump) on donc un ofset de 0x61d
 *
 * Afin de "supprimer" le jump, notre programme ajoutera deux optcodes 0x90 (nop: instruction
 * ne faisant rien) qui viendront remplacer celle d'origine.
*/

#include <unistd.h>
#include <stdio.h>

int main (int argc, char** argv)
{
	
	FILE *file;
	char buff[2];
	buff[0] = 0x90;
	buff[1] = 0x90;		// On déclare notre buffer d'écriture
	int offset = 0x61d;		// on déclare notre offset;
	file = fopen(argv[1], "r+");  	// Ici on ouvre le ficher en mode lecture + ecriture
	if (fseek(file, offset, SEEK_SET) == -1)
		return 1;
	size_t w = fwrite(buff, sizeof(char), 2, file);
	fclose(file);	
	return (0);
}
