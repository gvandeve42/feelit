/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strerror.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gvandeve <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2016/11/24 12:43:43 by gvandeve          #+#    #+#             */
/*   Updated: 2016/11/24 12:56:22 by gvandeve         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

static void	ft_putchar(char c)
{
	write(1, &c, 1);
}

static void	ft_putstr(char *str)
{
	while(*str != '\0')
		ft_putchar(*str++);
}

int		main(int ac, char **av)
{
	char	*result;
	int		error_num;

	if (ac != 2)
		return (1);
	error_num = atoi(av[1]);
	if (error_num == 0)
		ft_putstr("Executed without error\n");
	else
	{
		ft_putstr(strerror(error_num));
		ft_putchar('\n');
	}
	return (0);
}
