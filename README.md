# Телефонный справочник сотрудников на Blazor Server (PhoneBookApp)

Среда разработки: Microsoft Visual Studio 2019 (C#, Blazor Server).

База данных: Microsoft SQL Server.

# Как запустить проект

1. Клонировать данный репозиторий на свой ПК и открыть его в Visual Studio.

2. Добавить подключение к БД MS SQL Server.

3. Выполнить скрипт на создание БД и вставку тестовых данных, который находится в файле PhoneBookDB.sql.

4. Заменить строку подключения к БД в файле appsettings.json (строку подключения можно увидеть, открыв свойства подключения к БД).

5. Запустить проект из среды Visual Studio.

# Инструкции по работе с приложением

1. Для того, чтобы отобразить список сотрудников, необходимо выбрать "Сотрудники" в навигационном меню.

2. При нажатии на идентификатор какого-либо столбца заголовка порядок изменится с нисходящего на восходящий.

3. Кнопки навигации:

- ◄ перейти на предыдущую страницу,

- ► перейти на следующую страницу,

- 1, 2, 3, ... номер страницы.

4. Для поиска сотрудников по фамилии можно ввести фамилию сотрудника в поле поиска (фамилию не обязательно вводить полностью).

5. Чтобы добавить новые данные, необходимо нажать на кнопу "Добавить сотрудника".

6. Чтобы изменить существующие данные, необходимо нажать на кнопку «Изменить».

7. Для удаления записи нужно нажать на кнопку "Удалить".


