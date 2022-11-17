SEÑALES (SIGNALS)

    Las señales son interrupciones de software. Permiten el manejo de eventos asíncronos.
Conceptos
    Cada señal tiene un nombre. Ellos comienzan con SIG. Ej. SIGABRT
    El archivo < signum.h > contiene la definición de todas las señales. La ubicación definitiva de las señales depende del sistema operativo de su máquina.

    Numerosas condiciones pueden generar señales. Entre ellas:

    Presionando la tecla DELETE (también control-C)
    Excepción de hardware: División por cero, referencia de memoria invalida (SIGSEGV)
    kill : existe como función y como comando. El procesador que envía debe pertenecer al mismo usuario del que recibe o ser superusuario.
    Condiciones de software. Por ejemplo: SIGALRM generada por al alarma del reloj cuando expira. SIGPIPE: cuando se escribe en una "pipe" que ha terminado por el lado lector.
    Hay tres cosas que un programa puede solicitar al kernel como acción cuando llegue una señal:
    Ignorar la señal. Sin embargo hay dos señales que no pueden ser ignoradas: SIGKILL y SIGSTOP.
    Capturar la señal. El kernel llama una función dentro del programa cuando la señal ocurre.
    Permitir que se aplique la acción por defecto. Esta puede ser: terminar el proceso, terminar con un core dump, parar el proceso, o ignorar la señal.

FUNCIÓN SIGNAL
    #include <signal.h>
    void (*signal (int signo, void (*func) (int)))(int);

Este prototipo es equivalente a:
typedef    void Sigfunc(int);
Sigfunc * signal (int signo, Sigfunc *);

signo: es el nombre de la señal.
func: puede ser la constante SIG_IGN para ignorar la señal, SIG_DFL para usar la acción por defecto, o puede ser una función definida por el programa. Esta función es conocida como el manejador de la señal (signal handler). El valor retornado es un puntero al manejador previamente instalado para esa señal.

Ejemplo: uso de SIGUSR1 y SIGUSR2

Funciones kill y raise
    kill envía us señal a un proceso o a un grupo de procesos. raise permite enviar señales al mismo proceso (hacia uno mismo).
    #include <sys/types.h>
    #include <signal.h>
    int kill (pid_t pid, int signo);

    int raise(int signo);

    Este último es como kill( getpid(), signo);

Funciones alarm y pause
    La función alarm permite especificar un timer que expire en un tiempo dado.
    La función pause suspemde al proceso llamador hasta que llegue una señal.

    #include <unistd.h>
    unsigned int alarm(unsigned int seconds);

    En nuevas versiones de sistema operativo también se puede usar
    unsigned int ualarm(unsigned int microseconds);

    int pause(void); /* retorna -1 con errno en EINTR */

    El control del tiempo no es exacto por la incertidumbre del kernel, carga del sistema, etc.
    Hay sólo una alarma por proceso!
    La alarma se puede cancelar con seconds=0 en el argumento. El valor retornado es lo que falta para que el reloj expire.

    Ejemplo 1 de uso de alarma: sleep() vía programa .
			#include	<signal.h>
			#include	<unistd.h>

			static void sig_alrm(int signo)
			{
				return;	/* nothing to do, just return to wake up the pause */
			}

			unsigned int sleep1(unsigned int nsecs)
			{
				if (signal(SIGALRM, sig_alrm) == SIG_ERR)
					return(nsecs);
				alarm(nsecs);		/* start the timer */
				pause();			/* next caught signal wakes us up */
				return( alarm(0) );	/* turn off timer, return unslept time */
			}

Función sleep
    sleep suspende al proceso llamador por una cantidad de segundos indicada o hasta que se reciba una señal.
    #include <unistd.h>
    unsiged int sleep (unsigned int seconds);

    Hoy también tenemos disponible
    unsiged int usleep(unsigned int microseconds);

    Retorna 0 ó el tiempo que no se durmió.

<<<FUENTE: http://profesores.elo.utfsm.cl/~agv/elo330/2s08/lectures/signals.html>>>
<<<OTRAS FUENTES A REVISAR: https://man7.org/linux/man-pages/man7/signal.7.html>>>
---------------------------------------------------------------------------------------------------------------------------------------------------


