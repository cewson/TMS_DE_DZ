# Задача 2.
# Условие:
# У вас есть файл raw_data.txt, который содержит "сырые" данные о транзакциях. Данные имеют неструктурированный формат и могут содержать ошибки. Пример содержимого:
# 2023-01-01:1000:Иван Иванов
# 2023-01-02:1500:Петр Петров
# 2023-01-03:2000:Мария Сидорова
# 2023-01-04:ERROR
# 2023-01-05:2500:Ольга Кузнецова
# 2023-01-06:3000:ERROR

# Задача:
# Напишите скрипт, который:
# Читает данные из файла raw_data.txt.
# Удаляет строки с ошибками (где вместо значений стоит ERROR).
# Преобразует оставшиеся данные в формат Дата,Сумма,Менеджер.
# Сохраняет очищенные данные в новый файл cleaned_data.txt.

def read_and_sort(filename):
    '''
    Docstring for ReadAndSort
    
    :param filename: Название файла

    Чтение файла и его "чистка"
    '''
    with open(filename, 'r', encoding='utf-8') as raw:
        raw_data = raw.readlines()
        for line in raw_data:
            if 'ERROR' in line:
                raw_data.remove(line)        
    return(raw_data)

def file_write(file, value):
    '''
    Docstring for fileWrite
    
    :param file: link
    :param value: information

    Запись "чистых" данных в файл
    '''
    with open(file, 'w', encoding='utf-8') as sales:
        
        for i in range(0, len(value)):
            data, sale, manager = value[i].strip().split(':')
            sales.write(f'{data}, {sale}, {manager}\n')
    return

sorted_data = read_and_sort('files/raw_data.txt')
file_write('files/cleaned_data.txt', sorted_data)

    
