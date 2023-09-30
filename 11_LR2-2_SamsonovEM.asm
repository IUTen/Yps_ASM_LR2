use16
org 0x100

first_reg:
    mov ah, 0x9; Вектор для вывода строки
    mov dx, name_first_reg; Строка для вывода
    int 21h; Прерывание на вывод

    mov cx, 9; Счётчик на 8 символов + переход

main:
    mov ax, 0xba12; Задаем значение регистру, которое будем выводить
    cmp cx,8; Проверяем считываем ли мы 1ую цифру
    ja get_first_letter
    cmp cx,7; Проверяем считываем ли мы 2ую цифру
    ja get_second_letter
    cmp cx,6; Проверяем считываем ли мы 3ую цифру
    ja get_third_letter
    cmp cx,5; Проверяем считываем ли мы 4ую цифру
    ja get_fourth_letter

    cmp cx,4; Проверяем, перешли ли мы к следующему регистру
    ja second_reg

    mov ax, bx
    cmp cx,3; Проверяем считываем ли мы 1ую цифру
    ja get_first_letter
    cmp cx,2; Проверяем считываем ли мы 2ую цифру
    ja get_second_letter
    cmp cx,1; Проверяем считываем ли мы 3ую цифру
    ja get_third_letter
    cmp cx,0; Проверяем считываем ли мы 4ую цифру
    jnz get_fourth_letter

    jmp fin_

get_first_letter:
    mov dx,ax; Скопировали AX для следующих операций
    and dx, 0xf000; Обнулили все тетры, кроме старшей

    or dl,dh
    mov dh,0
	shr dl,4
    cmp dl, 0x9; Сравниваем с 9
    ja symbol_wrd; Если цифра больше 9, это буква
    jmp symbol_figure; Если цифра не больше 9, это цифра

get_second_letter:
    mov dx,ax; Скопировали AX для следующих операций
    and dx, 0x0f00; Обнулили все тетры, кроме нужной

    or dl,dh
    mov dh,0
    cmp dl, 0x09; Сравниваем с 9
    ja symbol_wrd; Если цифра больше 9, это буква
    jmp symbol_figure; Если цифра не больше 9, это цифра

get_third_letter:
    mov dx,ax; Скопировали AX для следующих операций
    and dx, 0x00f0; Обнулили все тетры, кроме нужной

    or dl,dh
    mov dh,0
	shr dl,4
    cmp dl, 0x009; Сравниваем с 9
    ja symbol_wrd; Если цифра больше 9, это буква
    jmp symbol_figure; Если цифра не больше 9, это цифра

get_fourth_letter:
    mov dx,ax; Скопировали AX для следующих операций
    and dx, 0x000f; Обнулили все тетры, кроме нужной

    or dl,dh
    mov dh,0
    cmp dl, 0x0009; Сравниваем с 9
    ja symbol_wrd; Если цифра больше 9, это буква
    jmp symbol_figure; Если цифра не больше 9, это цифра

print_symbol:
    mov ah, 0x2; Инструкция для вывода символа
    int 21h; Прерывание на вывод
    sub cx,1; Пометили, что символ выведен
    jmp main

symbol_wrd:
    add dl, 0x37; Смещение по коду ASCII, чтобы получить нужный символ
    jmp print_symbol

symbol_figure:
    add dl, 0x30; Смещение по коду ASCII, чтобы получит нужный символ
    jmp print_symbol


second_reg:
    mov ah, 0x9; Вектор для вывода строки
    mov dx, name_second_reg; Строка для вывода
    int 21h; Прерывание на вывод
    sub cx, 1; Учёт переходв к новому регистру

    mov bx, 0xde34; число для вывода
    jmp main

fin_:
    mov ax, 0
    int 20h

name_first_reg:
    db 'AX= 0x$'

name_second_reg:
    db 0xD, 0xA, 'BX= 0x$'