/* Signal number definitions.  Linux version.
   Copyright (C) 1995,1996,1997,1998,1999,2003 Free Software Foundation, Inc.
   This file is part of the GNU C Library.

   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.

   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

#ifdef        _SIGNAL_H

/* Fake signal functions.  */
#define SIG_ERR        ((__sighandler_t) -1)                /* Error return.  */
#define SIG_DFL        ((__sighandler_t) 0)                /* Default action.  */
#define SIG_IGN        ((__sighandler_t) 1)                /* Ignore signal.  */

#ifdef __USE_UNIX98
# define SIG_HOLD        ((__sighandler_t) 2)        /* Add signal to hold mask.  */
#endif


/* Signals.  */
#define        SIGHUP                1        /* Hangup (POSIX).  */
#define        SIGINT                2        /* Interrupt (ANSI).  */
#define        SIGQUIT                3        /* Quit (POSIX).  */
#define        SIGILL                4        /* Illegal instruction (ANSI).  */
#define        SIGTRAP                5        /* Trace trap (POSIX).  */
#define        SIGABRT                6        /* Abort (ANSI).  */
#define        SIGIOT                6        /* IOT trap (4.2 BSD).  */
#define        SIGBUS                7        /* BUS error (4.2 BSD).  */
#define        SIGFPE                8        /* Floating-point exception (ANSI).  */
#define        SIGKILL                9        /* Kill, unblockable (POSIX).  */
#define        SIGUSR1                10        /* User-defined signal 1 (POSIX).  */
#define        SIGSEGV                11        /* Segmentation violation (ANSI).  */
#define        SIGUSR2                12        /* User-defined signal 2 (POSIX).  */
#define        SIGPIPE                13        /* Broken pipe (POSIX).  */
#define        SIGALRM                14        /* Alarm clock (POSIX).  */
#define        SIGTERM                15        /* Termination (ANSI).  */
#define        SIGSTKFLT        16        /* Stack fault.  */
#define        SIGCLD                SIGCHLD        /* Same as SIGCHLD (System V).  */
#define        SIGCHLD                17        /* Child status has changed (POSIX).  */
#define        SIGCONT                18        /* Continue (POSIX).  */
#define        SIGSTOP                19        /* Stop, unblockable (POSIX).  */
#define        SIGTSTP                20        /* Keyboard stop (POSIX).  */
#define        SIGTTIN                21        /* Background read from tty (POSIX).  */
#define        SIGTTOU                22        /* Background write to tty (POSIX).  */
#define        SIGURG                23        /* Urgent condition on socket (4.2 BSD).  */
#define        SIGXCPU                24        /* CPU limit exceeded (4.2 BSD).  */
#define        SIGXFSZ                25        /* File size limit exceeded (4.2 BSD).  */
#define        SIGVTALRM        26        /* Virtual alarm clock (4.2 BSD).  */
#define        SIGPROF                27        /* Profiling alarm clock (4.2 BSD).  */
#define        SIGWINCH        28        /* Window size change (4.3 BSD, Sun).  */
#define        SIGPOLL                SIGIO        /* Pollable event occurred (System V).  */
#define        SIGIO                29        /* I/O now possible (4.2 BSD).  */
#define        SIGPWR                30        /* Power failure restart (System V).  */
#define SIGSYS                31        /* Bad system call.  */
#define SIGUNUSED        31

#define        _NSIG                65        /* Biggest signal number + 1
                                   (including real-time signals).  */

#define SIGRTMIN        (__libc_current_sigrtmin ())
#define SIGRTMAX        (__libc_current_sigrtmax ())

/* These are the hard limits of the kernel.  These values should not be
   used directly at user level.  */
#define __SIGRTMIN        32
#define __SIGRTMAX        (_NSIG - 1)

#endif        /* <signal.h> included.  */



<<<FUENTE:https://sites.uclouvain.be/SystInfo/usr/include/bits/signum.h.html>>>

---------------------------------------------------------------------------------------------------------



Nombre de tipo			Tamaño -byte			Tamaño –bits

char					1 byte					8 bits

int						4 bytes					32 bits

short					2 bytes					16 bits



