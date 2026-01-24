# Задача 1. Создайте функцию safe_calculator(), которая:
# 1. Принимает два числа и операцию (+, -, *, /)
# 2. Использует try-except для обработки:
#    - Деления на ноль
#    - Неверного типа данных
#    - Неподдерживаемой операции
# 3. Возвращает результат или сообщение об ошибке

# Задача 2. Создайте декоратор log_calls, который:
# 1. Записывает в файл 'function_log.txt':
#    - Время вызова
#    - Имя функции
#    - Аргументы
#    - Возвращаемое значение
# 2. Подумайте как можно использовать @wraps из библиотеки functools для сохранения метаданных


import time
from functools import wraps

def log_calls(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.time()

        try:
            result = func(*args, **kwargs)
        except Exception as e:
            result = f"Ошибка: {e}"
            raise
        finally:
            with open("function_log.txt", "a", encoding="utf-8") as f:
                f.write(f"Начало выполнения:[{start_time}] \nФункция: {func.__name__}\nАргументы: {args}\nВозвращено: {result}\n")
        return result
    return wrapper

class UnsupportedOperationError(Exception): #создание ошибки
    def __str__(self):
        return "Ошибка: неподдерживаемая операция"

@log_calls
def safe_calculator(num1, num2, operation):
    try:
        if not isinstance(num1, (int, float)) or not isinstance(num2, (int, float)):
            raise ValueError("Оба аргумента должны быть числами")

        if operation == "+":
            return num1 + num2
        elif operation == "-":
            return num1 - num2
        elif operation == "*":
            return num1 * num2
        elif operation == "/":
            return num1 / num2
        else:
            raise UnsupportedOperationError

    except ZeroDivisionError:
        return "Ошибка: деление на ноль"
    except ValueError as e:
        return f"Ошибка: {e}"
    except UnsupportedOperationError as e:
        return str(e)

print(safe_calculator(10, 5, "+"))
print(safe_calculator(10, 0, "/"))
print(safe_calculator("abc", 5, "+"))
print(safe_calculator(10, 5, "%"))
