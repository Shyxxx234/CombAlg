import random

def generate_random_numbers(n, min_val=0, max_val=100, output_file1='numbers_line.txt', output_file2='numbers_grid.txt'):
    """
    Генерирует n*n случайных чисел и записывает их в два файла
    
    Параметры:
    n: размер матрицы (n*n чисел)
    min_val: минимальное значение случайного числа
    max_val: максимальное значение случайного числа
    output_file1: имя файла для записи по одному числу на строку
    output_file2: имя файла для записи в виде матрицы n×n
    """

    total_numbers = n * n
    random_numbers = [random.randint(min_val, max_val) for _ in range(total_numbers)]
    
    with open(output_file1, 'w', encoding='utf-8') as f1:
        f1.write(str(n) + '\n')
        for number in random_numbers:
            f1.write(str(number) + '\n')
    
    with open(output_file2, 'w', encoding='utf-8') as f2:
        for i in range(0, total_numbers, n):
            row = random_numbers[i:i+n]
            row_str = ', '.join(str(num) for num in row)
            f2.write(row_str + '\n')
    
if __name__ == "__main__":
    try:
        n = int(input("Введите размер матрицы (n для n*n чисел): "))
        if n <= 0:
            print("Размер должен быть положительным числом!")
        else:
            min_val = int(input("Введите минимальное значение (по умолчанию 0): ") or 0)
            max_val = int(input("Введите максимальное значение (по умолчанию 100): ") or 100)
            
            generate_random_numbers(n, min_val, max_val)
    except ValueError:
        print("Ошибка! Пожалуйста, введите целое число.")