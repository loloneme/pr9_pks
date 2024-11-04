# Практическая работа №9 по Программированию корпоративных систем

## Мрясова Анастасия Александровна ЭФБО-01-22

Суть практической работы заключалась в написании серверной части на языке Golang и связке ее с приложением.
Были осуществлены редактирование, добавление, создание и изменение статуса напитка.

## Серверная часть
Серверная часть располагается в папке *backend* и имеет следующую структуру:

![image](https://github.com/user-attachments/assets/d7d934d3-21d2-4295-b910-bfd9442a57c4)

### Детали
Директория cmd содержит пакет *main* – основной пакет программы, в нем находится функция main – точка входа в программу. Переменные окружения (пока это только порт и время ожидания ответа) указаны в файле *.env*.

Директория *internal* содержит все остальные пакеты, необходимые для работы приложения. Также в проекте используется пакет log/slog, который является стандартным пакетом для Go.
Разрабатываемая серверная часть так же была поделена на три уровня:  
1. **Handler** – пакет handler для обработки HTTP запросов и передачи данных на следующий уровень. 
2. **Service** – пакет service для бизнес логики и преобразования данных перед 
обращением к базе данных, если это необходимо. 
3. **Repository** – пакет repository для работы с хранилищем и выполнения всех запросов, относящихся к ней.
Уровни связаны друг с другом от самого верхнего к самому нижнему: handler связан с service, service связан с repository, repository непосредственно связана с хранилищем приложения, в данной практической - мапой данных.

Для поднятия сервера и написания хэндлеров был использован веб-фреймворк Gin, поэтому помимо логера log/slog запросы логируются с помощью логера Gin:

![image](https://github.com/user-attachments/assets/10dbc1e8-caff-465b-8255-15d640d9e53c)


### API 

Для работы приложения на данном этапе были реализованы функции добавления нового напитка, обновления напитка, получение всех напитков или одно напитка по его ID, удаление напитка, а также изменение статуса напитка - находится он в Избранном, либо нет.

![image](https://github.com/user-attachments/assets/3c92973d-2599-4081-b610-2b329c6884cd)

### Модель

Модель напитка описана в файле entities.go в пакете *entitites*

```
type Drink struct {
	ID          int64    `json:"drink_id"`
	Name        string   `json:"name"`
	ImageURL    string   `json:"image"`
	Description string   `json:"description"`
	Compound    []string `json:"compound"`

	Cold       bool           `json:"is_cold"`
	Hot        bool           `json:"is_hot"`
	Prices     map[string]int `json:"prices"`
	IsFavorite bool           `json:"is_favorite"`
}
```

## Клиентская часть

Серверная часть располагается в папке *frontend*, для связи с бэкендом был использован пакет Dio:

```
dependencies:
  dio: ^5.7.0
```

Управление корзиной и редактирование профился все еще осуществляются только на клиентской стороне, однако все взаимодействия с самими напитками (обновление, удаление, создание) осуществляются посредством связи с серверной частью
Связь с бэкендом описана в файле api_service.dart
Форма для создания и изменения напитка вынесена в компонент drink_form.dart в папке components

Редактирование напитка не доступно из страницы с избранными напитками

![Снимок экрана 2024-11-04 184148](https://github.com/user-attachments/assets/9f24113d-cca8-4366-b168-0c46e6ec9c58)
![Снимок экрана 2024-11-04 182602](https://github.com/user-attachments/assets/a3879ae6-e9b5-4a9c-ae44-988729e79c92)


