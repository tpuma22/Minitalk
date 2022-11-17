# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: tpuma <tpuma@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/11/16 18:23:17 by tpuma             #+#    #+#              #
#    Updated: 2022/11/17 20:56:24 by tpuma            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#-----------------VARIABLES-----------------
NAME_s = server
NAME_c = client

SRC_s = server.c	\
		functions.c	\

SRC_c = client.c	\
		functions.c	\

INCLUDES = minitalk.h \
minitalk_bonus.h

OBJS_s = $(SRC_s:.c=.o)
OBJS_c = $(SRC_c:.c=.o)

#---------------BONUS-----------------------
NAME_C_B = client_bonus
NAME_S_B = server_bonus

SRC_C_B = 	client_bonus.c	\
			functions.c \

SRC_S_B = 	server_bonus.c	\
			functions.c	\

OBJS_C_B		= $(SRC_C_B:.c=.o)
OBJS_S_B		= $(SRC_S_B:.c=.o)

CC = gcc
#AR = ar crs
CFLAGS = -Wall -Werror -Wextra
RM = rm -rf
#To use colors----------
CYAN = "\\x1b[36m"
MAGENTA = "\\x1b[35m"
YELLOW = "\\x1b[33m"
GREEN = "\\x1b[32m"
RESET = "\\x1b[37m"
#_________________RULES----------------------
$(NAME_c): $(OBJS_c) $(OBJS_s)
	@echo "$(MAGENTA)Compilando y Creando Ejecutable$(RESET)"
	@$(CC) $(CFLAGS) $(OBJS_c) -o $(NAME_c)
	@$(CC) $(CFLAGS) $(OBJS_s) -o $(NAME_s)
	@echo "$(MAGENTA)Ficheros ejecutables completados$(RESET)"

$OBJS_c: $SRC_c
	@echo "$(MAGENTA)Compilando Cliente$(RESET)"
	@$(CC) $(CFLAGS) $(SRC_c)
	@echo "$(MAGENTA)Compilacion Cliente completada$(RESET)"

$OBJS_s: $SRC_s
	@echo "$(MAGENTA)Compilando Servidor$(RESET)"
	@$(CC) $(CFLAGS) $(SRC_s)
	@echo "$(MAGENTA)Compilacion Servidor completada$(RESET)"

# ========== RULES BONUS==========

$(NAME_C_B) : $(OBJS_C_B) $(OBJS_S_B)
	@echo "$(YELLOW)Compilando y Creando Ejecutable$(RESET)"
	@$(CC) $(CFLAGS) $(OBJS_C_B) -o $(NAME_C_B)
	@$(CC) $(CFLAGS) $(OBJS_S_B) -o $(NAME_S_B)
	@echo "$(YELLOW)Ficheros ejecutables completados$(RESET)"

$OBJ_C_B : $SRC_C_B
	@echo "$(YELLOW)Compilando Cliente$(RESET)"
	@$(CC) $(CFLAGS) $(SRC_C_B)
	@echo "$(YELLOW)Compilacion Cliente completada$(RESET)"

$OBJ_S_B : $SRC_S_B
	@echo "$(YELLOW)Compilando Servidor$(RESET)"
	@$(CC) $(CFLAGS) $(SRC_S_B)
	@echo "$(YELLOW)Compilacion Servidor completada$(RESET)"

#-----------------FUNCTIONS------------------
all: $(NAME_c)

bonus: $(NAME_C_B)

clean:
	@$(RM) $(OBJS_c) $(OBJS_s) $(OBJS_C_B) $(OBJS_S_B)
	@echo "$(GREEN)Cleaning$(RESET)"

fclean: clean
	@$(RM) $(NAME_c) $(NAME_s) $(NAME_C_B) $(NAME_S_B)
	@echo "$(GREEN)Forced cleaning$(RESET)"

re: fclean all

.PHONY: all clean fclean re bonus
